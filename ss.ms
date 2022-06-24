function PolyKontrolPlg =
	(
		try(
			for o in selection where 
				(for m in o.modifiers where classof m == Edit_Poly collect m).count == 0 do 
					addModifier o (Edit_Poly())
					max modify mode
					subObjectLevel = 4
			)
			catch(messageBox "Obje Secin")
	)
function PolyKontrolEdg =
	(
		try (
			for o in selection where 
				(for m in o.modifiers where classof m == Edit_Poly collect m).count == 0 do 
					addModifier o (Edit_Poly())
					max modify mode
					subObjectLevel = 2
			)
		catch(messageBox "Obje Secin")
	)
function PolyKontrolVrx =
	(
		try(
	for o in selection where 
		(for m in o.modifiers where classof m == Edit_Poly collect m).count == 0 do 
			addModifier o (Edit_Poly())
			max modify mode
			subObjectLevel = 1
			)
			catch(messageBox "Obje Secin")
	)
function UvwKontrol =
	(
	for o in selection where 
		(for m in o.modifiers where classof m == Uvwmap collect m).count == 0 do 
			addModifier o (Uvwmap())
			max modify mode
	)
	
function ShellKontrol =
	(
	for o in selection where 
		(for m in o.modifiers where classof m == Shell collect m).count == 0 do 
			addModifier o (Shell())
			max modify mode
	)


rollout dialog1 "Standci" width:330 height:400
(
	GroupBox 'grp1' "Objeler" pos:[4,7] width:322 height:64 align:#left
	button 'b1' "KUTU" pos:[10,25] width:70 height:40 align:#left
	button 'b2' "ZEMIN" pos:[90,25] width:70 height:40 align:#left
	button 'b3' "SILINDIR" pos:[170,25] width:70 height:40 align:#left
 
	button 'b4' "KURE" pos:[250,25] width:70 height:40 align:#left
	
	GroupBox 'grp2' "Özellikler" pos:[4,76] width:322 height:105 align:#left
	spinner 's1' "Genislik" pos:[12,96] width:93 height:16 align:#left
	spinner 's2' "Yükselik" pos:[10,120] width:90 height:16 align:#left
	spinner 's3' "Uzunluk" pos:[183,96] width:91 height:16 align:#left
	spinner 's4' "Yaricap" pos:[182,119] width:94 height:16 range:[0,100,0] align:#left	
	spinner 'spn5' "Seg-X" pos:[20,146] width:68 height:16 range:[0,100,0] align:#left
	spinner 'spn6' "Seg-Y" pos:[117,147] width:68 height:16 range:[0,100,0] align:#left
	spinner 'spn7' "Seg-Z" pos:[214,145] width:68 height:16 range:[0,100,0] align:#left
	
	
	GroupBox 'grp5' "Modifiers" pos:[4,188] width:322 height:176 align:#left
	button 'plg_btn' "Polygon" pos:[17,208] width:54 height:24 align:#left
	
	button 'vrx_btn' "Vertex" pos:[77,209] width:54 height:24 align:#left
	button 'edg_btn' "Edge" pos:[138,208] width:54 height:24 align:#left
	button 'btn12' "Button" pos:[198,208] width:54 height:24 align:#left
	button 'btn13' "Button" pos:[258,208] width:54 height:24 align:#left
	
	button 'ext_btn' "Extrude" pos:[16,238] width:54 height:24 align:#left
	button 'bvl_btn' "Bevel" pos:[77,237] width:54 height:24 align:#left
	button 'ins_btn' "Inset" pos:[138,236] width:54 height:24 align:#left
	button 'brd_btn' "Bridge" pos:[197,236] width:54 height:24 align:#left
	button 'att_btn' "Attach" pos:[257,237] width:54 height:24 align:#left
	button 'uvw_btn' "UV Map" pos:[16,270] width:54 height:24 align:#left
	button 'shl_btn' "Shell" pos:[77,269] width:54 height:24 align:#left
	button 'chm_btn' "Chamfer" pos:[138,268] width:54 height:24 align:#left
	button 'rmv_btn' "Remove" pos:[197,268] width:54 height:24 align:#left
	button 'con_btn' "Connect" pos:[257,269] width:54 height:24 align:#left
	button 'btn25' "Bend" pos:[16,303] width:54 height:24 align:#left
	button 'btn26' "Problon" pos:[77,302] width:54 height:24 align:#left
	button 'btn27' "Line" pos:[138,301] width:54 height:24 align:#left
	button 'btn28' "Text" pos:[197,300] width:54 height:24 align:#left
	button 'btn29' "Button" pos:[257,303] width:54 height:24 align:#left
	button 'btn30' "HingeFromEdge" pos:[16,332] width:115 height:24 align:#left
	
	Timer 'clock' "testClock" pos:[13,191] width:24 height:24 interval:500 align:#left


		function AktifEt =
	(
		s1.enabled = true
		s2.enabled = true
		s3.enabled = true
		s4.enabled = true
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
	
	on ext_btn pressed do
	(
		try
		(
			obj = $
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
	(
		try
		(
			obj = $
			obj.modifiers[#Edit_Poly].SetOperation #Inset
			macros.run "Ribbon - Modeling" "EPoly_InsetOptions"
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
	on chm_btn pressed do
	(
		try
		(
		if (subObjectLevel == 1 or subObjectLevel == 2) then
		(
			obj = $
			PolyKontrolEdg()
			obj.modifiers[#Edit_Poly].SetOperation #ChamferEdge
			macros.run "Ribbon - Modeling" "EPoly_ChamferOptions"
		)
		else (messageBox "Edge ve Vertex modunda olmaniz gerekir")
		)
		catch(messageBox "Bir obje seçili degil veya bu objede Edit Poly yok.")
	)
	on rmv_btn pressed do
	(
		$.modifiers[#Edit_Poly].ButtonOp #RemoveEdge	
	)
	on con_btn pressed do
	(
		PolyKontrolEdg()
		$.modifiers[#Edit_Poly].SetOperation #ConnectEdges
		macros.run "Ribbon - Modeling" "ConnectEdgesOptions"
	)
	on uvw_btn pressed do
	(
		UvwKontrol()
	)
	on shl_btn pressed do
	(
		ShellKontrol()
	)
		on plg_btn pressed do
	(
		PolyKontrolPlg()	
	)
	on vrx_btn pressed do
	(
		PolyKontrolVrx()
	)
	on edg_btn pressed do
	(
		PolyKontrolEdg()
	)
	
	on s1 changed val do
	(
		$.width = $.width = val
	)
	on s2 changed val do
	(
		$.height = s2.value
	)
	on s3 changed val do
	(
		$.length = s3.value
	)
	on s4 changed val do
	(
		$.radius = s4.value
	)
	on spn5 changed val do
	(
		$.height = s2.value
	)
	on spn6 changed val do
	(
		$.height = s2.value
	)
	on spn7 changed val do
	(
		$.height = s2.value
	)
	
	on clock tick do
	(
		if classOf $ == Box do(
			AktifEt()
			s1.value = $.width
			s2.value = $.height
			s3.value = $.length
			s4.enabled = false
		)
		if classOf $ == Plane do(
			AktifEt()
			s1.value = $.width
			s2.enabled = false
			s3.value = $.length
			s4.enabled = false
		)
		if classOf $ == Sphere do(
			AktifEt()
			s1.enabled = false
			s2.enabled = false
			s3.enabled = false
			s4.value = $.radius
		)
		if classOf $ == Cylinder do(
			AktifEt()
			s1.enabled = false
			s2.value = $.height
			s3.enabled = false
			s4.value = $.radius
		)
	)
	
--------------------------------------------------------------	
	
	
	
	
	on btn25 pressed do
	(
		PolyKontrolPlg()
	)
	on btn26 pressed do
	(
		PolyKontrolPlg()
	)
	on btn27 pressed do
	(
		PolyKontrolEdg()
	)
	on btn28 pressed do
	(
		PolyKontrolEdg()
	)
	on btn29 pressed do
	(
		PolyKontrolEdg()
	)
	on btn30 pressed do
	(
		PolyKontrolPlg()
	)
)

CreateDialog dialog1