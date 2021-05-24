# FordProg beadandó

Szöveges állomány tartalmának feldolgozása, abból megadott elemek adatszerkezetbe, vagy a kimenetre írása, kódokkal megadott módon.

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
