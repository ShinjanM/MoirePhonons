#	by	jrmidas,	jrmidas@anadolu.edu.tr	03/08/15											
															
#	The	Stillinger-Weber	parameters	in	metal	units,	for	WS2,	from	fitting	phonon	dispersion	using	GULP.	
#	these	entries	are	in	LAMMPS	metal	units:								
#	epsilon	=	eV;	sigma	=	Angstroms									
#	other	quantities	are	unitless											
															
#	format	of	a	single	entry	(one	or	more	lines):						
#	element	1,	element	2,	element	3,									
#	epsilon,	sigma,	a,	lambda,	gamma,	costheta0,	A,	B,	p,	q,	tol				
#Element1	Element2	Element3	Epsilon	Sigma	a	lambda	gamma	costheta0	A	B	p	q	tol		
W	W	W	1.0000000000	0.1098500000	41.2380518889	0.0000000000	0.0000000000	0.0000000000	0.6120200000	686751.7186878650	4.0000000000	0.0000000000	0.0000000000	#2body	
W	Se	Se	1.0000000000	1.7403000000	1.9307016032	20.0000000000	0.7473941274	0.1513505325	10.0106300000	2.1024759871	4.0000000000	0.0000000000	0.0000000000	#2body&3body	
W	C	C	1.0000000000	1.7403000000	1.9307016032	20.0000000000	0.7473941274	0.1513505325	10.0106300000	2.1024759871	4.0000000000	0.0000000000	0.0000000000	#2body&3body	
Se	W	W	1.0000000000	1.7403000000	1.9307016032	20.0000000000	0.7473941274	0.1513505325	10.0106300000	2.1024759871	4.0000000000	0.0000000000	0.0000000000	#2body&3body	
C	W	W	1.0000000000	1.7403000000	1.9307016032	20.0000000000	0.7473941274	0.1513505325	10.0106300000	2.1024759871	4.0000000000	0.0000000000	0.0000000000	#2body&3body	
Se	C	C	1.0000000000	0.1000000000	40.2000000000	0.0000000000	0.0000000000	0.0000000000	1.6102600000	200000.0000000000	4.0000000000	0.0000000000	0.0000000000	#2body	
Se	Se	Se	1.0000000000	0.1000000000	40.2000000000	0.0000000000	0.0000000000	0.0000000000	1.6102600000	200000.0000000000	4.0000000000	0.0000000000	0.0000000000	#2body	
C	Se	Se	1.0000000000	0.1000000000	40.2000000000	0.0000000000	0.0000000000	0.0000000000	1.6102600000	200000.0000000000	4.0000000000	0.0000000000	0.0000000000	#2body	
C	C	C	1.0000000000	0.1000000000	40.2000000000	0.0000000000	0.0000000000	0.0000000000	1.6102600000	200000.0000000000	4.0000000000	0.0000000000	0.0000000000	#2body	
W	W	Se	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
W	W	C	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
W	Se	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
W	C	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
Se	W	Se	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
Se	Se	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
C	W	C	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
C	C	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
Se	Se	C	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
Se	C	Se	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
C	Se	C	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
C	C	Se	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#Like3body	(YOK)
C	W	Se	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(YOK)
Se	W	C	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(YOK)
C	Se	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(YOK)
Se	C	W	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(YOK)
W	Se	C	1.0000000000	0.0000000000	0.0000000000	0.1000000000	0.0000000000	0.1315332162	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(IMP)
W	C	Se	1.0000000000	0.0000000000	0.0000000000	0.1000000000	0.0000000000	0.1315332162	0.0000000000	0.0000000000	0.0000000000	0.0000000000	0.0000000000	#3body	(IMP)
															
															
															
															
#	The A, B, p, and q parameters are used only for two-body interactions. 														
#	The lambda and costheta0 parameters are used only for three-body interactions. 														
#	The epsilon, sigma and a parameters are used for both two-body and three-body interactions														
#	gamma is used only in the three-body interactions, but is defined for pairs of atoms. 														
#	The non-annotated parameters are unitless.														