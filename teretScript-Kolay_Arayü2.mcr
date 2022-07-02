macroScript Kolay_Arayü2 category:"teretScript" tooltip:"StandOlusturucu" Icon:#("teretS",2)
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
dikmeGenislik = 9

alyuk = 50
algen = 4

-- Kontrol
alin = false
raf = false
dikme = false
lStand = false
uStand = false

	duvar1x = ((float)standGenislik / 2) 
	duvar2y = (((float)standUzunluk / 2) - ((float)DuvarK / 2))
	ud = 0
	rollout Boxtool "Box Creator"
	(
		spinner count "Number:" type:#integer range: [1,100,10]
		spinner Yukseklik "Yukseklik:" range: [1,100,10]
		spinner Uzunluk "Uzunluk:" range: [1,100,200]
		spinner Derinlik "Derinlik:" range: [1,100,40]
		spinner distance "Distance Inbetween:" range: [1,200,25]
		pickbutton create "Create Boxes" width:120
		
		
		--GET AN OBJECT TO CREATE OTHER OBJECTS ON
		on create picked obj do
		(
			if isValidNode obj do
			(
				--GET THE MOUSE RAY FROM THE USER CLICK
				
				intRay = intersectRay obj (mapScreenToWorldRay mouse.pos)
				
				--CREATE A TRANSFORM FROM THE RAY INTERSECT WITH SURFACE
				creationTransform = matrixFromNormal intRay.dir * transMatrix intRay.pos
				--CREATE BOXES IN THE NEW TRANSFORM
				in coordsys creationTransform
				(
					undo on(
						
					b = Box()
					if ( creationTransform.row4.x == duvar1x - DuvarK / 2  ) 
					then(
						
					ud = 1
					b.length= Uzunluk.value 
					b.width= Derinlik.value 
					b.height= Yukseklik.value
					b.transform = creationTransform
					b.pos = [distance.value,0,0]
					)
					
					--ff = creationTransform.row4.y  as string
					--messageBox ff
					
					else if ( creationTransform.row4.y == duvar2y - (DuvarK / 2)  ) 
					then(
						
					ud = 2
					b.length= Uzunluk.value 
					b.width= Derinlik.value 
					b.height= Yukseklik.value
					b.transform = creationTransform
					b.pos = [distance.value,0,0]
					)
					
					else
					(
						ud = 0
						b.length= Uzunluk.value 
						b.width= Derinlik.value 
						b.height= Yukseklik.value
						b.transform = creationTransform
						b.pos = [distance.value,0,0]
					)
					
					for i in 1 to count.value do
					(
						if ud == 1 then
						(
						b2 = instance b						
						--ROTATE AND PLACE THE BOX
						b2.transform = creationTransform
						rotate b2 (AngleAxis 90 [0,0,1])
						rotate b2 (AngleAxis 90 [1,0,0])
						b2.pos = [0,-((i-1)*(distance.value)),(Derinlik.value / 2)]
						)
						else if ud == 2 then 
						(
						b2 = instance b						
						--ROTATE AND PLACE THE BOX
						b2.transform = creationTransform
						rotate b2 (AngleAxis 90 [0,1,0])
						b2.pos = [((i-1)*(distance.value)),0,(Derinlik.value/2)]
						)
						else
						(
						b2 = instance b						
						--ROTATE AND PLACE THE BOX
						b2.transform = creationTransform
						b2.pos = [0,((i-1)*(distance.value)),0]
						)
					)
					delete b
					ud = 0
				)
				)
				)
			)
		)

		tool otobox
		(
		local targ
		on mousePoint click do coordsys grid 
		(
		if click == 1 then -- create key, back & fill lights at mousedown
		(
		targ = Box pos:gridPoint isSelected:on
		targ.pos.z = 0
		)
		if click == 3 then #stop
		)
		on mouseMove click do
		(
		if click == 2 then -- drag out & round on x-y plane
		(
		targ.length = abs gridDist.y
		targ.width = abs gridDist.x
		)
		else if click == 3 then -- drag up to elevate lights
		(
		targ.height = gridDist.z
		)
		)
		)

		tool otoSPH
		(
		local targ
		on mousePoint click do coordsys grid 
		(
		if click == 1 then -- create key, back & fill lights at mousedown
		(
		targ = Sphere pos:gridPoint isSelected:on
		targ.pos.z = 0
		)
		if click == 3 then #stop
		)
		on mouseMove click do
		(
		if click == 2 then -- drag out & round on x-y plane
		(
		targ.radius = abs gridDist.x
		)
		else if click == 3 then -- drag up to elevate lights
		(
		targ.segs = gridDist.z
		)
		)
		)




--Stand
(	
	
rollout standci "Stand Olusturucu" width:203 height:334
(
	button 'btn1' "OLUSTUR" pos:[3,292] width:197 height:34 align:#left
	
	label 'lbl9' "Alin Yuk." pos:[70,173] width:52 height:14 align:#left
	label 'lbl19' "Raf Yuk." pos:[137,209] width:49 height:14 align:#left
	label 'lbl8' "Raf Uzn." pos:[137,173] width:49 height:14 align:#left
	label 'lbl7' "Raf Gen." pos:[137,140] width:45 height:14 align:#left
	label 'lbl1' "Genislik" pos:[10,140] width:37 height:14 align:#left
	label 'lbl2' "Uzunluk" pos:[10,173] width:37 height:14 align:#left
	label 'lbl3' "Alin Gen." pos:[70,140] width:52 height:14 align:#left
	label 'lbl4' "Yukseklik" pos:[10,209] width:45 height:14 align:#left
	label 'lbl5' "Duvar Kal." pos:[10,241] width:49 height:14 align:#left
	label 'lbl10' "Raf Miktar" pos:[136,241] width:49 height:14 align:#left
	label 'lbl11' "Dikme Gen." pos:[74,209] width:49 height:14 align:#left
	label 'lbl12' "Dikme Miktar" pos:[73,241] width:49 height:14 align:#left
	
	GroupBox 'grp1' "Stand Turu" pos:[3,10] width:195 height:48 align:#left
	GroupBox 'grp2' "Stand Secenekleri" pos:[3,66] width:195 height:48 align:#left
	GroupBox 'grp3' "Stand Degerleri" pos:[2,118] width:195 height:161 align:#left
	
	checkbox 'stnU' "U-Stand" pos:[96,28] width:66 height:21 align:#left
	checkbox 'stnL' "L-Stand" pos:[10,28] width:66 height:21 align:#left
	checkbox 'raf_var' "Raf" pos:[57,83] width:39 height:21 align:#left
	checkbox 'aln_var' "Alin" pos:[10,83] width:35 height:21 align:#left
	checkbox 'dik_var' "Dikme" pos:[100,83] width:42 height:21 align:#left
	
	spinner 'sprm' "" pos:[134,256] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spgen' "" pos:[7,155] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spuz' "" pos:[7,188] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spyuk' "" pos:[7,223] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	
	spinner 'spdk' "" pos:[7,255] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spag' "" pos:[70,156] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'sprg' "" pos:[134,156] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spru' "" pos:[134,188] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spay' "" pos:[70,188] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spry' "" pos:[134,224] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spmt' "" pos:[71,256] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	spinner 'spdg' "" pos:[71,224] width:55 height:16 range:[0,10000,0] type:#integer align:#left
	
	--Timer 'clocks' "standClock" pos:[16,282] width:24 height:24 interval:1000 align:#left 
 
	
	
	
	--KONTROL YAPISI
	
	-------------------------------------------
	
	--SAYAÇLAR
	
	
	
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
				
				if (lStand and alin == true) do 
				(
					aln1 = Box width: algen length:(standUzunluk) height: alyuk
					aln1.pos = [-((standGenislik / 2) - ((algen / 2) + (DuvarK / 2))),0,(standYukseklik) - (alyuk)]
					aln2 = Box width: algen length: standGenislik height: alyuk
					aln2.pos = [(DuvarK/2),-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln2 (AngleAxis 90 [0,0,1])
					kol = Box width: algen length: algen height: standYukseklik
					kol.pos = [-((standGenislik / 2) - ((algen / 2) + (DuvarK /2))),-((standUzunluk / 2) - (algen / 2)),0]
				)
				
				if (alin == true and uStand == true) do
				(
					aln1 = Box width: algen length:(standGenislik - DuvarK) height: alyuk
					aln1.pos = [0,-((standUzunluk / 2) - (algen / 2)),(standYukseklik) - (alyuk)]
					rotate aln1 (AngleAxis 90 [0,0,1])
				)
				
				if (raf) do 
				(
					i = 1
					aralik = rafmin
					rafAr = (rafmax - rafmin) / (rafMiktar)
					raf1 = Box width: rafgen length:rafuz height: rafyuk
					raf1.pos = [((float)standGenislik / 2) - (((float)rafgen / 2) + ((float)DuvarK / 2)),0,aralik]
					for i = 1 to rafMiktar do
					(
						raf2 = instance raf1
						raf2.pos = [((float)standGenislik / 2) - (((float)rafgen / 2) + ((float)DuvarK / 2)),0,aralik]
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
							dikme1 = Box width:rafgen length: dikmeGenislik height: dikmeuz
							dikme1.pos = [(((float)standGenislik / 2) - (((float)rafgen / 2) + ((float)DuvarK / 2))), aralik2, rafmin]
							aralik2 += (dikmeAr * c) * isaret
							isaret *= -1
							c +=1
							if (aralik2 < -((rafuz / 2) -  (rafyuk / 2))) do exit
						)
						
						dikmeYan = Box width:rafgen length: dikmeGenislik height: dikmeuz
						dikmeYan.pos = [(((float)standGenislik / 2) - (((float)rafgen / 2) + ((float)DuvarK / 2))),((float)(rafuz / 2) + ((float)dikmeGenislik / 2)),rafmin]
						dikmeYan2 = Box width:rafgen length: dikmeGenislik height: dikmeuz
						dikmeYan2.pos = [(((float)standGenislik / 2) - (((float)rafgen / 2) + ((float)DuvarK / 2))),-((float)(rafuz / 2) + ((float)dikmeGenislik / 2)),rafmin]
					)
				)
			)
		)
		catch
			(
				
			)
	)
	on stnU changed theState do
	(
		if theState then
			(
				 uStand = true
			)
			else
			(
				 uStand= false
			)
	)
	on stnL changed theState do
	(
		if theState then
			(
				 lStand = true
			)
			else
			(
				 lStand= false
			)
	)
	on raf_var changed theState do
	(
		if theState then
			(
				 raf = true
			)
			else
			(
				 raf= false
			)
	)
	on aln_var changed theState do
	(
		if theState then
			(
				 alin = true
			)
			else
			(
				 alin = false
			)
	)
	on dik_var changed theState do
	(
		if theState then
			( 
				 dikme = true
			)
			else
			(
				 dikme = false
			)
	)
	on sprm changed Val do
		rafMiktar= Val
	on spgen changed Val do
		standGenislik = Val
	on spuz changed Val do
		standUzunluk = Val
	on spdk changed Val do
		DuvarK = Val
	on spag changed Val do
		algen = Val
	on sprg changed Val do
		rafgen= Val
	on spru changed Val do
		rafuz= Val
	on spay changed Val do
		alyuk= Val
	on spry changed Val do
		rafyuk= Val
	on spmt changed Val do
		rafDikme = Val
	on spdg changed Val do
		dikmeGenislik= Val
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
rollout dialog1 "Genel" width:232 height:571
(
	GroupBox 'grp1' "Objeler" pos:[4,7] width:218 height:64 align:#left
	button 'b1' "KUTU" pos:[13,25] width:37 height:35 align:#left
	button 'b2' "ZEMIN" pos:[62,25] width:37 height:35 align:#left
	button 'b3' "SILINDIR" pos:[111,25] width:50 height:35 align:#left
 
	button 'b4' "KURE" pos:[179,25] width:35 height:35 align:#left
	
	GroupBox 'grp2' "Özellikler" pos:[3,84] width:221 height:185 align:#left
	spinner 's1' "Genislik" pos:[12,101] width:63 height:16 range:[0,10000,0] align:#left
	spinner 's2' "Yükselik" pos:[12,122] width:60 height:16 range:[0,10000,0] align:#left
	spinner 's3' "Uzunluk" pos:[12,145] width:61 height:16 range:[0,10000,0] align:#left
	spinner 's4' "Yaricap" pos:[12,167] width:64 height:16 range:[0,10000,0] align:#left	
	
	
	
	spinner 'ssgw' "Seg-W" pos:[115,101] width:68 height:16 range:[0,1000,0] type:#integer align:#left
	spinner 'ssgl' "Seg-L" pos:[120,123] width:68 height:16 range:[0,1000,0] type:#integer align:#left
	spinner 'ssgh' "Seg-H" pos:[118,145] width:68 height:16 range:[0,100,0] type:#integer align:#left
	spinner 'ss' "Segments" pos:[11,195] width:53 height:16 range:[0,200,0] type:#integer align:#left
	spinner 'scps' "Cap Seg" pos:[11,218] width:59 height:16 range:[0,200,0] type:#integer align:#left
	spinner 'ssd' "Sides" pos:[11,241] width:74 height:16 range:[0,200,0] type:#integer align:#left
	
	GroupBox 'grp5' "Modifiers" pos:[6,279] width:218 height:285 align:#left
	button 'plg_btn' "Polygon" pos:[20,299] width:54 height:24 align:#left
	
	button 'vrx_btn' "Vertex" pos:[21,329] width:54 height:24 align:#left
	button 'edg_btn' "Edge" pos:[21,359] width:54 height:24 align:#left
	button 'ttt_btn' "Nokta Raf" pos:[135,300] width:54 height:24 align:#left
	
	button 'ext_btn' "Extrude" pos:[79,299] width:54 height:24 align:#left
	button 'bvl_btn' "Bevel" pos:[80,328] width:54 height:24 align:#left
	button 'ins_btn' "Inset" pos:[82,417] width:54 height:24 align:#left
	button 'brd_btn' "Bridge" pos:[81,389] width:54 height:24 align:#left
	button 'att_btn' "Attach" pos:[20,417] width:54 height:24 align:#left
	button 'uvw_btn' "UV Map" pos:[81,473] width:54 height:24 align:#left
	button 'shl_btn' "Shell" pos:[21,473] width:54 height:24 align:#left
	button 'chm_btn' "Chamfer" pos:[80,359] width:54 height:24 align:#left
	button 'rmv_btn' "Remove" pos:[20,445] width:54 height:24 align:#left
	button 'con_btn' "Connect" pos:[81,445] width:54 height:24 align:#left
	button 'bnd_btn' "Bend" pos:[21,389] width:54 height:24 align:#left
	button 'lne_btn' "Line" pos:[22,502] width:54 height:24 align:#left
	button 'txt_btn' "Text" pos:[81,502] width:54 height:24 align:#left
	button 'hin_btn' "HingeFromEdge" pos:[21,531] width:115 height:24 align:#left
	
	Timer 'clock' "testClock" pos:[16,282] width:24 height:24 interval:1000 align:#left


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
	
	
	on b1 pressed do
	(
		startTool otobox
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
		startTool otoSPH
	)
	on s1 changed val do
	(
		try($.width = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on s2 changed val do
	(
		try($.height = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on s3 changed val do
	(
		try($.length = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on s4 changed val do
	(
		try($.radius = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on ssgw changed val do
	(
		try($.widthsegs = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on ssgl changed val do
	(
		try($.lengthsegs = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on ssgh changed val do
	(
		try($.heightsegs = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on ss changed val do
	(
		try($.segs = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on scps changed val do
	(
		try($.capsegs = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on ssd changed val do
	(
		try($.sides = val)catch(messageBox "Objede bu özellik yok veya modifiye edilmis. ")
	)
	on plg_btn pressed do
	(
		PolyKontrol 3
	)
	on vrx_btn pressed do
	(
		PolyKontrol 1
	)
	on edg_btn pressed do
	(
		PolyKontrol 2
	)
	on ttt_btn pressed do
	(
			MainFloater = NewRolloutFloater "Nokta Raf" 250 150
			addRollout Boxtool MainFloater
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
	on bnd_btn pressed do
	(
		if classOf $ != UndefinedClass then(
		BendKontrol()
			)
		else(messageBox "Obje Seçiniz")
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
	on clock tick do
	(
		try(
		if  classOf $ == UndefinedClass then 
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
		else if classOf $ == Box then
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
		else if classOf $ == Plane then
		(
			AktifEt()
			DeAktifEt 2
			s1.value = $.width
			s3.value = $.length
			ssgw.value = $.widthsegs
			ssgl.value = $.lengthsegs
		)
		else if classOf $ == Sphere then
		(
			AktifEt()
			DeAktifEt 3
			s4.value = $.radius
			ss.value = $.segs			
		)
		else if classOf $ == Cylinder then
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
nFloater = newRolloutFloater "StandCreator" 240 400
addRollout standci nFloater
addRollout dialog1 nFloater
cui.registerDialogBar nFloater
cui.dockDialogBar nFloater #cui_dock_right
)