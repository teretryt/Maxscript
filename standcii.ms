--Özellikler
standGenislik = 300
standUzunluk = 500
standYukseklik = 360
DuvarK = 4

rafuz = 280
rafgen = 40
rafyuk = 4
rafAr = 0
rafmin = 50
rafmax = 250
rafMiktar = 9
rafDikme = 4
dikmeAr = 0

alyuk = 50
algen = 4

-- Kontrol
alin = false
raf = false
dikme = false
lStand = false
uStand = false

rollout standci "Stand Olusturucu" width:204 height:330
(
	button 'btn1' "OLUSTUR" pos:[3,292] width:197 height:34 align:#left
	
	label 'lbl9' "Alin Yuk." pos:[65,173] width:52 height:14 align:#left
	label 'lbl19' "Raf Yuk." pos:[128,209] width:49 height:14 align:#left
	label 'lbl8' "Raf Uzn." pos:[128,173] width:49 height:14 align:#left
	label 'lbl7' "Raf Gen." pos:[128,140] width:45 height:14 align:#left
	label 'lbl1' "Genislik" pos:[10,140] width:37 height:14 align:#left
	label 'lbl2' "Uzunluk" pos:[10,173] width:37 height:14 align:#left
	label 'lbl3' "Alin Gen." pos:[65,140] width:52 height:14 align:#left
	label 'lbl4' "Yukseklik" pos:[10,209] width:45 height:14 align:#left
	label 'lbl5' "Duvar Kal." pos:[10,245] width:49 height:14 align:#left
	label 'lbl10' "Raf Miktar" pos:[127,241] width:49 height:14 align:#left
	
	GroupBox 'grp1' "Stand T�r�" pos:[3,10] width:195 height:48 align:#left
	GroupBox 'grp2' "Stand Se�enekleri" pos:[3,66] width:195 height:48 align:#left
	GroupBox 'grp3' "Stand Degerleri" pos:[2,122] width:195 height:171 align:#left
	
	checkbox 'stnU' "U-Stand" pos:[96,28] width:66 height:21 align:#left
	checkbox 'stnL' "L-Stand" pos:[10,28] width:66 height:21 align:#left
	checkbox 'raf_var' "Raf" pos:[57,83] width:39 height:21 align:#left
	checkbox 'aln_var' "Alin" pos:[10,83] width:35 height:21 align:#left
	checkbox 'dik_var' "Dikme" pos:[100,83] width:42 height:21 align:#left
	
	spinner 'sprm' "" pos:[125,256] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spgen' "" pos:[7,155] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spuz' "" pos:[7,188] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spyuk' "" pos:[7,224] width:55 height:16 range:[0,1000,0] align:#left	
	spinner 'spdk' "" pos:[7,260] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spag' "" pos:[65,156] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'sprg' "" pos:[125,156] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spru' "" pos:[125,188] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spay' "" pos:[65,188] width:55 height:16 range:[0,1000,0] align:#left
	spinner 'spry' "" pos:[125,224] width:55 height:16 range:[0,1000,0] align:#left
	
	
	
	
	
	
	on btn1 pressed do
	(
		try
			(
				
			if ( ( lStand == false and uStand == false ) or ( lStand  and uStand ) ) do 
				(
					messageBox "Lütfen stand türü seçiniz."
					return 1
				)
			
			if ( lStand or uStand ) do
			(
				
				zemin = Plane width: standGenislik length: standUzunluk
				duvar1 = Box width: DuvarK length: standUzunluk height: standYukseklik
				duvar1.pos = [(standGenislik / 2 ) - (DuvarK / 2), 0, 0]
				duvar2 = Box width: DuvarK length: standGenislik height: standYukseklik
				duvar2.pos = [0, (standUzunluk / 2 ) - (DuvarK / 2), 0]
				rotate duvar2 (angleaxis 90 [0,0,1])
				if (uStand) do 
				(
					duvar3 = Box width: DuvarK length: standUzunluk height: standYukseklik
					duvar3.pos = [-(standGenislik / 2 ) + (DuvarK / 2), 0, 0]
				)
				
				if (alin and lStand) do 
				(
					aln1 = Box width: algen length:standUzunluk height: alyuk
					aln1.pos = [-((standGenislik / 2) - (algen / 2)),0,(standYukseklik) - (alyuk)]
					aln2 = Box width: algen length:standGenislik height: alyuk
					aln2.pos = [0,-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln2 (AngleAxis 90 [0,0,1])
				)
				
				if (alin and uStand) do
				(
					aln1 = Box width: algen length:standGenislik height: alyuk
					aln1.pos = [0,-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln1 (AngleAxis 90 [0,0,1])
				)
				
				if (raf) do 
				(
					i = 1
					aralık = rafmin
					rafAr = (rafmax - rafmin) / (rafMiktar)
					for i = 1 to rafMiktar do
					(
						raf1 = Box width: rafgen length:rafuz height: rafyuk
						raf1.pos = [(standGenislik / 2) - (rafgen / 2),0,aralık]
						aralık += rafAr 
						if (aralık >= rafmax) do exit
					)
					
					if (dikme) do
					(
						tek = false
						isaret = -1
						c = 1
						dikmeuz = ((aralık - (rafmin + rafAr)) + (rafyuk))
						dikmeAr = (rafuz / (rafDikme + 1))
							
						if (mod rafDikme 2 == 0) then 
							(
								aralık2 = dikmeAr / 2
							) 
							else
							(
								aralık2 = 0 
								tek = true 
							)
							
						for i = 1 to rafDikme do
						(
							dikme1 = Box width:rafgen length: rafyuk height: dikmeuz
							dikme1.pos = [(standGenislik / 2) - (rafgen / 2), aralık2, rafmin]
							aralık2 += (dikmeAr * c) * isaret
							isaret *= -1
							c +=1
							if (aralık2 < -((rafuz / 2) -  (rafyuk / 2))) do exit
						)
					)
				)
			)
		)
		catch
			(
				
			)
	)
	
	--KONTROL YAPISI
	on stnU changed theState do
	(
		if theState then
			(
				 messagebox "bump on" 
				 uStand = true
			)
			else
			(
				 messagebox "bump off"
				 uStand= false
			)
	)
	on stnL changed theState do
	(
		if theState then
			(
				 messagebox "bump on" 
				 lStand = true
			)
			else
			(
				 messagebox "bump off"
				 lStand= false
			)
	)
	on raf_var changed theState do
	(
		if theState then
			(
				 messagebox "bump on" 
				 raf = true
			)
			else
			(
				 messagebox "bump off"
				 raf= false
			)
	)
	on aln_var changed theState do
	(
		if theState then
			(
				 messagebox "bump on" 
				 alin = true
			)
			else
			(
				 messagebox "bump off"
				 alin = false
			)
	)
	on dik_var changed theState do
	(
		if theState then
			(
				 messagebox "bump on" 
				 dikme = true
			)
			else
			(
				 messagebox "bump off"
				 dikme = false
			)
	)
	
	-------------------------------------------
	
	--SAYAÇLAR
	
	on spgen changed Val do standGenislik = Val
	on spuz changed Val do standUzunluk = Val
	on spyukchanged Val do standYukseklik = Val
	on spdk changed Val do DuvarK = Val
	on spag changed Val do algen = Val
	on spay changed Val do alyuk= Val
	on sprg changed Val do rafgen= Val
	on spru changed Val do rafuz= Val	
	on spry changed Val do rafyuk= Val
    on sprm changed Val do rafMiktar= Val			
)



CreateDialog standci