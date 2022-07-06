"""
    Written by Shinjan Mandal as an utility for Moire Phonons
    Github repo: https://github.com/ShinjanM/MoirePhonons
    Email : mshinjan@iisc.ac.in
"""
import numpy as np
from pyphutil.distribute_lists import distribute, get_color_and_keys
from pyphutil.progress import printProgressBar
import h5py
import matplotlib.pyplot as plt


class finite_temperature():
    """
        Computes the dynamical properties of the system at finite temperature.
        The user must generate the trajectory files from LAMMPS in the 
        format shown in the examples and convert them to hdf5
    """

    def __init__(self,
                 at_types,
                 total_time_steps,
                 delta_time,
                 natom,
                 mass,
                 temperature):
        """
            natom :: Number of atoms of each type of atom in unitcell, not the
                     total number of atoms.
        """

        self.at_types = at_types
        self.num_at_types = len(at_types)
        self.total_time_steps = total_time_steps
        self.delta_time = delta_time
        self.natom = natom
        self.mass = mass
        self.temperature = temperature
        self.kbt = 8.6173303/(10**2) * temperature
    
    def set_traj_file(self,traj_file):
        """
            Set the trajectory file.
        """
        self.traj_file = traj_file
        return

    
    def convert_to_hdf5(self,
                        location,
                        no_seg_files,
                        output_file):
        """
            Convert the trajectory files to HDF5 for easy parsing
            

            Input
            -----

            location     :: location of the segmented trajectory files
            no_seg_files :: Number of segmented files
            output_file  :: Name of the output file 
                        

            The segments should be named as "(attype)pos.1"/"(attype)vel.1", 
            e.g. for atom types {Mo1, S1, S2 ...} the segments should be named as:

                            "Mo1pos.1","Mo1pos.2", ...
                            "Mo1vel.1","Mo1vel.2", ...
                            "S1pos.1" ,"S1pos.2" , ...
                                     
                                      .
                                      .
                                      .

                                  and so on.

            The segments can be created by following the example for generating 
            trajectories at finite temperature in LAMMPS.
            Refer to the Examples folder.

        """
        comm = MPI.COMM_WORLD
        rank = comm.Get_rank()
        size = comm.Get_size()

        split_prefix_pos = 'newpos.'
        split_prefix_vel = 'newvel.'
        
        output_file_handle = h5py.File(output_file,'a',driver='mpio',comm=comm)
        for at_type in self.at_types:
            d1 = output_file_handle.create_dataset("position_%s"%at_type, 
                        (self.total_time_steps,self.natom,3), dtype=np.float64)
            d2 = output_file_handle.create_dataset("velocity_%s"%at_type, 
                        (self.total_time_steps,self.natom,3), dtype=np.float64)
            time_steps_completed = 0
            for i in range(no_seg_files):
                fposname = location+at_type+'pos.%d'%(i+1)
                fvelname = location+at_type+'vel.%d'%(i+1)
                if rank==0:
                    os.system('split -l %d -a 3 -d %s %s'%(self.natom+9,fposname,split_prefix_pos))
                    os.system('split -l %d -a 3 -d %s %s'%(self.natom+9,fvelname,split_prefix_vel))
                comm.Barrier()
                a = len(glob.glob1('./',"%s*"%split_prefix_pos))
                if rank==0:
                    print("Number of time points in %s is %d"%(fposname,a),flush=True)
                    print("Number of time points in %s is %d"%(fvelname,a),flush=True)
                comm.Barrier()
    
                if i==(no_seg_files-1):
                    time_steps_in_file = a
                else:
                    time_steps_in_file = a-1
    
                f_index = ['%08d'%i for i in range(time_steps_in_file)]
                loc_f_index = distribute(f_index, rank, size)
    
                for l in loc_f_index:
                    pos = np.loadtxt('%s%08d'%(split_prefix_pos,int(l)),skiprows=9,usecols=(1,2,3))
                    vel = np.loadtxt('%s%08d'%(split_prefix_vel,int(l)),skiprows=9,usecols=(1,2,3))
                    d1[int(l)+time_steps_completed] = pos
                    d2[int(l)+time_steps_completed] = vel
                time_steps_completed += time_steps_in_file
    
                comm.Barrier()
                
                if rank==0:
                    os.system('rm %s*'%split_prefix_pos)
                    os.system('rm %s*'%split_prefix_vel)
                comm.Barrier()

                if rank==0:
                    print("%s done"%fposname,flush=True)
                    print("%s done"%fvelname,flush=True)
        comm.Barrier()
        output_file_handle.close()
        return



    def dos(self,output_file="dos.dat"):
        
        """
            Compute the density of states via the fourier transform of the 
            velocity autocorrelation.

            Ref: Moire Phonons paper
        """

        from scipy.fft import fft,fftshift,fftfreq, next_fast_len
        
        world_comm = MPI.COMM_WORLD
        world_rank = world_comm.Get_rank()
        world_size = world_comm.Get_size()

        dos = np.zeros((self.total_time_steps,),dtype=float)

        if world_size >= self.num_at_types:
            ngroups = self.num_at_types
        else:
            ngroups = world_size

        color, key = get_color_and_keys(world_rank, world_size, ngroups)
        group_comm = world_comm.Split(color,key)
        group_rank = group_comm.Get_rank()
        group_size = group_comm.Get_size()

        # Atom types are distributed over MPI groups
        local_at_type = distribute(self.at_types, color, ngroups)
        nlocal_at_type = len(local_at_type)

        # The number of atoms are distributed over processes in each group.
        global_natom_group = [n for n in range(self.natom)]
        local_natom_group = distribute(global_natom_group, group_rank, group_size)

        traj_handle = h5py.File(self.traj_file,'r')

        for at_type in local_at_type:
            for n in local_natom_group:
                v = traj_handle['velocity_%s'%at_type][:self.total_time_steps,n,:]
                for j in range(3):
                    autocorr_w = np.abs(fft(v[:,j])**2).real
                    autocorr_w /= autocorr_w[0]
                    dos += autocorr_w*self.mass[self.at_types.index(at_type)]
        
        world_comm.Barrier()
        world_comm.allreduce(dos, op=MPI.SUM)
        group_comm.Free()

        if world_rank==0:
            dos /= 3*self.kbt*self.natom*self.num_at_types
            omega = fftshift(np.arange(-self.total_time_steps//2,
                                        self.total_time_steps//2,dtype=float))
            omega *= 33.356*1000/(self.delta_time*(self.total_time_steps-1))
            f = open(output_file,'w')
            for i in range(self.total_time_steps):
                f.write("%f\t%f\n"%(omega[i],dos[i]))
            f.close()
        
        return