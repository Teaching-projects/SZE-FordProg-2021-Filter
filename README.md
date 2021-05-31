# FordProg beadandó

Szöveges állomány tartalmának feldolgozása, abból megadott elemek adatszerkezetbe, vagy a kimenetre írása, parancskódokkal megadott módon.

Példa a parancs szerkezetére:
'#u#b#iasdf#r2#e#ilkjh#r-1#t2#p#f#'

	b = szakasz kezdete
	e = szakasz vége
	i = case insens. keresés stringre
	c = case sens. keresés stringre
	g = keresés regex kóddal
	r = a találat kezdetének rel. pozíciója az (i|c|g)-ben megadott pozícióhoz képest
	o = darabszámmal megadott többszörözés kezdete 
	t = darabszámmal megadott többszörözés darabszáma
	u = végfeltétellel megadott többszörözés kezdete
	x = végfeltétellel megadott többszörözés végfeltétele
	s = a megelőző kinyert tartalom adatszerkezetbe írása
	n = soremelés beszúrása
	p = kimenetre írás
	f = parancsok vége jel

A parancsok argumentum tipusai ('' = nincs argumentum):

	b = ''
	e = ''
	i = 'string'
	c = 'string'
	g = 'string'
	r = 'int32'
	o = ''
	t = 'int32'
	u = ''
	x = 'string'
	s = 'string'
	n = ''
	p = ''
	f = ''


 	1 	2 	3 	4 	5 	6 	7 	8 	9 	10 	11 	12 	13 	14 	15 	16 	17 	18 	19 	20 	21 	22 	23
0 	b 	  	  	ou 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
1 	  	icg 	r 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
2 	  	  	r 	  	  	  	  	  	  	  	e 	  	  	  	  	  	  	  	  	  	  	  	 
3 	b 	  	  	  	  	  	  	e 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
4 	  	  	  	  	b 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
5 	  	  	  	  	  	icg 	r 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
6 	  	  	  	  	  	  	r 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
7 	  	  	  	  	  	  	  	  	  	  	  	  	e 	  	  	  	  	  	  	  	  	  	 
8 	  	  	  	  	  	  	  	  	icg 	r 	  	  	  	  	  	  	  	  	  	  	  	  	 
9 	b 	  	  	ou 	  	  	  	  	  	r 	n 	s 	  	  	  	  	  	  	  	  	  	  	f
10 	b 	  	  	ou 	  	  	  	  	  	  	n 	s 	  	  	  	  	  	  	  	  	  	  	f
11 	b 	  	  	ou 	  	  	  	  	  	  	  	s 	  	  	  	  	  	  	  	  	  	  	f
12 	b 	  	  	ou 	  	  	  	  	  	  	n 	  	  	  	  	  	  	  	  	  	  	  	f
13 	  	  	  	  	  	  	  	  	  	  	  	  	  	icg 	r 	  	  	  	  	  	  	  	 
14 	b 	  	  	  	  	  	  	  	  	  	  	  	  	  	r 	n 	s 	x 	  	t 	  	  	 
15 	b 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	n 	s 	  	  	  	  	  	 
16 	b 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	s 	x 	  	t 	  	  	 
17 	b 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	n 	  	x 	  	t 	  	  	 
18 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	icg 	r 	  	  	 
19 	b 	  	  	ou 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	r 	n 	s 	f
20 	b 	  	  	ou 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	n 	s 	f
21 	b 	  	  	ou 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	s 	f
22 	b 	  	  	ou 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	n 	  	f
23 	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	 
