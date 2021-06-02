## FordProg beadandó

### Rövid ismertetés
Szöveges állomány tartalmának feldolgozása, abból megadott elemek adatszerkezetbe, vagy a kimenetre írása, parancskódokkal megadott módon.

### Példa a parancs szerkezetére:
'#b#r0#e#g-----\r\n#r5#n#u#b#g\r\n\s{2}#r4#e#g\d{1,3}[.]\d{1,3}#r-1#n#sarray1#b#g\r\n\s{2}#x#iconcurr#r-1#f#'

### Magyarázat:  
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
	f = parancsok vége jel

### A parancsok argumentum tipusai ('' = nincs argumentum):

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
	f = ''

## A fejlesztés körülményei
A texlex.ps1 Windows 10 alatt a Powershell 5.1.18362.1474 verziójával került fejlesztésre.  
A program paraméterei: param([string]$cmd='', [string]$file='', $split = '#')  
* cmd = a parancs  
* file = a szöveges állomány teljes elérési útja
* split az alapértelmezett "#" elválasztó karaktert opcionálisan meg lehet adni más karakternek.  
 A program indítható parancssorról. A fenti parancs és a hozzá tartozó szöveges állománnyal a program indítása PS promptról:  
. D:\_EGYETEMI\FordProg\texlex.ps1 '#b#r0#e#g-----\r\n#r5#n#u#b#g\r\n\s{2}#r4#e#g\d{1,3}[.]\d{1,3}#r-1#n#sarray1#b#g\r\n\s{2}#x#iconcurr#r-1#f#' "D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt"  
 
A program válasza:  
  
INFO:  input data:   #b#r0#e#g-----\r\n#r5#n#u#b#g\r\n\s{2}#r4#e#g\d{1,3}[.]\d{1,3}#r-1#n#sarray1#b#g\r\n\s{2}#x#iconcurr#r-1#f#  
   D:\_EGYETEMI\FordProg\INGR_lizenz_roh.txt  
  
   INFO:  file valid  
  
   INFO:  splitter literal :  #  
  
   INFO:  command syntactically valid  
  
   INFO:  Command sequence processed succsesfully  
  
   OUTPUT:  
  
  SPLM: Displaying Seats In Use...
<p>SPLM             Seat Grade  
Seat Checkout      /Daily       Prod.         Client     Client          Client  
No.  Time          Expires Pid  Tag   Batch   Name       Address         Node</p>  
<p>--------------------------------------------------------------------------------  
<p> 4 04-Feb-21 07:40 3D    17940 3D   Regular  robert  </p>
<p>13 04-Feb-21 07:15 SPP   31388 SPP  Regular  rgiglberg  </p>
<p>14 04-Feb-21 07:36 SPP   1436 SPP  Regular  klimstein  </p>
<p>18 04-Feb-21 07:15 CW3   11208 CW3  Regular  Matyschok  </p>
<p>23 04-Feb-21 06:38 S3D   27688 S3D  Regular  oroz  </p>
<p>24 04-Feb-21 07:15 S3D   11208 S3D  Regular  Matyschok  </p>
<p>25 04-Feb-21 07:38 S3D   9416 S3D  Regular  Neumaier  </p>
  
  
   DATA STRUCTURES:  
  
  
Name                           Value  
----                           -----  
array1...                      { 4 04-Feb-21 07:40 3D    17940 3D   Regular  robert     ...  

