macroScript Kolay_Arayü2 category:"teretScript" tooltip:"StandOlusturucu" Icon:#("teretS",2)
(



--Stand
(
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

rollout standci "Stand Olusturucu"
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
	
	GroupBox 'grp1' "Stand T?r?" pos:[3,10] width:195 height:48 align:#left
	GroupBox 'grp2' "Stand Se?enekleri" pos:[3,66] width:195 height:48 align:#left
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
				zemin.pos.x = DuvarK / 2
				duvar1 = Box width: DuvarK length: standUzunluk height: standYukseklik
				duvar1.pos = [(standGenislik / 2 ), 0, 0]
				duvar2 = Box width: DuvarK length: standGenislik height: standYukseklik
				duvar2.pos = [DuvarK / 2, (standUzunluk / 2 ) - (DuvarK / 2), 0]
				rotate duvar2 (angleaxis 90 [0,0,1])
				if (uStand == true) do 
				(
					duvar3 = Box width: DuvarK length: standUzunluk height: standYukseklik
					duvar3.pos = [-(standGenislik / 2 ) + (DuvarK), 0, 0]
				)
				
				if (alin == true) do 
				(
					aln1 = Box width: algen length:(standUzunluk - DuvarK) height: alyuk
					aln1.pos = [-((standGenislik / 2) - (algen / 2)),0,(standYukseklik) - (alyuk)]
					aln2 = Box width: algen length:standGenislik height: alyuk
					aln2.pos = [0,-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln2 (AngleAxis 90 [0,0,1])
				)
				
				if (alin == true and uStand == true) do
				(
					aln1 = Box width: algen length:standGenislik - DuvarK height: alyuk
					aln1.pos = [0,-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln1 (AngleAxis 90 [0,0,1])
				)
				
				if (raf) do 
				(
					i = 1
					aralik = rafmin
					rafAr = (rafmax - rafmin) / (rafMiktar)
					raf1 = Box width: rafgen length:rafuz height: rafyuk
					raf1.pos = [(standGenislik / 2) - ((rafgen / 2) + (DuvarK / 2)),0,aralik]
					for i = 1 to rafMiktar do
					(
						raf2 = instance raf1
						raf2.pos = [(standGenislik / 2) - ((rafgen / 2) + (DuvarK / 2)),0,aralik]
						aralik += rafAr 
						if (aralik >= rafmax) do (exit)
					)
					delete raf1
					
					if (dikme) do
					(
						tek = false
						isaret = -1
						c = 1
						dikmeuz = ((aralik - (rafmin + rafAr)) + (rafyuk))
						dikmeAr = (rafuz / (rafDikme + 1))
							
						if (mod rafDikme 2 == 0) then 
							(
								aralik2 = dikmeAr / 2
							) 
							else
							(
								aralik2 = 0 
								tek = true 
							)
							
						for i = 1 to rafDikme do
						(
							dikme1 = Box width:rafgen length: rafyuk height: dikmeuz
							dikme1.pos = [(standGenislik / 2) - (rafgen / 2), aralik2, rafmin]
							aralik2 += (dikmeAr * c) * isaret
							isaret *= -1
							c +=1
							if (aralik2 < -((rafuz / 2) -  (rafyuk / 2))) do exit
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
)
--Genel
(
--Fonksiyonlar
(
function PolyKontrol modVal =
	(
		try(
			for o in selection where 
				(for m in o.modifiers where classof m == Edit_Poly collect m).count == 0 do 
					addModifier o (Edit_Poly())
					max modify mode
					modPanel.setCurrentObject $.modifiers[#Edit_Poly]
					if modVal == 3 then (subObjectLevel = 4)
					if modVal == 2 then (subObjectLevel = 2)
					if modVal == 1 then (subObjectLevel = 1)
			)
			catch(messageBox "Obje Secin")
	)
function UvwKontrol =
	(
	for o in selection where 
		(for m in o.modifiers where classof m == Uvwmap collect m).count == 0 do 
			addModifier o (Uvwmap())
			max modify mode
			modPanel.setCurrentObject $.modifiers[#UVW_Map]	
	)
	
function ShellKontrol =
	(
	for o in selection where 
		(for m in o.modifiers where classof m == Shell collect m).count == 0 do 
			addModifier o (Shell())
			max modify mode
			modPanel.setCurrentObject $.modifiers[#Shell]
	)


function BendKontrol =
	(
	for o in selection where 
		(for m in o.modifiers where classof m == Bend collect m).count == 0 do 
			addModifier o (Bend())
			max modify mode
			modPanel.setCurrentObject $.modifiers[#Bend]
	)
)
rollout dialog1 "Genel"
(
	GroupBox 'grp1' "Objeler" pos:[4,7] width:322 height:64 align:#left
	button 'b1' "KUTU" pos:[10,25] width:70 height:40 align:#left
	button 'b2' "ZEMIN" pos:[90,25] width:70 height:40 align:#left
	button 'b3' "SILINDIR" pos:[170,25] width:70 height:40 align:#left
 
	button 'b4' "KURE" pos:[250,25] width:70 height:40 align:#left
	
	GroupBox 'grp2' "Özellikler" pos:[4,76] width:322 height:136 range:[0,1000,0] align:#left
	spinner 's1' "Genislik" pos:[12,96] width:93 height:16 range:[0,1000,0] align:#left
	spinner 's2' "Yükselik" pos:[10,120] width:90 height:16 range:[0,1000,0] align:#left
	spinner 's3' "Uzunluk" pos:[183,96] width:91 height:16 range:[0,1000,0] align:#left
	spinner 's4' "Yaricap" pos:[182,119] width:94 height:16 range:[0,1000,0] align:#left	
	
	
	spinner 'ssgw' "Seg-W" pos:[20,146] width:68 height:16 range:[0,1000,0] type:#integer align:#left
	spinner 'ssgl' "Seg-L" pos:[117,147] width:68 height:16 range:[0,1000,0] type:#integer align:#left
	spinner 'ssgh' "Seg-H" pos:[214,145] width:68 height:16 range:[0,100,0] type:#integer align:#left
	spinner 'ss' "Segments" pos:[20,171] width:54 height:16 range:[0,200,0] type:#integer align:#left
	spinner 'scps' "Cap Seg" pos:[117,173] width:55 height:16 range:[0,200,0] type:#integer align:#left
	spinner 'ssd' "Sides" pos:[214,171] width:70 height:16 range:[0,200,0] type:#integer align:#left
	
	GroupBox 'grp5' "Modifiers" pos:[3,215] width:322 height:176 align:#left
	button 'plg_btn' "Polygon" pos:[17,235] width:54 height:24 align:#left
	
	button 'vrx_btn' "Vertex" pos:[77,236] width:54 height:24 align:#left
	button 'edg_btn' "Edge" pos:[138,235] width:54 height:24 align:#left
	button 'button1x' "Button" pos:[198,235] width:54 height:24 align:#left
	button 'btn13' "Button" pos:[258,235] width:54 height:24 align:#left
	
	button 'ext_btn' "Extrude" pos:[16,265] width:54 height:24 align:#left
	button 'bvl_btn' "Bevel" pos:[77,264] width:54 height:24 align:#left
	button 'ins_btn' "Inset" pos:[138,263] width:54 height:24 align:#left
	button 'brd_btn' "Bridge" pos:[197,263] width:54 height:24 align:#left
	button 'att_btn' "Attach" pos:[257,264] width:54 height:24 align:#left
	button 'uvw_btn' "UV Map" pos:[16,297] width:54 height:24 align:#left
	button 'shl_btn' "Shell" pos:[77,296] width:54 height:24 align:#left
	button 'chm_btn' "Chamfer" pos:[138,295] width:54 height:24 align:#left
	button 'rmv_btn' "Remove" pos:[197,295] width:54 height:24 align:#left
	button 'con_btn' "Connect" pos:[257,296] width:54 height:24 align:#left
	button 'bnd_btn' "Bend" pos:[16,330] width:54 height:24 align:#left
	button 'btn26' "Problon" pos:[77,329] width:54 height:24 align:#left
	button 'lne_btn' "Line" pos:[138,328] width:54 height:24 align:#left
	button 'txt_btn' "Text" pos:[197,327] width:54 height:24 align:#left
	button 'btn29' "Button" pos:[257,330] width:54 height:24 align:#left
	button 'hin_btn' "HingeFromEdge" pos:[16,359] width:115 height:24 align:#left
	
	Timer 'clock' "testClock" pos:[13,218] width:24 height:24 interval:500 align:#left


		function AktifEt =
	(
		s1.enabled = true
		s2.enabled = true
		s3.enabled = true
		s4.enabled = true
		ss.enabled = true
		scps.enabled = true
		ssd.enabled = true
		ssgw.enabled = true
		ssgl.enabled = true
		ssgh.enabled = true
	)
		function DeAktifEt val=
	(
		izin = val
		if izin == 0 do
		(
			s1.enabled = false
			s2.enabled = false
			s3.enabled = false
			s4.enabled = false
			ss.enabled = false
			scps.enabled = false
			ssd.enabled = false
			ssgw.enabled = false
			ssgl.enabled = false
			ssgh.enabled = false
		)
		if izin == 1 do
		(
			s4.enabled = false
			ss.enabled = false
			ssd.enabled = false
			scps.enabled = false
		)
		if izin == 2 do
		(
			s2.enabled = false
			s4.enabled = false
			ss.enabled = false
			ssd.enabled = false
			scps.enabled = false
			ssgh.enabled = false
		)
		if izin == 3 do
		(
			s1.enabled = false
			s2.enabled = false
			s3.enabled = false
			ssd.enabled = false
			scps.enabled = false
			ssgw.enabled = false
			ssgl.enabled = false
			ssgh.enabled = false
		)
		if izin == 4 do
		(
			s1.enabled = false
			s3.enabled = false
			ss.enabled = false
			ssgw.enabled = false
			ssgl.enabled = false
		)
	)
	
	

	
--------------------------------------------------------------	
	on ttt pressed do(
		startTool foo
	)
	on b1 pressed do
	(
		obj = Box()
		select obj
		max modify mode
	)
	on b2 pressed do
	(
		obj = Plane()
		select obj
		max modify mode
	)
	on b3 pressed do
	(
		obj = Cylinder()
		select obj
		max modify mode
	)
	on b4 pressed do
	(
		obj = Sphere()
		select obj
		max modify mode
	)
	on s1 changed val do
	(
		$.width = val
	)
	on s2 changed val do
	(
		$.height = val
	)
	on s3 changed val do
	(
		$.length = val
	)
	on s4 changed val do
	(
		$.radius = val
	)
	on ssgw changed val do
	(
		$.widthsegs = val
	)
	on ssgl changed val do
	(
		$.lengthsegs = val
	)
	on ssgh changed val do
	(
		$.heightsegs = val
	)
	on ss changed val do
	(
		$.segs = val
	)
	on scps changed val do
	(
		$.capsegs = val
	)
	on ssd changed val do
	(
		$.sides = val
	)
	on plg_btn pressed do
	(
		PolyKontrol 3
	)
	on vrx_btn pressed do
	(
		PolyKontrol 1
	)
	on lne_btn pressed do
	(
		obj = line()
		select obj
		macros.run "Editable Spline Object" "ESpline_Create_Line"
	)
	on txt_btn pressed do
	(
		obj = text()
		select obj
		max modify mode
	)
	on hin_btn pressed do
	(
		try
		(
			if (subObjectLevel == 4) then
			(
				obj = $
				obj.modifiers[#Edit_Poly].SetOperation #HingeFromEdge
				macros.run "Ribbon - Modeling" "EPoly_HingeOptions"
			)
			else 
			(
				messageBox "Polygon modunda olmaniz gerekir"
			)
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on edg_btn pressed do
	(
		PolyKontrol 2
	)
	on bnd_btn pressed do
	(
		if classOf $ != UndefinedClass then(
		BendKontrol()
			)
		else(messageBox "Obje Seçiniz")
	)
	on ext_btn pressed do
	(
		try
		(
			obj = $
			modPanel.setCurrentObject $.modifiers[#Edit_Poly]
			obj.modifiers[#Edit_Poly].SetOperation #ExtrudeFace
			macros.run "Ribbon - Modeling" "EPoly_ExtrudeOptions"
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on bvl_btn pressed do
	(
		try
		(
			if (subObjectLevel == 4) then
			(
				obj = $
				obj.modifiers[#Edit_Poly].SetOperation #Bevel
				macros.run "Ribbon - Modeling" "EPoly_BevelOptions"
			)
			else 
			(
				messageBox "Polygon modunda olmaniz gerekir"
			)
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on ins_btn pressed do
	(		try
		(
			if (subObjectLevel == 4) then(
			obj = $
			obj.modifiers[#Edit_Poly].SetOperation #Inset
			macros.run "Ribbon - Modeling" "EPoly_InsetOptions")
			else (messageBox "Poly moda geçiniz.")
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on brd_btn pressed do
	(
		try
		(
			if (subObjectLevel == 4 or subObjectLevel == 2 ) then
			(
				obj = $
				obj.modifiers[#Edit_Poly].SetOperation #BridgePolygon
				macros.run "Ribbon - Modeling" "PolyBridgeOptions"
			)
			else(messageBox "Polygon veya Edge modunda olmaniz gerekir")
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on att_btn pressed do
	(
		try
		(	
		if (getCurrentSelection()).count == 1 do messageBox "Attach islemi için en az 2 obje seçmelisiniz."
		while (getcurrentselection()).count > 1 do polyop.attach (convertToPoly $[1]) $[2]
		)
		catch(messageBox "Islem yapilamadi.")
	)
	on uvw_btn pressed do
	(
		if (classOf $ != UndefinedClass) then (
		UvwKontrol())
		else(messageBox "Bir obje seçiniz")
	)
	on shl_btn pressed do
	(
		if (classOf $ != UndefinedClass) then (
		ShellKontrol())
		else(messageBox "Bir obje seçiniz")
	)
	on chm_btn pressed do
	(
		try
		(
		if (subObjectLevel == 1 or subObjectLevel == 2) then
		(
			obj = $
			obj.modifiers[#Edit_Poly].SetOperation #ChamferEdge
			macros.run "Ribbon - Modeling" "EPoly_ChamferOptions"
		)
		else (messageBox "Edge ve Vertex modunda olmaniz gerekir")
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on rmv_btn pressed do
	(
		try
		(
		$.modifiers[#Edit_Poly].ButtonOp #RemoveEdge	
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on con_btn pressed do
	(
		try(
		if (subObjectLevel == 1 or subObjectLevel == 2 ) then(
		$.modifiers[#Edit_Poly].SetOperation #ConnectEdges
		macros.run "Ribbon - Modeling" "ConnectEdgesOptions")
		else(messageBox "Edge veya Vertex modunda olmaniz gerekir"))
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on btn25 pressed do
	(
		--PolyKontrol()
	)
	on btn26 pressed do
	(
		--PolyKontrolPlg()
	)
	on btn27 pressed do
	(
		--PolyKontrolEdg()
	)
	on btn28 pressed do
	(
		--PolyKontrolEdg()
	)
	on btn29 pressed do
	(
		--PolyKontrolEdg()
	)
	on btn30 pressed do
	(
		--PolyKontrolPlg()
	)
	
	
	on clock tick do
	(
		try(
		if classOf $ == UndefinedClass or classOf $ == ModifierClass do 
		(
			s1.value = 0
			s2.value = 0
			s3.value = 0
			s4.value = 0
			ssgw.value = 0
			ssgl.value = 0
			ssgh.value	= 0
			scps.value = 0
			ssd.value= 0
			DeAktifEt 0
		)
		if classOf $ == Box do
		(
			AktifEt()
			DeAktifEt 1
			s1.value = $.width
			s2.value = $.height
			s3.value = $.length			
			ssgw.value = $.widthsegs
			ssgl.value = $.lengthsegs
			ssgh.value = $.heightsegs
		)
		if classOf $ == Plane do
		(
			AktifEt()
			DeAktifEt 2
			s1.value = $.width
			s3.value = $.length
			ssgw.value = $.widthsegs
			ssgl.value = $.lengthsegs
		)
		if classOf $ == Sphere do
		(
			AktifEt()
			DeAktifEt 3
			s4.value = $.radius
			ss.value = $.segs			
		)
		if classOf $ == Cylinder do
		(
			AktifEt()
			DeAktifEt 4
			s2.value = $.height
			s4.value = $.radius
			ssgh.value = $.heightsegs
			scps.value = $.capsegs
			ssd.value = $.sides
		)
	)
	catch()
	)
)
)
nFloater = newRolloutFloater "StandCreator" 400 400
addRollout standci nFloater
addRollout dialog1 nFloater
cui.registerDialogBar nFloater
cui.dockDialogBar nFloater #cui_dock_right
)