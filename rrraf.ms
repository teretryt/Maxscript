(
	duvar1x = 150
	duvar2y = 248
	DuvarK  = 4
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
					do(
						
					ud = 1
					b.length= Uzunluk.value 
					b.width= Derinlik.value 
					b.height= Yukseklik.value
					b.transform = creationTransform
					b.pos = [distance.value,0,0]
					)
					
					ff = creationTransform.row4.y  as string
					messageBox ff
					
					if ( creationTransform.row4.y == duvar2y - (DuvarK / 2)  ) 
					do(
						
					ud = 2
					b.length= Uzunluk.value 
					b.width= Derinlik.value 
					b.height= Yukseklik.value
					b.transform = creationTransform
					b.pos = [distance.value,0,0]
					)
					
					for i in 1 to count.value do
					(
						if ud == 1 do
						(
						b2 = instance b						
						--ROTATE AND PLACE THE BOX
						b2.transform = creationTransform
						rotate b2 (AngleAxis 90 [0,0,1])
						rotate b2 (AngleAxis 90 [1,0,0])
						b2.pos = [0,-((i-1)*(distance.value)),(Derinlik.value / 2)]
						)
						if ud == 2 do 
						(
						b2 = instance b						
						--ROTATE AND PLACE THE BOX
						b2.transform = creationTransform
						rotate b2 (AngleAxis 90 [0,1,0])
						b2.pos = [((i-1)*(distance.value)),0,(Derinlik.value/2)]
						)
					)
					delete b
					ud = 0
				)
				)
				)
			)
		)
 
	)
 
	MainFloater = NewRolloutFloater "Box Creator" 250 150
	addRollout Boxtool MainFloater