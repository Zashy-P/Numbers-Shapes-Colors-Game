#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;=======================================================================================
;************************************ structs ******************************************
;=======================================================================================

;World --> Scene, Character, LeaderBoard(not now later)
(define-struct world (scene character)) ;leaderBoard)) will do leaderBoard Later

;Character --> image(skin), pos(x,y)
(define-struct Character (skin pos))
(define-struct ChPos (x y))
;skin --> name direction
(define-struct skin(name direction))
;skinD --> west east south north
(define-struct skinD(west east south north))

;world's center width and height
(define worldCenterWidth 960)
(define worldCenterHeight 540)

;lobby's center width and height
(define lobbyCenterWidth 1010)
(define lobbyCenterHeight 700)

;=======================================================================================
;************************************ Images *******************************************
;=======================================================================================
;Character skins

;boy skin
;(define skinBoyWest(bitmap "Photos/Characters/boy/boy_left_side.png"))
;(define skinBoyEast(bitmap "Photos/Characters/boy/boy right side.png"))
;(define skinBoyNorth(bitmap "Photos/Characters/boy/boy_backside.png"))
;(define skinBoySouth(bitmap "Photos/Characters/boy/boy_frontside.png"))
;define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;Janitor skin
(define skinJanitorWest(bitmap "Photos/Characters/janitor/janitor left side.png"))
(define skinJanitorEast(bitmap "Photos/Characters/janitor/janitor right side.png"))
(define skinJanitorNorth(bitmap "Photos/Characters/janitor/janitor backside.png"))
(define skinJanitorSouth(bitmap "Photos/Characters/janitor/janitor frontside.png"))
(define janitorSkin (make-skinD skinJanitorWest skinJanitorEast skinJanitorSouth skinJanitorNorth))

;Scientist skin
(define skinScientistWest (bitmap "Photos/Characters/scientist/scientist left side.png"))
(define skinScientistEast (bitmap "Photos/Characters/scientist/scientist right side.png"))
(define skinScientistNorth (bitmap "Photos/Characters/scientist/scientist backside.png"))
(define skinScientistSouth (bitmap "Photos/Characters/scientist/scientist frontside.png"))
(define scientistSkin (make-skinD skinScientistWest skinScientistEast skinScientistSouth skinScientistNorth))

;Police woman skin
(define skinPoliceWomanWest (bitmap "Photos/Characters/police woman/police woman leftside.png"))
(define skinPoliceWomanEast (bitmap "Photos/Characters/police woman/police woman right side.png"))
(define skinPoliceWomanNorth (bitmap "Photos/Characters/police woman/police woman backside.png"))
(define skinPoliceWomanSouth (bitmap "Photos/Characters/police woman/police woman frontside.png"))
(define policeWomanSkin (make-skinD skinPoliceWomanWest skinPoliceWomanEast skinPoliceWomanSouth skinPoliceWomanNorth))

;boy colors skins
;red
(define redBoyWest (bitmap "Photos/Charcters with paint buckets/boy/1 red/red_boy_leftside.png"))
(define redBoyEast (bitmap "Photos/Charcters with paint buckets/boy/1 red/red_boy_rightside.png"))
(define redBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/1 red/red_boy_backside.png"))
(define redBoySouth (bitmap "Photos/Charcters with paint buckets/boy/1 red/red_boy_frontside.png"))
(define redBoySkin (make-skinD redBoyWest redBoyEast redBoySouth redBoyNorth))
;orange
(define orangeBoyWest (bitmap "Photos/Charcters with paint buckets/boy/2 orange/orange_boy_leftside.png"))
(define orangeBoyEast (bitmap "Photos/Charcters with paint buckets/boy/2 orange/orange_boy_rightside.png"))
(define orangeBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/2 orange/orange_boy_backside.png"))
(define orangeBoySouth (bitmap "Photos/Charcters with paint buckets/boy/2 orange/orange_boy_frontside.png"))
(define orangeBoySkin (make-skinD orangeBoyWest orangeBoyEast orangeBoySouth orangeBoyNorth))
;yellow
(define yellowBoyWest (bitmap "Photos/Charcters with paint buckets/boy/3 yellow/yellow_boy_leftside.png"))
(define yellowBoyEast (bitmap "Photos/Charcters with paint buckets/boy/3 yellow/yellow_boy_rightside.png"))
(define yellowBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/3 yellow/yellow_boy_backside.png"))
(define yellowBoySouth (bitmap "Photos/Charcters with paint buckets/boy/3 yellow/yellow_boy_frontside.png"))
(define yellowBoySkin (make-skinD yellowBoyWest yellowBoyEast yellowBoySouth yellowBoyNorth))
;green
(define greenBoyWest (bitmap "Photos/Charcters with paint buckets/boy/4 green/green_boy_leftside-removebg-preview.png"))
(define greenBoyEast (bitmap "Photos/Charcters with paint buckets/boy/4 green/green_boy_rightside-removebg-preview.png"))
(define greenBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/4 green/green_boy_backside-removebg-preview.png"))
(define greenBoySouth (bitmap "Photos/Charcters with paint buckets/boy/4 green/green_boy_frontside-removebg-preview.png"))
(define greenBoySkin (make-skinD greenBoyWest greenBoyEast greenBoySouth greenBoyNorth))
;blue
(define blueBoyWest (bitmap "Photos/Charcters with paint buckets/boy/5 blue/blue_boy_leftside-removebg-preview.png"))
(define blueBoyEast (bitmap "Photos/Charcters with paint buckets/boy/5 blue/blue_boy_rightside-removebg-preview.png"))
(define blueBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/5 blue/blue_boy_backside-removebg-preview.png"))
(define blueBoySouth (bitmap "Photos/Charcters with paint buckets/boy/5 blue/blue_boy_frontside-removebg-preview.png"))
(define blueBoySkin (make-skinD blueBoyWest blueBoyEast blueBoySouth blueBoyNorth))
;purple
(define purpleBoyWest (bitmap "Photos/Charcters with paint buckets/boy/6 purple/purple_boy_leftside-removebg-preview.png"))
(define purpleBoyEast (bitmap "Photos/Charcters with paint buckets/boy/6 purple/purple_boy_rightsdie-removebg-preview.png"))
(define purpleBoyNorth (bitmap "Photos/Charcters with paint buckets/boy/6 purple/purple_boy_backside-removebg-preview.png"))
(define purpleBoySouth (bitmap "Photos/Charcters with paint buckets/boy/6 purple/purple_boy_frontsdie-removebg-preview.png"))
(define purpleBoySkin (make-skinD purpleBoyWest purpleBoyEast purpleBoySouth purpleBoyNorth))

;janitor colors skins
;red
(define redJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/1 red/red_janitor_leftside-removebg-preview.png"))
(define redJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/1 red/red_janitor_rightside-removebg-preview.png"))
(define redJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/1 red/red_janitor_backside-removebg-preview.png"))
(define redJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/1 red/red_janitor_frontside-removebg-preview.png"))
(define redJanitorSkin (make-skinD redJanitorWest redJanitorEast redJanitorSouth redJanitorNorth))
;orange
(define orangeJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/2 orange/orange_janitor_leftside-removebg-preview.png"))
(define orangeJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/2 orange/orange_janitor_rightside-removebg-preview.png"))
(define orangeJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/2 orange/orange_janitor_backside-removebg-preview.png"))
(define orangeJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/2 orange/orange_janitor_frontside-removebg-preview.png"))
(define orangeJanitorSkin (make-skinD orangeJanitorWest orangeJanitorEast orangeJanitorSouth orangeJanitorNorth))
;yellow
(define yellowJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/3 yellow/yellow_janitor_leftside-removebg-preview.png"))
(define yellowJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/3 yellow/yellow_janitor_rightside-removebg-preview.png"))
(define yellowJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/3 yellow/yellow_janitor_backside-removebg-preview.png"))
(define yellowJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/3 yellow/yellow_janitor_frontside-removebg-preview.png"))
(define yellowJanitorSkin (make-skinD yellowJanitorWest yellowJanitorEast yellowJanitorSouth yellowJanitorNorth))
;green
(define greenJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/4 green/green_janitor_leftside-removebg-preview.png"))
(define greenJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/4 green/green_janitor_rightside-removebg-preview.png"))
(define greenJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/4 green/green_janitor__backside-removebg-preview.png"))
(define greenJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/4 green/green_janitor_frontside-removebg-preview.png"))
(define greenJanitorSkin (make-skinD greenJanitorWest greenJanitorEast greenJanitorSouth greenJanitorNorth))
;blue
(define blueJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/5 blue/blue_janitor__leftside-removebg-preview.png"))
(define blueJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/5 blue/blue_janitor_rightside-removebg-preview.png"))
(define blueJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/5 blue/blue_janitor__backside-removebg-preview.png"))
(define blueJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/5 blue/blue_janitor__frontside-removebg-preview.png"))
(define blueJanitorSkin (make-skinD blueJanitorWest blueJanitorEast blueJanitorSouth blueJanitorNorth))
;purple
(define purpleJanitorWest (bitmap "Photos/Charcters with paint buckets/janitor/6 purple/purple_janitor_leftside-removebg-preview.png"))
(define purpleJanitorEast (bitmap "Photos/Charcters with paint buckets/janitor/6 purple/purple_janitor_rightside-removebg-preview.png"))
(define purpleJanitorNorth (bitmap "Photos/Charcters with paint buckets/janitor/6 purple/purple_janitor_backside-removebg-preview.png"))
(define purpleJanitorSouth (bitmap "Photos/Charcters with paint buckets/janitor/6 purple/purple_janitor_frontside-removebg-preview.png"))
(define purpleJanitorSkin (make-skinD purpleJanitorWest purpleJanitorEast purpleJanitorSouth purpleJanitorNorth))

;PoliceWoman colors skins
;red
(define redPoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/1 red/red_police_woman_leftside-.png"))
(define redPoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/1 red/red_police_woman_rightside-.png"))
(define redPoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/1 red/red_police_woman_backside-.png"))
(define redPoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/1 red/red_police_woman_frontside-.png"))
(define redPoliceWomanSkin (make-skinD redPoliceWomanWest redPoliceWomanEast redPoliceWomanSouth redPoliceWomanNorth))
;orange
(define orangePoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/2 orange/orange_police_woman_leftside-removebg-preview.png"))
(define orangePoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/2 orange/orange_police_woman_rightside-removebg-preview.png"))
(define orangePoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/2 orange/orange_police_woman_backside-removebg-preview.png"))
(define orangePoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/2 orange/orange_police_woman_frontside-removebg-preview.png"))
(define orangePoliceWomanSkin (make-skinD orangePoliceWomanWest orangePoliceWomanEast orangePoliceWomanSouth orangePoliceWomanNorth))
;yellow
(define yellowPoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/3 yellow/yellow_police_woman_leftside-removebg-preview.png"))
(define yellowPoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/3 yellow/yellow_police_woman_rightside-removebg-preview.png"))
(define yellowPoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/3 yellow/yellow_police_woman_backside-removebg-preview.png"))
(define yellowPoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/3 yellow/yellow_police_woman_frontside-removebg-preview.png"))
(define yellowPoliceWomanSkin (make-skinD yellowPoliceWomanWest yellowPoliceWomanEast yellowPoliceWomanSouth yellowPoliceWomanNorth))
;green
(define greenPoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/4 green/green_police_womnan__leftside-removebg-preview.png"))
(define greenPoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/4 green/green_police_womnan__rightside-removebg-preview.png"))
(define greenPoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/4 green/green_police_womnan__backside-removebg-preview.png"))
(define greenPoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/4 green/green_police_womnan_frontside-removebg-preview.png"))
(define greenPoliceWomanSkin (make-skinD greenPoliceWomanWest greenPoliceWomanEast greenPoliceWomanSouth greenPoliceWomanNorth))
;blue
(define bluePoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/5 blue/blue_police_woman_leftside-removebg-preview.png"))
(define bluePoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/5 blue/blue_police_woman_rightside-removebg-preview.png"))
(define bluePoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/5 blue/blue_police_woman_backside-removebg-preview.png"))
(define bluePoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/5 blue/blue_police_woman_frontside-removebg-preview.png"))
(define bluePoliceWomanSkin (make-skinD bluePoliceWomanWest bluePoliceWomanEast bluePoliceWomanSouth bluePoliceWomanNorth))
;purple
(define purplePoliceWomanWest (bitmap "Photos/Charcters with paint buckets/police woman/6 purple/purple_police_woman_leftside-removebg-preview.png"))
(define purplePoliceWomanEast (bitmap "Photos/Charcters with paint buckets/police woman/6 purple/purple_police_woman_rightside-removebg-preview.png"))
(define purplePoliceWomanNorth (bitmap "Photos/Charcters with paint buckets/police woman/6 purple/purple_police_woman_backside-removebg-preview.png"))
(define purplePoliceWomanSouth (bitmap "Photos/Charcters with paint buckets/police woman/6 purple/purple_police_woman_frontside-removebg-preview.png"))
(define purplePoliceWomanSkin (make-skinD purplePoliceWomanWest purplePoliceWomanEast purplePoliceWomanSouth purplePoliceWomanNorth))

;Scientist colors skins
;red
(define redScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/1 red/red_scientist_leftside-removebg-preview.png"))
(define redScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/1 red/red_scientist_rightside-removebg-preview.png"))
(define redScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/1 red/red_scientist_backside-removebg-preview.png"))
(define redScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/1 red/red_scientist_frontside-removebg-preview.png"))
(define redScientistSkin (make-skinD redScientistWest redScientistEast redScientistSouth redScientistNorth))
;orange
(define orangeScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/2 orange/orange_scientist_leftside-removebg-preview.png"))
(define orangeScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/2 orange/orange_scientist_rightside-removebg-preview.png"))
(define orangeScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/2 orange/orange_scientist_backside-removebg-preview.png"))
(define orangeScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/2 orange/orange_scientist_frontside-removebg-preview.png"))
(define orangeScientistSkin (make-skinD orangeScientistWest orangeScientistEast orangeScientistSouth orangeScientistNorth))
;yellow
(define yellowScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/3 yellow/yellow_scientist_leftside-removebg-preview.png"))
(define yellowScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/3 yellow/yellow_scientsist_rightside-removebg-preview.png"))
(define yellowScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/3 yellow/yellow_scientist_backside-removebg-preview.png"))
(define yellowScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/3 yellow/yellow_scientist_frontside-removebg-preview.png"))
(define yellowScientistSkin (make-skinD yellowScientistWest yellowScientistEast yellowScientistSouth yellowScientistNorth))
;green
(define greenScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/4 green/green_scientist_leftside-removebg-preview.png"))
(define greenScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/4 green/green_scientist_rightside-removebg-preview.png"))
(define greenScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/4 green/green_scientist_backside-removebg-preview.png"))
(define greenScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/4 green/green_scientist_frontside-removebg-preview.png"))
(define greenScientistSkin (make-skinD greenScientistWest greenScientistEast greenScientistSouth greenScientistNorth))
;blue
(define blueScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/5 blue/blue_scientist_rightside-removebg-preview.png"))
(define blueScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/5 blue/blue_scientist_leftside-removebg-preview.png"))
(define blueScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/5 blue/blue_scientist_backside-removebg-preview.png"))
(define blueScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/5 blue/blue_scientist___frontside-removebg-preview.png"))
(define blueScientistSkin (make-skinD blueScientistWest blueScientistEast blueScientistSouth blueScientistNorth))
;purple
(define purpleScientistWest (bitmap "Photos/Charcters with paint buckets/scientist/6 purple/purple_scientist_leftside-removebg-preview.png"))
(define purpleScientistEast (bitmap "Photos/Charcters with paint buckets/scientist/6 purple/purple_scientist_rightside-removebg-preview.png"))
(define purpleScientistNorth (bitmap "Photos/Charcters with paint buckets/scientist/6 purple/purple_scientist_backside-removebg-preview.png"))
(define purpleScientistSouth (bitmap "Photos/Charcters with paint buckets/scientist/6 purple/purple_scientist_frontside-removebg-preview.png"))
(define purpleScientistSkin (make-skinD purpleScientistWest purpleScientistEast purpleScientistSouth purpleScientistNorth))

;Boy shape skins 

;circle Boy
(define circleBoyWest (bitmap "Photos/Characters with shapes/boy/circle boy/circle boy leftside.png"))
(define circleBoyEast (bitmap "Photos/Characters with shapes/boy/circle boy/circle boy rightside.png"))
(define circleBoyNorth (bitmap "Photos/Characters with shapes/boy/circle boy/circle boy backside.png"))
(define circleBoySouth (bitmap "Photos/Characters with shapes/boy/circle boy/circle boy frontside.png"))
(define circleBoySkin (make-skinD circleBoyWest circleBoyEast circleBoySouth circleBoyNorth))

;pentagon Boy
(define pentagonBoyWest (bitmap "Photos/Characters with shapes/boy/pentagon boy/pentagon boy leftside.png"))
(define pentagonBoyEast (bitmap "Photos/Characters with shapes/boy/pentagon boy/pentagon boy rightside.png"))
(define pentagonBoyNorth (bitmap "Photos/Characters with shapes/boy/pentagon boy/pentagon boy backside.png"))
(define pentagonBoySouth (bitmap "Photos/Characters with shapes/boy/pentagon boy/pentagon boy frontside.png"))
(define pentagonBoySkin (make-skinD pentagonBoyWest pentagonBoyEast pentagonBoySouth pentagonBoyNorth))

;rectangle Boy
(define rectangleBoyWest (bitmap "Photos/Characters with shapes/boy/rectangle boy/rectangle boy leftside.png"))
(define rectangleBoyEast (bitmap "Photos/Characters with shapes/boy/rectangle boy/rectangle boy rightside.png"))
(define rectangleBoyNorth (bitmap "Photos/Characters with shapes/boy/rectangle boy/rectangle boy backside.png"))
(define rectangleBoySouth (bitmap "Photos/Characters with shapes/boy/rectangle boy/rectangle boy frontside.png"))
(define rectangleBoySkin (make-skinD rectangleBoyWest rectangleBoyEast rectangleBoySouth rectangleBoyNorth))

;square Boy
(define squareBoyWest (bitmap "Photos/Characters with shapes/boy/square boy/square boy leftside.png"))
(define squareBoyEast (bitmap "Photos/Characters with shapes/boy/square boy/square boy rightside.png"))
(define squareBoyNorth (bitmap "Photos/Characters with shapes/boy/square boy/square boy  backside.png"))
(define squareBoySouth (bitmap "Photos/Characters with shapes/boy/square boy/square boy  frontside.png"))
(define squareBoySkin (make-skinD squareBoyWest squareBoyEast squareBoySouth squareBoyNorth))

;triangle Boy
(define triangleBoyWest (bitmap "Photos/Characters with shapes/boy/triangle boy/triagnle boy leftside.png"))
(define triangleBoyEast (bitmap "Photos/Characters with shapes/boy/triangle boy/boy triangle rightside.png"))
(define triangleBoyNorth (bitmap "Photos/Characters with shapes/boy/triangle boy/triagnle boy backside.png"))
(define triangleBoySouth (bitmap "Photos/Characters with shapes/boy/triangle boy/triagnle boy frontside.png"))
(define triangleBoySkin (make-skinD triangleBoyWest triangleBoyEast triangleBoySouth triangleBoyNorth))

;circle Janitor
(define circleJanitorWest (bitmap "Photos/Characters with shapes/janitor/circle janitor/circle police woman leftside.png"))
(define circleJanitorEast (bitmap "Photos/Characters with shapes/janitor/circle janitor/circle janitor rightside.png"))
(define circleJanitorNorth (bitmap "Photos/Characters with shapes/janitor/circle janitor/circle janitor backside.png"))
(define circleJanitorSouth (bitmap "Photos/Characters with shapes/janitor/circle janitor/circle police woman frontside.png"))
(define circleJanitorSkin (make-skinD circleJanitorWest circleJanitorEast circleJanitorSouth circleJanitorNorth))

;pentagon Janitor
(define pentagonJanitorWest (bitmap "Photos/Characters with shapes/janitor/pentagon janitor/pentagon janitor leftsid.png"))
(define pentagonJanitorEast (bitmap "Photos/Characters with shapes/janitor/pentagon janitor/pentagon janitor rightside.png"))
(define pentagonJanitorNorth (bitmap "Photos/Characters with shapes/janitor/pentagon janitor/pentagon janitor backside.png"))
(define pentagonJanitorSouth (bitmap "Photos/Characters with shapes/janitor/pentagon janitor/pentagon janitor frontdside.png"))
(define pentagonJanitorSkin (make-skinD pentagonJanitorWest pentagonJanitorEast pentagonJanitorSouth pentagonJanitorNorth))

;rectangle Janitor
(define rectangleJanitorWest (bitmap "Photos/Characters with shapes/janitor/rectangle janitor/rectangle janitor leftside.png"))
(define rectangleJanitorEast (bitmap "Photos/Characters with shapes/janitor/rectangle janitor/rectangle janitor rightside.png"))
(define rectangleJanitorNorth (bitmap "Photos/Characters with shapes/janitor/rectangle janitor/rectangle janitor backside.png"))
(define rectangleJanitorSouth (bitmap "Photos/Characters with shapes/janitor/rectangle janitor/rectangle janitor frontside.png"))
(define rectangleJanitorSkin (make-skinD rectangleJanitorWest rectangleJanitorEast rectangleJanitorSouth rectangleJanitorNorth))

;square Janitor
(define squareJanitorWest (bitmap "Photos/Characters with shapes/janitor/sqaure janitor/square janitor leftside.png"))
(define squareJanitorEast (bitmap "Photos/Characters with shapes/janitor/sqaure janitor/square janitor rightside.png"))
(define squareJanitorNorth (bitmap "Photos/Characters with shapes/janitor/sqaure janitor/square janitor backside.png"))
(define squareJanitorSouth (bitmap "Photos/Characters with shapes/janitor/sqaure janitor/square janitor frontside.png"))
(define squareJanitorSkin (make-skinD squareJanitorWest squareJanitorEast squareJanitorSouth squareJanitorNorth))

;triangle Janitor
(define triangleJanitorWest (bitmap "Photos/Characters with shapes/janitor/triangle janitor/triangle janitor leftside.png"))
(define triangleJanitorEast (bitmap "Photos/Characters with shapes/janitor/triangle janitor/triangle janitor rightside.png"))
(define triangleJanitorNorth (bitmap "Photos/Characters with shapes/janitor/triangle janitor/triagnle janitor backside.png"))
(define triangleJanitorSouth (bitmap "Photos/Characters with shapes/janitor/triangle janitor/triagnle janitor frontside.png"))
(define triangleJanitorSkin (make-skinD triangleJanitorWest triangleJanitorEast triangleJanitorSouth triangleJanitorNorth))

;circle PoliceWoman
(define circlePoliceWomanWest (bitmap "Photos/Characters with shapes/police woman/circle police woman/circle police woman letside.png"))
(define circlePoliceWomanEast (bitmap "Photos/Characters with shapes/police woman/circle police woman/circle police woman rightside.png"))
(define circlePoliceWomanNorth (bitmap "Photos/Characters with shapes/police woman/circle police woman/circle police woman backside.png"))
(define circlePoliceWomanSouth (bitmap "Photos/Characters with shapes/police woman/circle police woman/circle police woman frontside.png"))
(define circlePoliceWomanSkin (make-skinD circlePoliceWomanWest circlePoliceWomanEast circlePoliceWomanSouth circlePoliceWomanNorth))

;pentagon PoliceWoman
(define pentagonPoliceWomanWest (bitmap "Photos/Characters with shapes/police woman/pentagon police woman/pentagon police woman leftside.png"))
(define pentagonPoliceWomanEast (bitmap "Photos/Characters with shapes/police woman/pentagon police woman/pentagon police woman rightside.png"))
(define pentagonPoliceWomanNorth (bitmap "Photos/Characters with shapes/police woman/pentagon police woman/pentagon police woman backside.png"))
(define pentagonPoliceWomanSouth (bitmap "Photos/Characters with shapes/police woman/pentagon police woman/pentagon police woman frontside.png"))
(define pentagonPoliceWomanSkin (make-skinD pentagonPoliceWomanWest pentagonPoliceWomanEast pentagonPoliceWomanSouth pentagonPoliceWomanNorth))

;rectangle PoliceWoman
(define rectanglePoliceWomanWest (bitmap "Photos/Characters with shapes/police woman/rectangle police woman/rectangle police woman leftside.png"))
(define rectanglePoliceWomanEast (bitmap "Photos/Characters with shapes/police woman/rectangle police woman/rectangle police woman rightside.png"))
(define rectanglePoliceWomanNorth (bitmap "Photos/Characters with shapes/police woman/rectangle police woman/rectangle police woman backside.png"))
(define rectanglePoliceWomanSouth (bitmap "Photos/Characters with shapes/police woman/rectangle police woman/rectangle police woman frontside.png"))
(define rectanglePoliceWomanSkin (make-skinD rectanglePoliceWomanWest rectanglePoliceWomanEast rectanglePoliceWomanSouth rectanglePoliceWomanNorth))

;square PoliceWoman
(define squarePoliceWomanWest (bitmap "Photos/Characters with shapes/police woman/sqaure police woman/square police woman leftside.png"))
(define squarePoliceWomanEast (bitmap "Photos/Characters with shapes/police woman/sqaure police woman/square police woman rightside.png"))
(define squarePoliceWomanNorth (bitmap "Photos/Characters with shapes/police woman/sqaure police woman/square police woman backside.png"))
(define squarePoliceWomanSouth (bitmap "Photos/Characters with shapes/police woman/sqaure police woman/square police woman frontside.png"))
(define squarePoliceWomanSkin (make-skinD squarePoliceWomanWest squarePoliceWomanEast squarePoliceWomanSouth squarePoliceWomanNorth))

;triangle PoliceWoman
(define trianglePoliceWomanWest (bitmap "Photos/Characters with shapes/police woman/traingle police woman/triagnle police woman leftside.png"))
(define trianglePoliceWomanEast (bitmap "Photos/Characters with shapes/police woman/traingle police woman/triagnle police woman  rightside.png"))
(define trianglePoliceWomanNorth (bitmap "Photos/Characters with shapes/police woman/traingle police woman/triagnle police woman  backside.png"))
(define trianglePoliceWomanSouth (bitmap "Photos/Characters with shapes/police woman/traingle police woman/triagnle police woman frontside.png"))
(define trianglePoliceWomanSkin (make-skinD trianglePoliceWomanWest trianglePoliceWomanEast trianglePoliceWomanSouth trianglePoliceWomanNorth))

;circle Scientist
(define circleScientistWest (bitmap "Photos/Characters with shapes/scientist/circle scientist/circle scientist leftside.png"))
(define circleScientistEast (bitmap "Photos/Characters with shapes/scientist/circle scientist/circle scientist rightside.png"))
(define circleScientistNorth (bitmap "Photos/Characters with shapes/scientist/circle scientist/circle scientist backside.png"))
(define circleScientistSouth (bitmap "Photos/Characters with shapes/scientist/circle scientist/circle scientist frontside.png"))
(define circleScientistSkin (make-skinD circleScientistWest circleScientistEast circleScientistSouth circleScientistNorth))

;pentagon Scientist
(define pentagonScientistWest (bitmap "Photos/Characters with shapes/scientist/pentagon scientist/pentagon scientist leftside.png"))
(define pentagonScientistEast (bitmap "Photos/Characters with shapes/scientist/pentagon scientist/pentagon scientist rightside.png"))
(define pentagonScientistNorth (bitmap "Photos/Characters with shapes/scientist/pentagon scientist/pentagon scientist backside.png"))
(define pentagonScientistSouth (bitmap "Photos/Characters with shapes/scientist/pentagon scientist/pentagon scientist frontside.png"))
(define pentagonScientistSkin (make-skinD pentagonScientistWest pentagonScientistEast pentagonScientistSouth pentagonScientistNorth))

;rectangle Scientist
(define rectangleScientistWest (bitmap "Photos/Characters with shapes/scientist/rectangle scientist/rectangle scientist leftside.png"))
(define rectangleScientistEast (bitmap "Photos/Characters with shapes/scientist/rectangle scientist/rectangle scientist rightside.png"))
(define rectangleScientistNorth (bitmap "Photos/Characters with shapes/scientist/rectangle scientist/rectangle scientist backside.png"))
(define rectangleScientistSouth (bitmap "Photos/Characters with shapes/scientist/rectangle scientist/rectangle scientist frontside.png"))
(define rectangleScientistSkin (make-skinD rectangleScientistWest rectangleScientistEast rectangleScientistSouth rectangleScientistNorth))

;square Scientist
(define squareScientistWest (bitmap "Photos/Characters with shapes/scientist/square scientist/square scientist leftside.png"))
(define squareScientistEast (bitmap "Photos/Characters with shapes/scientist/square scientist/square scientist rightside.png"))
(define squareScientistNorth (bitmap "Photos/Characters with shapes/scientist/square scientist/square scientist backside.png"))
(define squareScientistSouth (bitmap "Photos/Characters with shapes/scientist/square scientist/square scientist frontside.png"))
(define squareScientistSkin (make-skinD squareScientistWest squareScientistEast squareScientistSouth squareScientistNorth))

;triangle Scientist
(define triangleScientistWest (bitmap "Photos/Characters with shapes/scientist/triangle scientist/triagnle scientist leftside.png"))
(define triangleScientistEast (bitmap "Photos/Characters with shapes/scientist/triangle scientist/triagnle scientist rightside.png"))
(define triangleScientistNorth (bitmap "Photos/Characters with shapes/scientist/triangle scientist/triangle scientist backside.png"))
(define triangleScientistSouth (bitmap "Photos/Characters with shapes/scientist/triangle scientist/triagnle scientist frontside.png"))
(define triangleScientistSkin (make-skinD triangleScientistWest triangleScientistEast triangleScientistSouth triangleScientistNorth))

;Backgrounds

;Menu Background 
(define menuBg (bitmap "Photos/backgrounds/Final menu background.jpg")) 
;(define menuBg (bitmap "Photos/Shapes/level 3/full 1 square.jpg"))

;Character Select Backgrounds
(define chSelectBg (bitmap "Photos/selection/character select 1.jpeg")) 
(define chSelect2Bg (bitmap "Photos/selection/character select 2.jpeg"))
(define chSelect3Bg (bitmap "Photos/selection/character select 3.jpeg"))
(define chSelect4Bg (bitmap "Photos/selection/charcater select  4.jpeg"))

;Tutorial Pop Up Background
(define tutorialPopUpBg (bitmap "Photos/tutorial pop up with background.jpg")) 

;Tutorial Background
(define tutorialBg (bitmap "Photos/tutorial/movement control.jpg")) 

;Lobby Background
;(define lobbyBg (bitmap "Photos/Numbers/level 2/NumberLevel2Q2.png")) 

;ShapeLobby 
(define shapeLobbyL1Bg (bitmap "Photos/Shapes/shapes lobby level 1.jpg"))
(define shapeLobbyL2Bg (bitmap "Photos/Shapes/shapes lobby level 2.jpg"))
(define shapeLobbyL3Bg (bitmap "Photos/Shapes/shapes lobby level 3.jpg"))
(define shapeLevel1Q1Bg (bitmap "Photos/Shapes/level 1/question 1.jpg"))
(define shapeLevel1Q2Bg (bitmap "Photos/Shapes/level 1/question 2.jpg"))
(define shapeLevel1Q3Bg (bitmap "Photos/Shapes/level 1/question 3.jpg"))
(define shapeLevel1Q4Bg (bitmap "Photos/Shapes/level 1/question 4.jpg"))
(define shapeLevel1Q5Bg (bitmap "Photos/Shapes/level 1/question 5.jpg"))
(define shapeLevel1Score5Bg (bitmap "Photos/Shapes/level 1/scores/score 5.jpg"))

(define shapeLevel2Bg (empty-scene 1920 1080))

(define shapeLevel3Bg (empty-scene 1920 1080))

;ColorLobby 
(define colorLobbyL1Bg (bitmap "Photos/Colors/colors level 1.jpg"))
(define colorLobbyL2Bg (bitmap "Photos/Colors/colors level 2.jpg"))
(define colorLobbyL3Bg (bitmap "Photos/Colors/colors level 3.jpg"))
(define colorLevel1Q1Bg (bitmap "Photos/Colors/level 1/question 1.jpg"))
(define colorLevel1Q2Bg (bitmap "Photos/Colors/level 1/question 2.jpg"))
(define colorLevel1Q3Bg (bitmap "Photos/Colors/level 1/question 3.jpg"))
(define colorLevel1Q4Bg (bitmap "Photos/Colors/level 1/question 4.jpg"))
(define colorLevel1Q5Bg (bitmap "Photos/Colors/level 1/question 5.jpg"))
(define colorLevel1Score5Bg (bitmap "Photos/Colors/level 3/baskets/item 12 next.jpg"))

(define colorLevel2Bg (empty-scene 1920 1080))

(define colorLevel3Bg (empty-scene 1920 1080))


;Elevator Background
(define ElevatorBg (bitmap "Photos/elevator.jpg"))

;NumberLobby 
(define numberLobbyL1Bg (bitmap "Photos/Numbers/numbers level 1.jpg"))
(define numberLobbyL2Bg (bitmap "Photos/Numbers/numbers level 2.jpg"))
(define numberLobbyL3Bg (bitmap "Photos/Numbers/numbers level 3.jpg"))

(define numberLevel1Q1Bg (bitmap "Photos/Numbers/level 1/question 1.jpg"))
(define numberLevel1Q2Bg (bitmap "Photos/Numbers/level 1/question 2.jpg"))
(define numberLevel1Q3Bg (bitmap "Photos/Numbers/level 1/question 3.jpg"))
(define numberLevel1Q4Bg (bitmap "Photos/Numbers/level 1/question 4.jpg"))
(define numberLevel1Q5Bg (bitmap "Photos/Numbers/level 1/question 5.jpg"))

(define numberLevel1Score5Bg (bitmap "Photos/Numbers/level 1/scores/score 5.jpg"))

(define numberLevel2Bg (empty-scene 1920 1080))

(define numberLevel3Bg (empty-scene 1920 1080))

; pixel character
;for getting x,y position of stuff (Testing Purposes)
(define skinBoyWest (line 0 2 "red"))
(define skinBoyEast (line 0 2 "red"))
(define skinBoyNorth (line 0 2 "red"))
(define skinBoySouth (line 0 2 "red"))
(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================

;Purpose: Draws the menu 
;Contract: menu --> image
(define menu    
  (place-image menuBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))



; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;=======================================================================================
;******************************* Character Select**************************************
;=======================================================================================
              
;Draw The Character Select Menu
(define characterSelectMenu
   (place-image chSelectBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define characterSelect2
    (place-image chSelect2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define characterSelect3
    (place-image chSelect3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define characterSelect4
    (place-image chSelect4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================

;defines character speed
(define ChSpeed 1)

;Purpose: Draws the Character in the Lobby
;Contract: drawLobby: world --> image
(define (drawLobby world) (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         lobbyBg))
;test 
(check-expect (drawLobby (make-world "Lobby" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinBoyEast worldCenterWidth worldCenterHeight lobbyBg))
(check-expect (drawLobby (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinJanitorEast worldCenterWidth worldCenterHeight lobbyBg))
(check-expect (drawLobby (make-world "Lobby" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinScientistEast worldCenterWidth worldCenterHeight lobbyBg))
(check-expect (drawLobby (make-world "Lobby" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinPoliceWomanEast worldCenterWidth worldCenterHeight lobbyBg))

;Purpose: helper function to update the x coordinates of the Character
;Contract: updateChPosx: Character(c), number(cs) --> pos(x)
;function
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))

;test
(check-expect (updateChPosx (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)) 50) 1010)
(check-expect (updateChPosx (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)) -50) 910)  

;Purpose: helper function to update the y coordinates of the Character
;Contract: updateChPosy: Character(c), number(cs) --> pos(y)
;function
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))

;test
(check-expect (updateChPosy (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)) 50) 590)
(check-expect (updateChPosy (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)) -50) 490)
(check-expect (updateChPosx (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)) 50) 1010)
(check-expect (updateChPosx (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)) -50) 910)
;Purpose: helper function to update the skin of the character 
;Contract: skinUpdater: skin(s) --> skinD
;function
(define (skinUpdater s)
  (cond
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "boy"))
     (skinD-west boySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "boy"))
     (skinD-east boySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "boy"))
     (skinD-south boySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "boy"))
     (skinD-north boySkin)]
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "janitor"))
     (skinD-west janitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "janitor"))
        (skinD-east janitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "janitor"))
        (skinD-south janitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "janitor"))
        (skinD-north janitorSkin)]


   [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "scientist"))
     (skinD-west scientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "scientist"))
        (skinD-east scientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "scientist"))
        (skinD-south scientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "scientist"))
        (skinD-north scientistSkin)] 


     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "policeWoman"))
     (skinD-west policeWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "policeWoman"))
        (skinD-east policeWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "policeWoman"))
        (skinD-south policeWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "policeWoman"))
        (skinD-north policeWomanSkin)] 

  
))

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: world(w), keyboard-input(ki) --> image
;function
(define (moveCharacter w ki)
  (if (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorial"))                                          
    (cond
        [(and (string=? (skin-name (Character-skin (world-character w))) "boy") (or (key=? ki "left") (key=? ki "a"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "boy" "left") 
                                    (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "boy") (or (key=? ki "right") (key=? ki "d"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "boy" "right")  
                                    (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "boy") (or (key=? ki "up") (key=? ki "w")))
        (make-world (world-scene w) 
                    (make-Character (make-skin "boy" "up")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) (* ChSpeed -1)))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "boy") (or (key=? ki "down") (key=? ki "s"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "boy" "down")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) ChSpeed))))]

        [(and (string=? (skin-name (Character-skin (world-character w))) "janitor") (or (key=? ki "left") (key=? ki "a"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "janitor" "left") 
                                    (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "janitor") (or (key=? ki "right") (key=? ki "d")))
        (make-world (world-scene w) 
                    (make-Character (make-skin "janitor" "right")  
                                    (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "janitor") (or (key=? ki "up") (key=? ki "w"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "janitor" "up")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) (* ChSpeed -1)))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "janitor") (or (key=? ki "down") (key=? ki "s"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "janitor" "down")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) ChSpeed))))]


        [(and (string=? (skin-name (Character-skin (world-character w))) "scientist") (or (key=? ki "left") (key=? ki "a"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "scientist" "left") 
                                    (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "scientist") (or (key=? ki "right") (key=? ki "d")))
        (make-world (world-scene w) 
                    (make-Character (make-skin "scientist" "right")  
                                    (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "scientist") (or (key=? ki "up") (key=? ki "w"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "scientist" "up")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) (* ChSpeed -1)))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "scientist") (or (key=? ki "down") (key=? ki "s"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "scientist" "down")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) ChSpeed))))]

                                                
        [(and (string=? (skin-name (Character-skin (world-character w))) "policeWoman") (or (key=? ki "left") (key=? ki "a"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "policeWoman" "left") 
                                    (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "policeWoman") (or (key=? ki "right") (key=? ki "d")))
        (make-world (world-scene w) 
                    (make-Character (make-skin "policeWoman" "right")  
                                    (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                                (ChPos-y (Character-pos (world-character w))))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "policeWoman") (or (key=? ki "up") (key=? ki "w"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "policeWoman" "up")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) (* ChSpeed -1)))))]
        [(and (string=? (skin-name (Character-skin (world-character w))) "policeWoman") (or (key=? ki "down") (key=? ki "s"))) 
        (make-world (world-scene w) 
                    (make-Character (make-skin "policeWoman" "down")  
                                    (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                (updateChPosy (world-character w) ChSpeed))))]
        [else w]
        )
    w))


;test 

;=======================================================================================
;******************************* Tutorial**************************************
;=======================================================================================

;Purpose: Draws the Tutorial Pop up
;Contract: drawTutorial: world(w) --> image
(define drawTutorialPopUp
  (place-image tutorialPopUpBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

;Purpose: Draws the Tutorial
;Contract: drawTutorial: world(w) --> image
(define (drawTutorial world)
  (place-image (skinUpdater (Character-skin (world-character world))) 
               (ChPos-x (Character-pos (world-character world))) 
               (ChPos-y (Character-pos (world-character world))) 
                tutorialBg))

;test
(check-expect (drawTutorial (make-world "tutorial" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinBoyEast worldCenterWidth worldCenterHeight tutorialBg))

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================

;defines the character select scene once clicked
(define cChSelect (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;defines the Lobby scene once clicked 
(define (cLobby world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (make-world "Lobby"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (make-world "Lobby"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (make-world "Lobby"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))

;defines the tutorial pop up scene once confirm on chSelect is clicked
(define (cTutorialPopUp world)
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (make-world "tutorialPopUp" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (make-world "tutorialPopUp"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (make-world "tutorialPopUp"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
         [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (make-world "tutorialPopUp"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))

;defines the tutorial scene once yes on tutorial pop up is clicked
(define (cTutorial world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (make-world "tutorial"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (make-world "tutorial"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (make-world "tutorial"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))

;makes the skin boy once clicked
(define cBoySelect (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;makes the skin janitor once clicked
(define cJanitorSelect (make-world "chSelect2" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;makes the skin janitor once clicked
(define cScientistSelect (make-world "chSelect3" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;makes the skin janitor once clicked
(define cPoliceWomanSelect (make-world "chSelect4" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image

;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image

;Play button y-axis Play from 480(bottom) to 377(top)
;Play button x-axis Play from 757(left) to 1148(right)

;Character select confirm button y-axis start from 1080(bottom) to 931(top)
;Character select confirm button x-axis start from 1570(left) to 1855(right)

;Boy character select y-axis start from 772(bottom) 271(top)
;Boy character select x-axis start from 66(left) 448(right)

;Janitor character select y-axis start from 772(bottom) 271(top)
;Janitor character select x-axis start from 531(left) 913(right)

;Scientist character select y-axis start from 772(bottom) 271(top)
;Scientist character select x-axis start from 990(left) 1370(right)

;Police Woman character select y-axis start from 772(bottom) 271(top)
;Police Woman character select x-axis start from 1460(left) 1840(right)

;TutorialPopUpYes button y-axis start from 770(bottom) to 670(top)
;TutorialPopUpYes button x-axis start from 567(left) to 915(right)

;TutorialPopUpNo button y-axis start from 770(bottom) to 670(top)
;TutorialPopUpNo button x-axis start from 1029(left) to 1376(right)

;LeaderBoard button y-axis start from ?(bottom) to ?(top)
;LeaderBoard button x-axis start from ?(left) to ?(right)

;function
(define (mouseRegister w x y me)
  (cond
  [(and (and (string=? (world-scene w) "menu") ;Play button
             (mouse=? me "button-down"))
        (and (<= y 480) 
             (>= y 377))
        (and (>= x 757)   
             (<= x 1148))) 
        cChSelect]
  [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Boy character select
             (mouse=? me "button-down"))
        (and (<= y 772) 
             (>= y 271))
        (and (>= x 66)   
             (<= x 448))) 
        cBoySelect]
  [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Janitor character select
                 (mouse=? me "button-down"))
        (and (<= y 772) 
             (>= y 271))
        (and (>= x 531)   
             (<= x 913)))
        cJanitorSelect]
  [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Scientist character select
                 (mouse=? me "button-down"))
        (and (<= y 772) 
             (>= y 271))
        (and (>= x 990)   
             (<= x 1370)))
        cScientistSelect]
  [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Police Woman character select
                 (mouse=? me "button-down"))
        (and (<= y 772) 
             (>= y 271))
        (and (>= x 1460)   
             (<= x 1840)))
        cPoliceWomanSelect]
  [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4"))  ;chSelect confirm button
             (mouse=? me "button-down"))
        (and (<= y 1080) 
             (>= y 931))
        (and (>= x 1570)   
             (<= x 1855))) 
        (cTutorialPopUp w)]
  [(and (and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp yes button
             (mouse=? me "button-down"))
        (and (<= y 770) 
             (>= y 670))
        (and (>= x 567)   
             (<= x 915)))
         (cTutorial w)]
  [(and (and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp no button
             (mouse=? me "button-down"))
        (and (<= y 770)
             (>= y 670))
        (and (>= x 1029)
             (<= x 1376))) 
             (cLobby w)]
  [else w]))

;test

;=======================================================================================
;***************************** Drawing World + big-bang ********************************
;=======================================================================================

;Purpose: Draws The World
;Contract: drawWorld: world(w) --> image
;function
(define (drawWorld world)
  (cond [(string=? (world-scene world) "menu") 
                    menu]
        [(string=? (world-scene world) "chSelect")
                    characterSelectMenu]          
        [(string=? (world-scene world) "chSelect2")
                    characterSelect2]
        [(string=? (world-scene world) "chSelect3")
                    characterSelect3]
        [(string=? (world-scene world) "chSelect4")
                    characterSelect4]
        [(string=? (world-scene world) "Lobby") 
                    (drawLobby world)]
        [(string=? (world-scene world) "tutorialPopUp")
                    drawTutorialPopUp]
        [(string=? (world-scene world) "tutorial")
                    (drawTutorial world)]
        [else (empty-scene 1920 1080)]))

;test

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(and (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (world-scene world) "menu"))
                   (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (world-scene world) "chSelect"))
                    (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (world-scene world) "Lobby"))
                   (make-world "Lobby" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (world-scene world) "tutorial"))
                    (make-world "tutorial" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (world-scene world) "tutorialPopUp"))
                    (make-world "tutorialPopUp" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]

        [(and (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (world-scene world) "menu"))
                   (make-world "menu" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (world-scene world) "chSelect"))
                    (make-world "chSelect" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (world-scene world) "Lobby"))
                   (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (world-scene world) "tutorial"))
                    (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]

       [(and (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (world-scene world) "menu"))
                   (make-world "menu" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (world-scene world) "chSelect"))
                    (make-world "chSelect" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (world-scene world) "Lobby"))
                   (make-world "Lobby" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (world-scene world) "tutorial"))
                    (make-world "tutorial" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]

        [(and (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (world-scene world) "menu"))
                   (make-world "menu" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (world-scene world) "chSelect"))
                    (make-world "chSelect" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (world-scene world) "Lobby"))
                   (make-world "Lobby" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(and (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (world-scene world) "tutorial"))
                    (make-world "tutorial" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))
  
;test
(check-expect (sceneSelector (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorialPopUp" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorialPopUp" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

(check-expect (sceneSelector (make-world "menu" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorialPopUp" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorialPopUp" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

(check-expect (sceneSelector (make-world "menu" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorialPopUp" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorialPopUp" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

(check-expect (sceneSelector (make-world "menu" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorialPopUp" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorialPopUp" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))

;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(on-draw drawWorld)
(on-key moveCharacter)
(on-mouse mouseRegister)
(state #true)
)

(test)