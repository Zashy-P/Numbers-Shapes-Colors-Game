#lang racket/gui
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)
(require (only-in racket/gui/base play-sound))

;=======================================================================================
;********************************* structs & world values ******************************
;=======================================================================================

;World --> Scene, Character, time
(define-struct world (scene character t)) 
;Character --> image(skin), pos(x,y), stepCount
(define-struct Character (skin pos stepCount))
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
;************************************ Sound ********************************************
;=======================================================================================

;Path to the Button Click sound effect
(define buttonClick1Path "Sounds/buttonClick1.mp3")
(define footstepPath "Sounds/ConcreteFootstep.mp3")
(define footstep2Path "Sounds/ConcreteFootstep2.MP3")
(define footstepSounds (list footstepPath footstep2Path))
(define bellRingPath "Sounds/bellRing.wav")
(define wrongChoiceEffectPath "Sounds/wrongChoiceEffect.mp3")
(define correctAnswerEffectPath "Sounds/CorrectAnswerEffect.wav")
(define paintSoundEffectPath "Sounds/splat sound effect.mp3")
(define shapeTutorialAudioPath "Sounds/Shape Tutorial.MP3")
(define colorTutorialAudioPath "Sounds/color tutorial.mp3")
(define numberTutorialAudioPath "Sounds/number tutorial.mp3")

(define (playButtonClick1Sound)
  (play-sound buttonClick1Path #f))

(define (playFootstepSound x)
  (cond 
     [(= (modulo x 2) 0) 0 (play-sound (first footstepSounds) #f)]
     [(= (modulo x 2) 1) (begin (play-sound (second footstepSounds) #f))]))


(define (playBellRingSound)
  (play-sound bellRingPath #f))

(define (playWrongChoiceEffectSound)
  (play-sound wrongChoiceEffectPath #f))

(define (playCorrectAnswerEffectSound)
  (play-sound correctAnswerEffectPath #f))

(define (playPaintSoundEffect)
  (play-sound paintSoundEffectPath #f)) 

(define (playShapeTutorialAudio)
  (play-sound shapeTutorialAudioPath #f))  

(define (playColorTutorialAudio)
  (play-sound colorTutorialAudioPath #f))

(define (playNumberTutorialAudio)
    (play-sound numberTutorialAudioPath #f))

;Purpose: plays the wrong answer sound effect and returns the world to the same state it was in
;Contract: wrongAnswer: world --> world
(define (wrongAnswer w)   
    (begin (thread playWrongChoiceEffectSound) (make-world (world-scene w) 
                                                 (make-Character (make-skin (skin-name (Character-skin (world-character w))) 
                                                                            (skin-direction (Character-skin (world-character w)))) 
                                                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                                                             (ChPos-y (Character-pos (world-character w)))) 0) 0)))
  

;Purpose: plays the wrong answer sound effect and returns the world to the beggining of the level
;Contract: wrongAnswer: world --> world
(define (wrongAnswerShapeLevel3 w)
     (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3" 
                                                  (make-Character (make-skin (skin-name (Character-skin (world-character w))) 
                                                                             (skin-direction (Character-skin (world-character w)))) 
                                                                  (make-ChPos 105 488) 
                                                                              0) 
                                                                              0)))
      


;=======================================================================================
;************************************ Images *******************************************
;=======================================================================================
;Character skins

;boy skin
(define skinBoyWest(bitmap "Photos/Characters/boy/boy_left_side.png"))
(define skinBoyEast(bitmap "Photos/Characters/boy/boy right side.png"))
(define skinBoyNorth(bitmap "Photos/Characters/boy/boy_backside.png"))
(define skinBoySouth(bitmap "Photos/Characters/boy/boy_frontside.png"))
(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

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

;blue key boy
(define blueKeyBoyWest (bitmap "Photos/Characters with keys/boy/blue/blue_key_boy_leftside-removebg-preview.png"))
(define blueKeyBoyEast (bitmap "Photos/Characters with keys/boy/blue/blue_key_boy_rightside-removebg-preview.png"))
(define blueKeyBoyNorth (bitmap "Photos/Characters with keys/boy/blue/blue_key_boy_backside-removebg-preview.png"))
(define blueKeyBoySouth (bitmap "Photos/Characters with keys/boy/blue/blue_key_boy_frontside-removebg-preview.png"))
(define blueKeyBoySkin (make-skinD blueKeyBoyWest blueKeyBoyEast blueKeyBoySouth blueKeyBoyNorth))

;orange key boy
(define orangeKeyBoyWest (bitmap "Photos/Characters with keys/boy/orange/orange_key_boy_leftside-removebg-preview.png"))
(define orangeKeyBoyEast (bitmap "Photos/Characters with keys/boy/orange/orange_key_boy_rightside-removebg-preview.png"))
(define orangeKeyBoyNorth (bitmap "Photos/Characters with keys/boy/orange/orange_key_boy_backside-removebg-preview.png"))
(define orangeKeyBoySouth (bitmap "Photos/Characters with keys/boy/orange/orange_key_boy_frontside-removebg-preview.png"))
(define orangeKeyBoySkin (make-skinD orangeKeyBoyWest orangeKeyBoyEast orangeKeyBoySouth orangeKeyBoyNorth))

;yellow key boy
(define yellowKeyBoyWest (bitmap "Photos/Characters with keys/boy/yellow/yellow_key_boy_leftside-removebg-preview.png"))
(define yellowKeyBoyEast (bitmap "Photos/Characters with keys/boy/yellow/yellow_key_boy_rightside-removebg-preview.png"))
(define yellowKeyBoyNorth (bitmap "Photos/Characters with keys/boy/yellow/yellow__key_boy_backside-removebg-preview.png"))
(define yellowKeyBoySouth (bitmap "Photos/Characters with keys/boy/yellow/yellow_key_boy_frontside-removebg-preview.png"))
(define yellowKeyBoySkin (make-skinD yellowKeyBoyWest yellowKeyBoyEast yellowKeyBoySouth yellowKeyBoyNorth))

;blue key janitor
(define blueKeyJanitorWest (bitmap "Photos/Characters with keys/janitor/blue/blue_key_janitor__leftside-removebg-preview.png"))
(define blueKeyJanitorEast (bitmap "Photos/Characters with keys/janitor/blue/blue_key_janitor_rightside-removebg-preview.png"))
(define blueKeyJanitorSouth (bitmap "Photos/Characters with keys/janitor/blue/blue_key_janitor_frontside-removebg-preview.png"))
(define blueKeyJanitorNorth (bitmap "Photos/Characters with keys/janitor/blue/blue_key_janitor_backside-removebg-preview.png"))
(define blueKeyJanitorSkin (make-skinD blueKeyJanitorWest blueKeyJanitorEast blueKeyJanitorSouth blueKeyJanitorNorth))

;orange key janitor
(define orangeKeyJanitorWest (bitmap "Photos/Characters with keys/janitor/orange/orange_key_janitor_leftside-removebg-preview.png"))
(define orangeKeyJanitorEast (bitmap "Photos/Characters with keys/janitor/orange/orange_key_janitor_rightside-removebg-preview.png"))
(define orangeKeyJanitorSouth (bitmap "Photos/Characters with keys/janitor/orange/orange_key_janitor_frontside-removebg-preview.png"))
(define orangeKeyJanitorNorth (bitmap "Photos/Characters with keys/janitor/orange/orange_key_janitor_backside-removebg-preview.png"))
(define orangeKeyJanitorSkin (make-skinD orangeKeyJanitorWest orangeKeyJanitorEast orangeKeyJanitorSouth orangeKeyJanitorNorth))

;yellow key janitor
(define yellowKeyJanitorWest (bitmap "Photos/Characters with keys/janitor/yellow/yellow_key_janitor_leftside-removebg-preview.png"))
(define yellowKeyJanitorEast (bitmap "Photos/Characters with keys/janitor/yellow/yellow_key_janitor_rightside-removebg-preview.png"))
(define yellowKeyJanitorSouth (bitmap "Photos/Characters with keys/janitor/yellow/yellow_key_janitor_frontside-removebg-preview.png"))
(define yellowKeyJanitorNorth (bitmap "Photos/Characters with keys/janitor/yellow/yellow_key_janitor_backside-removebg-preview.png"))
(define yellowKeyJanitorSkin (make-skinD yellowKeyJanitorWest yellowKeyJanitorEast yellowKeyJanitorSouth yellowKeyJanitorNorth))

;blue key scientist
(define blueKeyScientistWest (bitmap "Photos/Characters with keys/scientist/blue/blue_key_scientist_leftside-removebg-preview.png"))
(define blueKeyScientistEast (bitmap "Photos/Characters with keys/scientist/blue/blue_key_scientist_rightside-removebg-preview.png"))
(define blueKeyScientistNorth (bitmap "Photos/Characters with keys/scientist/blue/blue_key_scientist_backside-removebg-preview.png"))
(define blueKeyScientistSouth (bitmap "Photos/Characters with keys/scientist/blue/blue_key_scientist_frontside-removebg-preview.png"))
(define blueKeyScientistSkin (make-skinD blueKeyScientistWest blueKeyScientistEast blueKeyScientistSouth blueKeyScientistNorth))

;yellow key scientist
(define yellowKeyScientistWest (bitmap "Photos/Characters with keys/scientist/yellow/yellow_key_scientist_leftside-removebg-preview.png"))
(define yellowKeyScientistEast (bitmap "Photos/Characters with keys/scientist/yellow/yellow_key_scientist_rightside-removebg-preview.png"))
(define yellowKeyScientistNorth (bitmap "Photos/Characters with keys/scientist/yellow/yellow_key_scientist_backside-removebg-preview.png"))
(define yellowKeyScientistSouth (bitmap "Photos/Characters with keys/scientist/yellow/yellow_key_scientist_frontside-removebg-preview.png"))
(define yellowKeyScientistSkin (make-skinD yellowKeyScientistWest yellowKeyScientistEast yellowKeyScientistSouth yellowKeyScientistNorth))

;orange key scientist
(define orangeKeyScientistWest (bitmap "Photos/Characters with keys/scientist/orange/orange_key_scientist_leftside-removebg-preview.png"))
(define orangeKeyScientistEast (bitmap "Photos/Characters with keys/scientist/orange/orange_key_scientist_rightside-removebg-preview.png"))
(define orangeKeyScientistNorth (bitmap "Photos/Characters with keys/scientist/orange/orange_key_scientist_backside-removebg-preview.png"))
(define orangeKeyScientistSouth (bitmap "Photos/Characters with keys/scientist/orange/orange_key_scientist_frontside-removebg-preview.png"))
(define orangeKeyScientistSkin (make-skinD orangeKeyScientistWest orangeKeyScientistEast orangeKeyScientistSouth orangeKeyScientistNorth))

;blue key police woman
(define blueKeyPoliceWomanWest (bitmap "Photos/Characters with keys/police woman/blue/blue_key_police_woman_leftside-removebg-preview.png"))
(define blueKeyPoliceWomanEast (bitmap "Photos/Characters with keys/police woman/blue/blue_key_police_woman_rightside-removebg-preview.png"))
(define blueKeyPoliceWomanNorth (bitmap "Photos/Characters with keys/police woman/blue/blue_key_police_woman_backside-removebg-preview.png"))
(define blueKeyPoliceWomanSouth (bitmap "Photos/Characters with keys/police woman/blue/blue_key_police_woman_frontside-removebg-preview.png"))
(define blueKeyPoliceWomanSkin (make-skinD blueKeyPoliceWomanWest blueKeyPoliceWomanEast blueKeyPoliceWomanSouth blueKeyPoliceWomanNorth))

;yellow key police woman
(define yellowKeyPoliceWomanWest (bitmap "Photos/Characters with keys/police woman/yellow/yellow_key_police_woman_leftside-removebg-preview.png"))
(define yellowKeyPoliceWomanEast (bitmap "Photos/Characters with keys/police woman/yellow/yellow_key_police_woman_rightside-removebg-preview.png"))
(define yellowKeyPoliceWomanNorth (bitmap "Photos/Characters with keys/police woman/yellow/yellow_key_police_woman_backside-removebg-preview.png"))
(define yellowKeyPoliceWomanSouth (bitmap "Photos/Characters with keys/police woman/yellow/yellow_key_police_woman_frontside-removebg-preview.png"))
(define yellowKeyPoliceWomanSkin (make-skinD yellowKeyPoliceWomanWest yellowKeyPoliceWomanEast yellowKeyPoliceWomanSouth yellowKeyPoliceWomanNorth))

;orange key police woman
(define orangeKeyPoliceWomanWest (bitmap "Photos/Characters with keys/police woman/orange/orange_key_police_woman_leftside-removebg-preview.png"))
(define orangeKeyPoliceWomanEast (bitmap "Photos/Characters with keys/police woman/orange/orange_key_police_woman_rightside-removebg-preview.png"))
(define orangeKeyPoliceWomanNorth (bitmap "Photos/Characters with keys/police woman/orange/orange_key_police_woman__backside-removebg-preview.png"))
(define orangeKeyPoliceWomanSouth (bitmap "Photos/Characters with keys/police woman/orange/orange_key_police_woman_frontside-removebg-preview.png"))
(define orangeKeyPoliceWomanSkin (make-skinD orangeKeyPoliceWomanWest orangeKeyPoliceWomanEast orangeKeyPoliceWomanSouth orangeKeyPoliceWomanNorth))


;Backgrounds

;Menu Background 
(define menuBg (bitmap "Photos/backgrounds/Final menu background.jpg")) 

;Character Info Backgrounds
(define characterInfo1Bg (bitmap "Photos/charcater info boy.jpg"))
(define characterInfo2Bg (bitmap "Photos/charcater info janitor.jpg"))
(define characterInfo3Bg (bitmap "Photos/character info scientist.jpg"))
(define characterInfo4Bg (bitmap "Photos/character info police woman.jpg"))

;Character Select Backgrounds
(define chSelectBg (bitmap "Photos/selection/character select 1.jpeg")) 
(define chSelect2Bg (bitmap "Photos/selection/character select 2.jpeg"))
(define chSelect3Bg (bitmap "Photos/selection/character select 3.jpeg"))
(define chSelect4Bg (bitmap "Photos/selection/charcater select  4.jpeg"))

;Tutorial Pop Up Background
(define tutorialPopUpBg (bitmap "Photos/tutorial pop up with background.jpg")) 

;Tutorial Backgrounds
(define tutorialMovementBg (bitmap "Photos/tutorial/movement control.jpg")) 

;Lobby Background
(define lobbyBg (bitmap "Photos/Lobby Background.jpg")) 

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

(define shapeLevel2Path1Bg (bitmap "Photos/Shapes/level 2/Paths/pentagon.jpeg"))
(define shapeLevel2Path2Bg (bitmap "Photos/Shapes/level 2/Paths/square.jpeg" ))
(define shapeLevel2Path3Bg (bitmap "Photos/Shapes/level 2/Paths/circle.jpeg" ))
(define shapeLevel2PathDeadEndBg (bitmap "Photos/Shapes/level 2/Paths/dead end.jpg"))
(define shapeLevel2TrainBg (bitmap "Photos/Shapes/level 2/Train/level 2 train bg.jpg"))
(define squareCartBg (bitmap "Photos/Shapes/level 2/Train/full 1 square.jpg"))
(define circleCartBg (bitmap "Photos/Shapes/level 2/Train/full 2 circle.jpg"))
(define triangleCartBg (bitmap "Photos/Shapes/level 2/Train/full 3 triangle.jpg"))
(define rectangleCartBg (bitmap "Photos/Shapes/level 2/Train/full 4 rectangle.jpg"))
(define pentagonCartBg (bitmap "Photos/Shapes/level 2/Train/full 5 pentagon.jpg"))
(define shapeLevel2Score8Bg (bitmap "Photos/Shapes/level 2/shape level 2 score 8.jpeg"))

(define shapeLevel3P1Bg (bitmap "Photos/Shapes/level 3/1 rectangle.jpg"))
(define shapeLevel3P2Bg (bitmap "Photos/Shapes/level 3/2 square.jpg"))
(define shapeLevel3P3Bg (bitmap "Photos/Shapes/level 3/3 circle.jpg"))
(define shapeLevel3P4Bg (bitmap "Photos/Shapes/level 3/4 triangle.jpg"))
(define shapeLevel3P5Bg (bitmap "Photos/Shapes/level 3/5 pentagon.jpg"))
(define shapeLevel3Score5Bg (bitmap "Photos/Shapes/level 3/shapes level 3 score 5.jpg"))

(define shapeLevel3Q1Bg (bitmap "Photos/Shapes/level 3/mcq/q1.jpg"))
(define shapeLevel3Q2Bg (bitmap "Photos/Shapes/level 3/mcq/q2.jpg"))
(define shapeLevel3Q3Bg (bitmap "Photos/Shapes/level 3/mcq/q3.jpg"))
(define shapeLevel3Q4Bg (bitmap "Photos/Shapes/level 3/mcq/q4.jpg"))
(define shapeLevel3Q5Bg (bitmap "Photos/Shapes/level 3/mcq/q5.jpg"))

(define shapeLevel3Score0RetryBg (bitmap "Photos/Shapes/level 3/retry/score 0 retry.jpg"))
(define shapeLevel3Score1RetryBg (bitmap "Photos/Shapes/level 3/retry/score 1 retry.jpg"))
(define shapeLevel3Score2RetryBg (bitmap "Photos/Shapes/level 3/retry/score 2 retry.jpg"))
(define shapeLevel3Score3RetryBg (bitmap "Photos/Shapes/level 3/retry/score 3 retry.jpg"))
(define shapeLevel3Score4RetryBg (bitmap "Photos/Shapes/level 3/retry/score 4 retry.jpg"))
(define shapeLevel3Score5RetryBg (bitmap "Photos/Shapes/level 3/retry/score 5 retry.jpg"))
(define shapeLevel3Score6RetryBg (bitmap "Photos/Shapes/level 3/retry/score 6 retry.jpg"))
(define shapeLevel3Score7RetryBg (bitmap "Photos/Shapes/level 3/retry/score 7 retry.jpg"))
(define shapeLevel3Score8RetryBg (bitmap "Photos/Shapes/level 3/retry/score 8 retry.jpg"))
(define shapeLevel3Score9RetryBg (bitmap "Photos/Shapes/level 3/retry/score 9 retry.jpg"))

;shape tutorial
(define circleTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 2.jpg"))
(define cSunTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 3.jpg"))
(define cBallTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 4.jpg"))
(define cTireTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 5.jpg"))
(define cManyOtherPlacesBg (bitmap "Photos/tutorial/shapes/shape scene 6.jpg"))
(define squareTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 7.jpg"))
(define sPizzaBoxTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 8.jpg"))
(define sWaffleTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 9.jpg"))
(define sTostTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 10.jpg"))
(define sManyOtherPlacesBg (bitmap "Photos/tutorial/shapes/shape scene 11.jpg"))
(define triangleTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 12.jpg"))
(define tBirthdayHatTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 13.jpg"))
(define tSandwhichTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 14.jpg"))
(define tSailingBoatTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 15.jpg"))
(define tManyOtherPlacesBg (bitmap "Photos/tutorial/shapes/shape scene 16.jpg"))
(define rectangleTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 17.jpg"))
(define rBookTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 18.jpg"))
(define rPuzzleTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 19.jpg"))
(define rDoorTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 20.jpg"))
(define rManyOtherPlacesBg (bitmap "Photos/tutorial/shapes/shape scene 21.jpg"))
(define pentagonTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 22.jpg"))
(define pGemTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 23.jpg"))
(define pDogHouseTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 24.jpg"))
(define pClockTutorialBg (bitmap "Photos/tutorial/shapes/shape scene 25.jpg"))
(define pManyOtherPlacesBg (bitmap "Photos/tutorial/shapes/shape scene 26.jpg"))


;ColorLobby 
(define colorLobbyL1Bg (bitmap "Photos/Colors/colors level 1.jpg"))
(define colorLobbyL2Bg (bitmap "Photos/Colors/colors level 2.jpg"))
(define colorLobbyL3Bg (bitmap "Photos/Colors/colors level 3.jpg"))
(define colorLevel1Q1Bg (bitmap "Photos/Colors/level 1/question 1.jpg"))
(define colorLevel1Q2Bg (bitmap "Photos/Colors/level 1/question 2.jpg"))
(define colorLevel1Q3Bg (bitmap "Photos/Colors/level 1/question 3.jpg"))
(define colorLevel1Q4Bg (bitmap "Photos/Colors/level 1/question 4.jpg"))
(define colorLevel1Q5Bg (bitmap "Photos/Colors/level 1/question 5.jpg"))
(define colorLevel1Score5Bg (bitmap "Photos/Numbers/level 1/scores/score 5.jpg"))

(define colorLevel2Bg (bitmap "Photos/Colors/level 2/0 start.jpg"))

;Color Level 2 
(define colorLevel2RedFrameBg (bitmap "Photos/Colors/level 2/1 red.jpg"))
(define colorLevel2OrangeFrameBg (bitmap "Photos/Colors/level 2/2 orange.jpg"))
(define colorLevel2YellowFrameBg (bitmap "Photos/Colors/level 2/3 yellow.jpg"))
(define colorLevel2GreenFrameBg (bitmap "Photos/Colors/level 2/4 green.jpg"))
(define colorLevel2BlueFrameBg (bitmap "Photos/Colors/level 2/5 blue.jpg"))
(define colorLevel2PurpleFrameBg (bitmap "Photos/Colors/level 2/6 purple.jpg"))

(define colorLevel2Q1Bg (bitmap "Photos/Colors/level 2/q1.jpg"))
(define colorLevel2Q2Bg (bitmap "Photos/Colors/level 2/q2.jpg"))
(define colorLevel2Q3Bg (bitmap "Photos/Colors/level 2/q3.jpg"))
(define colorLevel2Q4Bg (bitmap "Photos/Colors/level 2/q4.jpg"))
(define colorLevel2Q5Bg (bitmap "Photos/Colors/level 2/q5.jpg"))
(define colorLevel2Q6Bg (bitmap "Photos/Colors/level 2/q6.jpg"))

(define colorLevel2Score6Bg (bitmap "Photos/Colors/level 2/color level 2 score 5.jpeg"))

;Color Level 3 
(define colorLevel3KeyDoorBg (bitmap "Photos/Colors/level 3/key door.jpeg"))
(define colorLevel3ClassroomBg (bitmap "Photos/Colors/level 3/classroom.jpg"))
(define colorLevel3Door2Bg (bitmap "Photos/Colors/level 3/door 2.jpeg"))

(define colorLevel3Q1Bg (bitmap "Photos/Colors/level 3/q1.jpg"))
(define colorLevel3Q2Bg (bitmap "Photos/Colors/level 3/q2.jpg")) 
(define colorLevel3Q3Bg (bitmap "Photos/Colors/level 3/q3.jpg"))

(define colorlevel3SubScoreBg (bitmap "Photos/Colors/level 3/sub total score 4.jpg"))

(define colorLevel3ItemsFullBg (bitmap "Photos/Colors/level 3/baskets/items full.jpg"))
(define colorLevel3Item1Bg (bitmap "Photos/Colors/level 3/baskets/item 1.jpg"))
(define colorLevel3Item2Bg (bitmap "Photos/Colors/level 3/baskets/item 2.jpg "))
(define colorLevel3Item3Bg (bitmap "Photos/Colors/level 3/baskets/item 3.jpg"))
(define colorLevel3Item4Bg (bitmap "Photos/Colors/level 3/baskets/item 4.jpg"))
(define colorLevel3Item5Bg (bitmap "Photos/Colors/level 3/baskets/item 5.jpg "))
(define colorLevel3Item6Bg (bitmap "Photos/Colors/level 3/baskets/item 6.jpg  "))
(define colorLevel3Item7Bg (bitmap "Photos/Colors/level 3/baskets/item 7.jpg"))
(define colorLevel3Item8Bg (bitmap "Photos/Colors/level 3/baskets/item 8.jpg"))
(define colorLevel3Item9Bg (bitmap "Photos/Colors/level 3/baskets/item 9.jpg  "))
(define colorLevel3Item10Bg (bitmap "Photos/Colors/level 3/baskets/item 10.jpg"))
(define colorLevel3Item11Bg (bitmap "Photos/Colors/level 3/baskets/item 11.jpg "))
(define colorLevel3Item12Bg (bitmap "Photos/Colors/level 3/baskets/item 12 next.jpg"))

(define colorLevel3AwardBg (bitmap "Photos/Colors/level 3/award.jpg"))
(define colorlevel3Score16Bg (bitmap "Photos/Colors/level 3/score 16.jpg"))

;Color Tutorial
(define redTutorialBg (bitmap "Photos/tutorial/color/1 red/scene 1.jpg"))
(define redStrawberryBg (bitmap "Photos/tutorial/color/1 red/scene 3.jpg"))
(define redSign2Bg (bitmap "Photos/tutorial/color/1 red/scene 5.jpg"))
(define redEverythingBg (bitmap "Photos/tutorial/color/1 red/scene 6.jpg"))

(define orangeTutorialBg (bitmap "Photos/tutorial/color/2 orange/scene 1.jpg"))
(define orangeBasketBallBg (bitmap "Photos/tutorial/color/2 orange/scene 3.jpg"))
(define orangeCarrotBg (bitmap "Photos/tutorial/color/2 orange/scene 5.jpg"))
(define orangeEvrythingBg (bitmap "Photos/tutorial/color/2 orange/scene 6.jpg"))

(define yellowTutorialBg (bitmap "Photos/tutorial/color/3 yellow/scene 1.jpg"))
(define yellowBananaBg (bitmap "Photos/tutorial/color/3 yellow/scene  3.jpg"))
(define yellowTennisBallBg (bitmap "Photos/tutorial/color/3 yellow/scene 5.jpg"))
(define yellowEvrythingBg (bitmap "Photos/tutorial/color/3 yellow/scene 6.jpg"))

(define greenTutorialBg (bitmap "Photos/tutorial/color/4 green/scene 1.jpg"))
(define greenPearBg (bitmap "Photos/tutorial/color/4 green/scene 3.jpg"))
(define greenJuice2Bg (bitmap "Photos/tutorial/color/4 green/scene 5.jpg"))
(define greenEvrythingBg (bitmap "Photos/tutorial/color/4 green/scene 6.jpg"))

(define blueTutorialBg (bitmap "Photos/tutorial/color/5 blue/scene 1.jpg"))
(define blueBalloon2Bg (bitmap "Photos/tutorial/color/5 blue/scene 3.jpg"))
(define blueFlag2Bg (bitmap "Photos/tutorial/color/5 blue/scene 5.jpg"))
(define blueEvrythingBg (bitmap "Photos/tutorial/color/5 blue/scene 6.jpg"))

(define purpleTutorialBg (bitmap "Photos/tutorial/color/6 purple/scene 1.jpg"))
(define purpleEggplantBg (bitmap "Photos/tutorial/color/6 purple/scene 3.jpg"))
(define purpleOctopuse2Bg (bitmap "Photos/tutorial/color/6 purple/scene 5.jpg"))
(define purpleEvrythingBg (bitmap "Photos/tutorial/color/6 purple/scene 6.jpg"))

;Elevator Background
(define ElevatorBg (bitmap "Photos/elevator.jpg"))

;NumberLobby 
(define numberLobbyL1Bg (bitmap "Photos/Numbers/numbers level 1.jpg"))
(define numberLobbyL2Bg (bitmap "Photos/Numbers/numbers level 2.jpg"))
(define numberLobbyL3Bg (bitmap "Photos/Numbers/numbers level 3.jpg"))

;Number Level 1
(define numberLevel1Q1Bg (bitmap "Photos/Numbers/level 1/question 1.jpg"))
(define numberLevel1Q2Bg (bitmap "Photos/Numbers/level 1/question 2.jpg"))
(define numberLevel1Q3Bg (bitmap "Photos/Numbers/level 1/question 3.jpg"))
(define numberLevel1Q4Bg (bitmap "Photos/Numbers/level 1/question 4.jpg"))
(define numberLevel1Q5Bg (bitmap "Photos/Numbers/level 1/question 5.jpg"))
(define numberLevel1Score5Bg (bitmap "Photos/Numbers/level 1/scores/score 5.jpg"))

;Number Level 2
(define numberLevel2Q1Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q1.png"))
(define numberLevel2Q2Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q2.png"))
(define numberLevel2Q3Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q3.png"))
(define numberLevel2Q4Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q4.png"))
(define numberLevel2Q5Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q5.png"))
(define numberLevel2Q6Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q6.png"))
(define numberLevel2Q7Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q7.png"))
(define numberLevel2Q8Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q8.png"))
(define numberLevel2Q9Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q9.png"))
(define numberLevel2Q10Bg (bitmap "Photos/Numbers/level 2/NumberLevel2Q10.png"))
(define numberLevel2Score10 (bitmap "Photos/Numbers/level 2/level 2 score 10.jpg"))
(define numberLevel2Car (bitmap "Photos/Numbers/level 2/NumberLevel2Car.png"))

;Number Level 3
(define numberLevel3DoorBg (bitmap "Photos/Numbers/level 3/NumberLevel3Door.png"))
(define numberLevel3StartBg (bitmap "Photos/Numbers/level 3/NumberLevel3Start.png"))
(define numberLevel3Q1Bg (bitmap "Photos/Numbers/level 3/NumberLevel3Q1.png"))
(define numberLevel3Q2Bg (bitmap "Photos/Numbers/level 3/NumberLevel3Q2.png"))
(define numberLevel3Q3Bg (bitmap "Photos/Numbers/level 3/NumberLevel3Q3.png"))
(define numberLevel3Q4Bg (bitmap "Photos/Numbers/level 3/NumberLevel3Q4.png"))
(define numberLevel3Q5Bg (bitmap "Photos/Numbers/level 3/NumberLevel3Q5.png"))
(define numberLevel3ScoreBg (bitmap "Photos/Numbers/level 3/level 3 score 5.jpeg"))

;Number Tutorial
(define numb1TutorialBg (bitmap "Photos/tutorial/number/1/scene 1.jpg"))
(define numb1CountBg (bitmap "Photos/tutorial/number/1/scene 2.jpg"))

(define numb2TutorialBg (bitmap "Photos/tutorial/number/2/scene 1.jpg"))
(define numb2CountBg (bitmap "Photos/tutorial/number/2/scene 2.jpg"))

(define numb3TutorialBg (bitmap "Photos/tutorial/number/3/scene 1.jpg"))
(define numb3CountBg (bitmap "Photos/tutorial/number/3/scene 2.jpg"))

(define numb4TutorialBg (bitmap "Photos/tutorial/number/4/scene 1.jpg"))
(define numb4CountBg (bitmap "Photos/tutorial/number/4/scene 2.jpg"))

(define numb5TutorialBg (bitmap "Photos/tutorial/number/5/scene 1.jpg"))
(define numb5CountBg (bitmap "Photos/tutorial/number/5/scene 2.jpg"))

(define numb6TutorialBg (bitmap "Photos/tutorial/number/6/scene 1.jpg"))
(define numb6CountBg (bitmap "Photos/tutorial/number/6/scene 2.jpg"))

(define numb7TutorialBg (bitmap "Photos/tutorial/number/7/scene 1.jpg"))
(define numb7CountBg (bitmap "Photos/tutorial/number/7/scene 2.jpg"))

(define numb8TutorialBg (bitmap "Photos/tutorial/number/8/scene 1.jpg"))
(define numb8CountBg (bitmap "Photos/tutorial/number/8/scene 2.jpg"))

(define numb9TutorialBg (bitmap "Photos/tutorial/number/9/scene 1.jpg"))
(define numb9CountBg (bitmap "Photos/tutorial/number/9/scene 2.jpg"))

(define numb10TutorialBg (bitmap "Photos/tutorial/number/10/scene 1.jpg"))
(define numb10CountBg (bitmap "Photos/tutorial/number/10/scene 2.jpg"))

; pixel character
;for getting x,y position of stuff (Testing Purposes)
;(define skinBoyWest (line 0 2 "red"))
;(define skinBoyEast (line 0 2 "red"))
;(define skinBoyNorth (line 0 2 "red"))
;(define skinBoySouth (line 0 2 "red"))

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================

;Purpose: Draws the menu 
;Contract: menu --> image
(define drawMenu    
  (place-image menuBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define swMenu (begin (thread playButtonClick1Sound)(make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

; I have Menu in menu cuz its basically the menu
(define Menu (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0))

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
;************************************ Character Info ***********************************
;=======================================================================================
;purpose:draw the character info selections
;cotract: drawCharacterInfo: world --> image
(define (drawCharacterInfo world)
     (cond
          [(string=? (world-scene world) "characterInfo1")
          (place-image characterInfo1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "characterInfo2")
          (place-image characterInfo2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "characterInfo3")
          (place-image characterInfo3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "characterInfo4")
          (place-image characterInfo4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]))


;shows the boy skin character info once clicked
(define (swInfoBoy w) (begin (thread playButtonClick1Sound) (make-world "characterInfo1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;shows the janitor skin character info once clicked
(define (swInfoJanitor w) (begin (thread playButtonClick1Sound) (make-world "characterInfo2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;shows the scientist skin character info once clicked
(define (swInfoScientist w) (begin (thread playButtonClick1Sound) (make-world "characterInfo3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;shows the policeWoman skin character info once clicked
(define (swInfoPoliceWoman w) (begin (thread playButtonClick1Sound) (make-world "characterInfo4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;=======================================================================================
;************************************ Shape Game ***************************************
;=======================================================================================

;Purpose: Draws The lobbies of the shape game
;Contract: drawShapeLobby: world --> image
(define (drawShapeLobby world) 
     (cond
          [(string=? (world-scene world) "shapeLobbyL1")
          (place-image  
            (skinUpdater (Character-skin (world-character world)))
                                              (ChPos-x (Character-pos (world-character world))) 
                                              (ChPos-y (Character-pos (world-character world)))
                                              shapeLobbyL1Bg)]
          [(string=? (world-scene world) "shapeLobbyL2")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLobbyL2Bg)]   
          [(string=? (world-scene world) "shapeLobbyL3")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLobbyL3Bg)]))
;test

;Purpose: Draws The Levels of the shape game 
(define (drawShapeLevel world) 
     (cond

          [(string=? (world-scene world) "shapeLevel1Q1")
          (place-image shapeLevel1Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel1Q2")
          (place-image shapeLevel1Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel1Q3")
          (place-image shapeLevel1Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel1Q4")
          (place-image shapeLevel1Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel1Q5")
          (place-image shapeLevel1Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel1Score5")
          (place-image shapeLevel1Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel2Score8")
          (place-image shapeLevel2Score8Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score5")
          (place-image shapeLevel3Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
          [(string=? (world-scene world) "shapeLevel3")
         (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel3P1Bg)]
          [(string=? (world-scene world) "p1Rectangle")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel3P2Bg)]
          [(string=? (world-scene world) "p2Square")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel3P3Bg)]
          [(string=? (world-scene world) "p3Circle")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel3P4Bg)]
          [(string=? (world-scene world) "p4Triangle")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel3P5Bg)]
          [(string=? (world-scene world) "shapeLevel3Score5")
          (place-image shapeLevel3Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
          

          [(string=? (world-scene world) "shapeLevel2Path1")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel2Path1Bg)]       

          [(string=? (world-scene world) "shapeLevel2Path2")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel2Path2Bg)] 

          [(string=? (world-scene world) "shapeLevel2Path3")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel2Path3Bg)]       

          [(or (string=? (world-scene world) "deadEnd1") (string=? (world-scene world) "deadEnd2") (string=? (world-scene world) "deadEnd3"))
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel2PathDeadEndBg)]                                                                                                                       

          [(string=? (world-scene world) "shapeLevel2Train")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLevel2TrainBg)]                                                                           

        [(string=? (world-scene world) "squareCart")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         squareCartBg)]
        [(string=? (world-scene world) "circleCart")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         circleCartBg)]
        [(string=? (world-scene world) "triangleCart")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         triangleCartBg)]
        [(string=? (world-scene world) "pentagonCart")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         pentagonCartBg)]
        [(string=? (world-scene world) "rectangleCart")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         rectangleCartBg)] 
                                         
                                         
         [(string=? (world-scene world) "shapeLevel3Q1")
          (place-image shapeLevel3Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Q2")
          (place-image shapeLevel3Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Q3")
          (place-image shapeLevel3Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Q4")
          (place-image shapeLevel3Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Q5")
          (place-image shapeLevel3Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
          [(string=? (world-scene world) "shapeLevel3Score0Retry")
          (place-image shapeLevel3Score0RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score1Retry")
          (place-image shapeLevel3Score1RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score2Retry")
          (place-image shapeLevel3Score2RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score3Retry")
          (place-image shapeLevel3Score3RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score4Retry")
          (place-image shapeLevel3Score4RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score5Retry")
          (place-image shapeLevel3Score5RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score6Retry")
          (place-image shapeLevel3Score6RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score7Retry")
          (place-image shapeLevel3Score7RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score8Retry")
          (place-image shapeLevel3Score8RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3Score9Retry")
          (place-image shapeLevel3Score9RetryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]))                                

;Elevator image basically 
(define elevator    
  (place-image ElevatorBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define (swShapeLobbyL1 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLobbyL2 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLobbyL3 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeLevel1 w) (begin (thread playBellRingSound) (make-world "shapeLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel2 w) (begin (thread playBellRingSound) (make-world "shapeLevel2Path1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3 w) (begin (thread playBellRingSound) (make-world "shapeLevel3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 105 488) 0) 0)))
(define (swShapeLevel2Train w) (begin (thread playBellRingSound) (make-world "shapeLevel2Train" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeElevator w) (begin (thread playBellRingSound) (make-world "shapeElevator" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeLevel1Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel1Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel1Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel1Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel1Score5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Score5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel2Score8 w) 
    (cond
        [(string=? (skin-name (Character-skin (world-character w))) "pentagonBoy") (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel2Score8" (make-Character (make-skin "boy" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "pentagonJanitor") (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Score5" (make-Character (make-skin "janitor" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "pentagonScientist") (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Score5" (make-Character (make-skin "scientist" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "pentagonPoliceWoman") (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Score5" (make-Character (make-skin "policewoman" "up") (make-ChPos 960 890) 0) 0))]
        [else w]))
(define (swShapeLevel3Score5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Score5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeLevel3Q1 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel3Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeLevel3Score0Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score0Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score1Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score1Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score2Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score2Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score3Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score3Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score4Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score4Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score5Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score5Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score6Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score6Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score7Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score7Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score8Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score8Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swShapeLevel3Score9Retry w) (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel3Score9Retry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swShapeLevel3RetryButton w) (begin (thread playButtonClick1Sound) (make-world "shapeLevel3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 105 488) 0) 0)))
(define (swShapeLevel3RetryButton2 w) (begin (thread playButtonClick1Sound) (make-world "shapeLevel3Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 105 488) 0) 0)))


(define (swShapeLevel2Path1 w) (make-world "shapeLevel2Path1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swShapeLevel2Path2 w) (make-world "shapeLevel2Path2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swShapeLevel2Path3 w) (make-world "shapeLevel2Path3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swShapeLevel2DeadEnd1 w) (make-world "deadEnd1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swShapeLevel2DeadEnd2 w) (make-world "deadEnd2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swShapeLevel2DeadEnd3 w) (make-world "deadEnd3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))

(define (swShapeLevel3Path w) (begin (thread playCorrectAnswerEffectSound) (make-world "p1Rectangle" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 436 634) 0) 0)))
(define (swRectangleP1 w) (begin (thread playCorrectAnswerEffectSound) (make-world "p1Rectangle" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 436 634) 0) 0)))
(define (swSquareP2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "p2Square" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 688 377) 0) 0)))
(define (swCircleP3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "p3Circle" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 957 633) 0) 0)))
(define (swTriangleP4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "p4Triangle" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 1210 374) 0) 0)))

(define (swCircleTutorial w) (begin (thread playShapeTutorialAudio) (make-world "circleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) 0)))
(define (swCSunTutorial w) (make-world "cSunTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swCBallTutorial w) (make-world "cBallTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swCTireTutorial w) (make-world "cTireTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swCManyOtherPlacesTutorial w) (make-world "cManyOtherPlacesTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swSquareTutorial w) (make-world "squareTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swSPizzaBoxTutorial w) (make-world "sPizzaBoxTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swSWaffleTutorial w) (make-world "sWaffleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swSTostTutorial w) (make-world "sTostTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swSManyOtherPlacesTutorial w) (make-world "sManyOtherPlacesTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swTriangleTutorial w) (make-world "triangleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swTBirthdayHatTutorial w) (make-world "tBirthdayHatTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swTSandwhichTutorial w) (make-world "tSandwhichTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swTSailingBoatTutorial w) (make-world "tSailingBoatTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swTManyOtherPlacesTutorial w) (make-world "tManyOtherPlacesTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swRectangleTutorial w) (make-world "rectangleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swRBookTutorial w) (make-world "rBookTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swRPuzzleTutorial w) (make-world "rPuzzleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swRDoorTutorial w) (make-world "rDoorTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swRManyOtherPlacesTutorial w) (make-world "rManyOtherPlacesTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swPentagonTutorial w) (make-world "pentagonTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swPGemTutorial w) (make-world "pGemTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swPDogHouseTutorial w) (make-world "pDogHouseTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swPClockTutorial w) (make-world "pClockTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))
(define (swPManyOtherPlacesTutorial w) (make-world "pManyOtherPlacesTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right") (make-ChPos 960 890) 0) (world-t w)))

;purpose: switches the scenes of the right path 
;contract swPathR: world --> world
(define (swPathR world)
    (cond 
        [(string=? (world-scene world) "shapeLevel2Path1") (swShapeLevel2Path2 world)]
        [(string=? (world-scene world) "shapeLevel2Path2") (swShapeLevel2Path3 world)]
        [(string=? (world-scene world) "shapeLevel2Path3") (swShapeLevel2DeadEnd3 world)]))

;purpose: switches the scenes of the right path 
;contract swPathR: world --> world
(define (swPathL world)
    (cond 
        [(string=? (world-scene world) "shapeLevel2Path1") (swShapeLevel2DeadEnd1 world)]
        [(string=? (world-scene world) "shapeLevel2Path2") (swShapeLevel2DeadEnd2 world)]
        [(string=? (world-scene world) "shapeLevel2Path3") (swShapeLevel2Train world)]))


;purpose: switches the scenes of the right path 
;contract swPathR: world --> world
(define (swPathDeadEnd world)
    (cond 
        [(string=? (world-scene world) "deadEnd1") (swShapeLevel2Path1 world)]
        [(string=? (world-scene world) "deadEnd2") (swShapeLevel2Path2 world)]
        [(string=? (world-scene world) "deadEnd3") (swShapeLevel2Path3 world)]))

;test

;purpose: changes the skin of the character to the circle version of the skin
;contract: changeSkinToCircle: world --> world
(define (changeSkinToCircle world)
      (cond
      [(or (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (skin-name (Character-skin (world-character world))) "pentagonBoy") (string=? (skin-name (Character-skin (world-character world))) "rectangleBoy") (string=? (skin-name (Character-skin (world-character world))) "squareBoy") (string=? (skin-name (Character-skin (world-character world))) "triangleBoy"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "circleBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (skin-name (Character-skin (world-character world))) "pentagonJanitor") (string=? (skin-name (Character-skin (world-character world))) "rectangleJanitor") (string=? (skin-name (Character-skin (world-character world))) "squareJanitor") (string=? (skin-name (Character-skin (world-character world))) "triangleJanitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "circleJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (skin-name (Character-skin (world-character world))) "pentagonScientist") (string=? (skin-name (Character-skin (world-character world))) "rectangleScientist") (string=? (skin-name (Character-skin (world-character world))) "squareScientist") (string=? (skin-name (Character-skin (world-character world))) "triangleScientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "circleScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (skin-name (Character-skin (world-character world))) "pentagonPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "rectanglePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "squarePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "trianglePoliceWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "circlePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [else world]))

;purpose: changes the skin of the character to the pentagon version of the skin
;contract: changeSkinToPentagon: world --> world
(define (changeSkinToPentagon world)
      (cond
      [(or (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (skin-name (Character-skin (world-character world))) "circleBoy") (string=? (skin-name (Character-skin (world-character world))) "rectangleBoy") (string=? (skin-name (Character-skin (world-character world))) "squareBoy") (string=? (skin-name (Character-skin (world-character world))) "triangleBoy"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "pentagonBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (skin-name (Character-skin (world-character world))) "circleJanitor") (string=? (skin-name (Character-skin (world-character world))) "rectangleJanitor") (string=? (skin-name (Character-skin (world-character world))) "squareJanitor") (string=? (skin-name (Character-skin (world-character world))) "triangleJanitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "pentagonJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (skin-name (Character-skin (world-character world))) "circleScientist") (string=? (skin-name (Character-skin (world-character world))) "rectangleScientist") (string=? (skin-name (Character-skin (world-character world))) "squareScientist") (string=? (skin-name (Character-skin (world-character world))) "triangleScientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "pentagonScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (skin-name (Character-skin (world-character world))) "circlePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "rectanglePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "squarePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "trianglePoliceWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "pentagonPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [else world]))

;pupose: changes the skin of the character to the rectangle version of the skin
;contract: changeSkinToRectangle: world --> world
(define (changeSkinToRecatngle world)
      (cond
      [(or (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (skin-name (Character-skin (world-character world))) "pentagonBoy") (string=? (skin-name (Character-skin (world-character world))) "circleBoy") (string=? (skin-name (Character-skin (world-character world))) "squareBoy") (string=? (skin-name (Character-skin (world-character world))) "triangleBoy"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "rectangleBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (skin-name (Character-skin (world-character world))) "pentagonJanitor") (string=? (skin-name (Character-skin (world-character world))) "circleJanitor") (string=? (skin-name (Character-skin (world-character world))) "squareJanitor") (string=? (skin-name (Character-skin (world-character world))) "triangleJanitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "rectangleJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (skin-name (Character-skin (world-character world))) "pentagonScientist") (string=? (skin-name (Character-skin (world-character world))) "circleScientist") (string=? (skin-name (Character-skin (world-character world))) "squareScientist") (string=? (skin-name (Character-skin (world-character world))) "triangleScientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "rectangleScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (skin-name (Character-skin (world-character world))) "pentagonPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "circlePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "squarePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "trianglePoliceWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "rectanglePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [else world]))

;purpose: changes the skin of the character to the square version of the skin
;contract: changeSkinToSquare: world --> world
(define (changeSkinToSqaure world)
      (cond
      [(or (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (skin-name (Character-skin (world-character world))) "pentagonBoy") (string=? (skin-name (Character-skin (world-character world))) "circleBoy") (string=? (skin-name (Character-skin (world-character world))) "rectangleBoy") (string=? (skin-name (Character-skin (world-character world))) "triangleBoy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "squareBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (skin-name (Character-skin (world-character world))) "pentagonJanitor") (string=? (skin-name (Character-skin (world-character world))) "circleJanitor") (string=? (skin-name (Character-skin (world-character world))) "rectangleJanitor") (string=? (skin-name (Character-skin (world-character world))) "triangleJanitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "squareJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (skin-name (Character-skin (world-character world))) "pentagonScientist") (string=? (skin-name (Character-skin (world-character world))) "circlelcientist") (string=? (skin-name (Character-skin (world-character world))) "rectangleScientist") (string=? (skin-name (Character-skin (world-character world))) "triangleScientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "squareScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (skin-name (Character-skin (world-character world))) "pentagonPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "circlePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "rectanglePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "trianglePoliceWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "squarePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [else world]))

;purpose: changes the skin of the character to the triangle version of the skin
;contract: changeSkinToTriangle: world --> world
(define (changeSkinToTriangle world)
      (cond
      [(or (string=? (skin-name (Character-skin (world-character world))) "boy") (string=? (skin-name (Character-skin (world-character world))) "pentagonBoy") (string=? (skin-name (Character-skin (world-character world))) "rectangleBoy") (string=? (skin-name (Character-skin (world-character world))) "squareBoy") (string=? (skin-name (Character-skin (world-character world))) "circleBoy"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "triangleBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "janitor") (string=? (skin-name (Character-skin (world-character world))) "pentagonJanitor") (string=? (skin-name (Character-skin (world-character world))) "rectangleJanitor") (string=? (skin-name (Character-skin (world-character world))) "squareJanitor") (string=? (skin-name (Character-skin (world-character world))) "circleJanitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "triangleJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "scientist") (string=? (skin-name (Character-skin (world-character world))) "pentagonScientist") (string=? (skin-name (Character-skin (world-character world))) "rectangleScientist") (string=? (skin-name (Character-skin (world-character world))) "squareScientist") (string=? (skin-name (Character-skin (world-character world))) "circleScientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "triangleScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [(or (string=? (skin-name (Character-skin (world-character world))) "policeWoman") (string=? (skin-name (Character-skin (world-character world))) "pentagonPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "rectanglePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "squarePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "circlePoliceWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "trianglePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
      [else world]))

;purpose: fills the cart if the correct shape is placed in the cart
;contract: correctSkinToCart: world --> world
(define (correctSkinToCart world)
  (cond
     [(and (string=? (skin-name (Character-skin (world-character world))) "squareBoy") (string=? (world-scene world) "shapeLevel2Train"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "squareCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "circleBoy") (string=? (world-scene world) "squareCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "circleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "triangleBoy") (string=? (world-scene world) "circleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "triangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "rectangleBoy") (string=? (world-scene world) "triangleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "rectangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "pentagonBoy") (string=? (world-scene world) "rectangleCart"))
          (swShapeLevel2Score8 world)]

     [(and (string=? (skin-name (Character-skin (world-character world))) "squareJanitor") (string=? (world-scene world)  "shapeLevel2Train"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "squareCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "circleJanitor") (string=? (world-scene world)  "squareCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "circleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "triangleJanitor") (string=? (world-scene world)  "circleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "triangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "rectangleJanitor") (string=? (world-scene world)  "triangleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "rectangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "pentagonJanitor") (string=? (world-scene world)   "rectangleCart"))
          (swShapeLevel2Score8 world)]
    
     [(and (string=? (skin-name (Character-skin (world-character world))) "squareScientist") (string=? (world-scene world)  "shapeLevel2Train"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "squareCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "circleScientist") (string=? (world-scene world)  "squareCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "circleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "triangleScientist") (string=? (world-scene world)  "circleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "triangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "rectangleScientist") (string=? (world-scene world) "triangleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "rectangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "pentagonScientist") (string=? (world-scene world) "rectangleCart"))
          (swShapeLevel2Score8 world)]
   
     [(and (string=? (skin-name (Character-skin (world-character world))) "squarePoliceWoman") (string=? (world-scene world) "shapeLevel2Train"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "squareCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "circlePoliceWoman") (string=? (world-scene world) "squareCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "circleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "trianglePoliceWoman") (string=? (world-scene world) "circleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "triangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "rectanglePoliceWoman") (string=? (world-scene world) "triangleCart"))
           (begin (thread playCorrectAnswerEffectSound) (make-world "rectangleCart" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "pentagonPoliceWoman") (string=? (world-scene world) "rectangleCart"))
          (swShapeLevel2Score8 world)]
    
     [else (wrongAnswer world)]))

;=======================================================================================
;************************************ Color Game ***************************************
;=======================================================================================
;purpose: draw the lobbies/levels of the color game
;contract: drawColorLobby: world --> image
;test
(check-expect (drawColorLobby (make-world "colorLobbyL1" (make-Character (make-skin "trianglePoliceWoman" "right") (make-ChPos 100 100)) 0)) 
                              (place-image (skinUpdater (make-skin "trianglePoliceWoman" "right")) 100 100 colorLobbyL1Bg))
(check-expect (drawColorLobby (make-world "colorLobbyL2" (make-Character (make-skin "rectanglePoliceWoman" "left") (make-ChPos 200 200)) 0))
                              (place-image (skinUpdater (make-skin "rectanglePoliceWoman" "left")) 200 200 colorLobbyL2Bg))
(check-expect (drawColorLobby (make-world "colorLobbyL1" (make-Character (make-skin "pentagonPoliceWoman" "up") (make-ChPos 300 300))  0)) 
                              (place-image (skinUpdater (make-skin "pentagonPoliceWoman" "up")) 300 300 colorLobbyL1Bg))
;function
(define (drawColorLobby world)
     (cond
          [(string=? (world-scene world) "colorLobbyL1")
          (place-image  
            (skinUpdater (Character-skin (world-character world))) 
                                              (ChPos-x (Character-pos (world-character world))) 
                                              (ChPos-y (Character-pos (world-character world)))
                                              colorLobbyL1Bg)]

          [(string=? (world-scene world) "colorLobbyL2")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLobbyL2Bg)]   
                                         
          [(string=? (world-scene world) "colorLobbyL3")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLobbyL3Bg)]
                                         
            [(string=? (world-scene world) "colorLevel2RedFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2RedFrameBg)]
                                         
             [(string=? (world-scene world) "colorLevel2OrangeFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2OrangeFrameBg)]
                                         
            [(string=? (world-scene world) "colorLevel2YellowFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2YellowFrameBg)]
                                         
            [(string=? (world-scene world) "colorLevel2GreenFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2GreenFrameBg)]
                                         
            [(string=? (world-scene world) "colorLevel2BlueFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2BlueFrameBg)]
                                         
            [(string=? (world-scene world) "colorLevel2PurpleFrame")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2PurpleFrameBg)]
                                         
            [(string=? (world-scene world) "colorLevel3KeyDoor")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel3KeyDoorBg)]
                                         
            [(string=? (world-scene world) "colorLevel3Classroom")
          (place-image  
    (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel3ClassroomBg)]
                                         
             [(string=? (world-scene world) "colorLevel3Door2")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel3Door2Bg)]))

;Purpose: Draws The Levels of the Color game 
;contract: drawColorLevel: world --> image
;test
(check-expect (drawColorLevel (make-world "colorLevel1Q1"  (make-Character (make-skin "trianglePoliceWoman" "right")  (make-ChPos worldCenterWidth worldCenterHeight)) 0)) 
                              (place-image colorLevel1Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
(check-expect (drawColorLevel (make-world "colorLevel3Q1"  (make-Character (make-skin "rectanglePoliceWoman" "left")  (make-ChPos worldCenterWidth worldCenterHeight)) 0)) 
                              (place-image colorLevel3Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
(check-expect (drawColorLevel (make-world "colorLevel1Q2"  (make-Character  (make-skin "pentagonPoliceWoman" "up")  (make-ChPos worldCenterWidth worldCenterHeight))  0)) 
                              (place-image colorLevel1Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
;function
(define (drawColorLevel world) 
     (cond
          [(string=? (world-scene world) "colorLevel1Q1")
          (place-image colorLevel1Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel1Q2")
          (place-image colorLevel1Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel1Q3")
          (place-image colorLevel1Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel1Q4")
          (place-image colorLevel1Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel1Q5")
          (place-image colorLevel1Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

          [(string=? (world-scene world) "colorLevel3Q1")
          (place-image colorLevel3Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Q2")
          (place-image colorLevel3Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Q3")
          (place-image colorLevel3Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

          [(string=? (world-scene world) "colorLevel3ItemsFull")
          (place-image colorLevel3ItemsFullBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item1")
          (place-image colorLevel3Item1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item2")
          (place-image colorLevel3Item2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item3")
          (place-image colorLevel3Item3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item4")
          (place-image colorLevel3Item4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item5")
          (place-image colorLevel3Item5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item6")
          (place-image colorLevel3Item6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item7")
          (place-image colorLevel3Item7Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item8")
          (place-image colorLevel3Item8Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item9")
          (place-image colorLevel3Item9Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item10")
          (place-image colorLevel3Item10Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item11")
          (place-image colorLevel3Item11Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Item12")
          (place-image colorLevel3Item12Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
          [(string=? (world-scene world) "itemFull")
          (place-image colorLevel3ItemsFullBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item1")
          (place-image colorLevel3Item1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item2")
          (place-image colorLevel3Item1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item3")
          (place-image colorLevel3Item2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item4")
          (place-image colorLevel3Item3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item5")
          (place-image colorLevel3Item4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item6")
          (place-image colorLevel3Item5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item7")
          (place-image colorLevel3Item6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item8")
          (place-image colorLevel3Item7Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item9")
          (place-image colorLevel3Item8Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item10")
          (place-image colorLevel3Item9Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "item11")
          (place-image colorLevel3Item10Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "item12")
          (place-image colorLevel3Item11Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
         [(string=? (world-scene world) "colorLevel2Q1")
          (place-image colorLevel2Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Q2")
          (place-image colorLevel2Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Q3")
          (place-image colorLevel2Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Q4")
          (place-image colorLevel2Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Q5")
          (place-image colorLevel2Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Q6")
          (place-image colorLevel2Q6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

          [(string=? (world-scene world) "colorLevel2")
          (place-image  
   (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2Bg)]
                                         
                                         
          [(string=? (world-scene world) "colorLevel3Award")
          (place-image colorLevel3AwardBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]))

;purpose: draws the score screens of the color game
;contract: drawColorScore: world --> image
;test
(check-expect (drawColorScore (make-world "colorLevel1Score5"  (make-Character  (make-skin "trianglePoliceWoman" "up")  (make-ChPos worldCenterWidth worldCenterHeight))  0)) 
                                (place-image colorLevel1Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
(check-expect (drawColorScore (make-world "colorLevel2Score6"  (make-Character  (make-skin "rectanglePoliceWoman" "up")  (make-ChPos worldCenterWidth worldCenterHeight))  0)) 
                                (place-image colorLevel2Score6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
(check-expect (drawColorScore (make-world "colorLevel3Score16" (make-Character (make-skin "pentagonPoliceWoman" "up") (make-ChPos worldCenterWidth worldCenterHeight)) 0)) 
                                (place-image colorlevel3Score16Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))
;function
(define (drawColorScore world)
      (cond
          [(string=? (world-scene world) "colorLevel1Score5")
          (place-image colorLevel1Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel2Score6")
          (place-image colorLevel2Score6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3SubScore")
          (place-image colorlevel3SubScoreBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "colorLevel3Score16")
          (place-image colorlevel3Score16Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]))

;lobbies        
(define (swColorLobbyL1 w) (begin (thread playBellRingSound) (make-world "colorLobbyL1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLobbyL2 w) (begin (thread playBellRingSound) (make-world "colorLobbyL2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLobbyL3 w) (begin (thread playBellRingSound) (make-world "colorLobbyL3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

;level 1
(define (swColorLevel1 w) (begin (thread playBellRingSound) (make-world "colorLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2 w) (begin (thread playBellRingSound) (make-world "colorLevel2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorElevator w) (begin (thread playBellRingSound) (make-world "colorElevator" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel1Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel1Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel1Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel1Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel1Score5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Score5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

;level 2
(define (swColorLevel2Q1 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel2Q6 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Q6" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel2Score6 w)
    (cond
        [(string=? (skin-name (Character-skin (world-character w))) "purpleBoy") (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Score6" (make-Character (make-skin "boy" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "purpleJanitor") (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Score6" (make-Character (make-skin "janitor" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "purpleScientist") (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Score6" (make-Character (make-skin "scientist" "up") (make-ChPos 960 890) 0) 0))]
        [(string=? (skin-name (Character-skin (world-character w))) "purplePoliceWoman") (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel2Score6" (make-Character (make-skin "policeWoman" "up") (make-ChPos 960 890) 0) 0))]
        [else w])) 

;level 3
(define (swColorLevel3Q1 w) (begin (thread playButtonClick1Sound) (make-world "colorLevel3Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel3Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel3Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3SubScore w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel3SubScore" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel3Classroom w) (begin (thread playBellRingSound) (make-world "colorLevel3Classroom" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3Door2 w) (begin (thread playBellRingSound) (make-world "colorLevel3Door2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel3ItemsFull w) (begin (thread playButtonClick1Sound) (make-world "colorLevel3ItemsFull" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3KeyDoor w) (begin (thread playBellRingSound) (make-world "colorLevel3KeyDoor" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swColorLevel3Award w) (begin (thread playBellRingSound) (make-world "colorLevel3Award" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swColorLevel3Score16 w) (begin (thread playButtonClick1Sound) (make-world "colorLevel3Score16" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

;Tutorial
(define (swRedTutorial w) (begin (thread playColorTutorialAudio) (make-world "redTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swRedStrawberry w) (make-world "redStrawberry" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swRedSign2 w) (make-world "redSign2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swRedEverything w) (make-world "redEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

(define (swOrangeTutorial w) (make-world "orangeTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swOrangeBasketBall w) (make-world "orangeBasketBall" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swOrangeCarrot w) (make-world "orangeCarrot" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swOrangeEverything w) (make-world "orangeEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

(define (swYellowTutorial w) (make-world "yellowTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swYellowBanana w) (make-world "yellowBanana" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swYellowTennisBall w) (make-world "yellowTennisBall" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swYellowEverything w) (make-world "yellowEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

(define (swGreenTutorial w) (make-world "greenTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swGreenPear w) (make-world "greenPear" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swGreenJuice2 w) (make-world "greenJuice2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swGreenEverything w) (make-world "greenEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

(define (swBlueTutorial w) (make-world "blueTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swBlueBalloon2 w) (make-world "blueBalloon2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swBlueFlag2 w) (make-world "blueFlag2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swBlueEverything w) (make-world "blueEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

(define (swPurpleTutorial w) (make-world "purpleTutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swPurpleEggplant w) (make-world "purpleEggplant" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swPurpleOctopuse2 w) (make-world "purpleOctopuse2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))
(define (swPurpleEverything w) (make-world "purpleEverything" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) (world-t w)))

;purpose: changes the skin of the character to the red version of the skin
;contract: changeSkinToRed: world(w) --> world
;test
;function
(define (changeSkinToRed world) 
      (cond 
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "redBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "redJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "redScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "redPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;pupose: changes the skin of the character to the orange version of the skin
;contract: changeSkinToOrange: world(w) --> world
;test
;function
(define (changeSkinToOrange world)
      (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;pupose: changes the skin of the character to the yellow version of the skin
;contract: changeSkinToYellow: world(w) --> world
;test
;function
(define (changeSkinToYellow world)
      (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;pupose: changes the skin of the character to the green version of the skin
;contract: changeSkinToGreen: world(w) --> world
;test
(define (changeSkinToGreen world)
       (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "greenBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "greenJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "greenScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "greenPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;pupose: changes the skin of the character to the blue version of the skin
;contract: changeSkinToBlue: world(w) --> world
;test         
;function
(define (changeSkinToBlue world)
       (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "bluePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;pupose: changes the skin of the character to the purple version of the skin
;contract: changeSkinToPurple: world(w) --> world
;test
;function
(define (changeSkinToPurple world)
       (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "purpleBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "purpleJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "purpleScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "purplePoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))


;purpose:changes the color of the frame when the correct color skin clicks on it
;contract: correctSkinToFrame: world --> world
;test   
;function
(define (correctSkinToFrame world)
  (cond
     [(and (string=? (skin-name (Character-skin (world-character world))) "redBoy") (string=? (world-scene world) "colorLevel2"))
           (begin (thread playPaintSoundEffect) (make-world "colorLevel2RedFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "orangeBoy") (string=? (world-scene world) "colorLevel2RedFrame"))
          (begin (thread playPaintSoundEffect)(make-world "colorLevel2OrangeFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "yellowBoy") (string=? (world-scene world) "colorLevel2OrangeFrame"))
          (begin (thread playPaintSoundEffect)(make-world "colorLevel2YellowFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "greenBoy") (string=? (world-scene world) "colorLevel2YellowFrame"))
          (begin (thread playPaintSoundEffect)(make-world "colorLevel2GreenFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueBoy") (string=? (world-scene world) "colorLevel2GreenFrame"))
          (begin (thread playPaintSoundEffect)(make-world "colorLevel2BlueFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "purpleBoy") (string=? (world-scene world)  "colorLevel2BlueFrame"))
        (begin (thread playPaintSoundEffect) (make-world "colorLevel2Score6" (make-Character (make-skin "boy" "up") (make-ChPos 960 890) 0) 0))]

     [(and (string=? (skin-name (Character-skin (world-character world))) "redJanitor") (string=? (world-scene world)  "colorLevel2"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2RedFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "orangeJanitor") (string=? (world-scene world)  "colorLevel2RedFrame"))
         (begin (thread playPaintSoundEffect) (make-world "colorLevel2OrangeFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "yellowJanitor") (string=? (world-scene world)  "colorLevel2OrangeFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2YellowFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "greenJanitor") (string=? (world-scene world)  "colorLevel2YellowFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2GreenFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueJanitor") (string=? (world-scene world)   "colorLevel2GreenFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2BlueFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "purpleJanitor") (string=? (world-scene world)  "colorLevel2BlueFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2Score6" (make-Character (make-skin "janitor" "up") (make-ChPos 960 890) 0) 0))]

     [(and (string=? (skin-name (Character-skin (world-character world))) "redScientist") (string=? (world-scene world)  "colorLevel2"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2RedFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "orangeScientist") (string=? (world-scene world)  "colorLevel2RedFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2OrangeFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "yellowScientist") (string=? (world-scene world)  "colorLevel2OrangeFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2YellowFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "greenScientist") (string=? (world-scene world)  "colorLevel2YellowFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2GreenFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueScientist") (string=? (world-scene world)   "colorLevel2GreenFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2BlueFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "purpleScientist") (string=? (world-scene world)  "colorLevel2BlueFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2Score6" (make-Character (make-skin "scientist" "up") (make-ChPos 960 890) 0) 0))]

     [(and (string=? (skin-name (Character-skin (world-character world))) "redPoliceWoman") (string=? (world-scene world)  "colorLevel2"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2RedFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "orangePoliceWoman") (string=? (world-scene world)  "colorLevel2RedFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2OrangeFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "yellowPoliceWoman") (string=? (world-scene world)  "colorLevel2OrangeFrame"))
         (begin (thread playPaintSoundEffect)  (make-world "colorLevel2YellowFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "greenPoliceWoman") (string=? (world-scene world)  "colorLevel2YellowFrame"))
         (begin (thread playPaintSoundEffect)  (make-world "colorLevel2GreenFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "bluePoliceWoman") (string=? (world-scene world)   "colorLevel2GreenFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2BlueFrame" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "purplePoliceWoman") (string=? (world-scene world)  "colorLevel2BlueFrame"))
          (begin (thread playPaintSoundEffect) (make-world "colorLevel2Score" (make-Character (make-skin "policeWoman" "up") (make-ChPos 960 890) 0) 0))]

     [else (wrongAnswer world)]))

;purpose: changes the skin of the character to the blue key version of the skin
;contract: changeSkinToBlueKey: world(w) --> world
;test
;function
(define (changeSkinToBlueKey world)
        (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeKeyBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyBoy")  (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueKeyBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueKeyJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueKeyScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "orangeKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "blueKeyPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;purpose: changes the skin of the character to the orange key version of the skin
;contract: changeSkinToOrangeKey: world(w) --> world
;test              
;function
(define (changeSkinToOrangeKey world)
        (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyBoy") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyBoy")  (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeKeyBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeKeyJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeKeyScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "yellowKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "orangeKeyPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;purpose: changes the skin of the character to the yellow key version of the skin
;contract: changeSkinToYellowKey: world(w) --> world
;test
(check-expect (changeSkinToYellowKey (make-world "colorLevel1Q1" (make-Character (make-skin "blueKeyBoy" "up") (make-ChPos 960 890) 0) 0)) 
                                    (make-world "colorLevel1Q1" (make-Character (make-skin "yellowKeyBoy" "up") (make-ChPos 960 890) 0) 0))
(check-expect (changeSkinToYellowKey (make-world "colorLevel1Q1" (make-Character (make-skin "blueKeyJanitor" "up") (make-ChPos 960 890) 0) 0))
                                    (make-world "colorLevel1Q1" (make-Character (make-skin "yellowKeyJanitor" "up") (make-ChPos 960 890) 0) 0)) 
(check-expect (changeSkinToYellowKey (make-world "colorLevel1Q1" (make-Character (make-skin "blueKeyScientist" "up") (make-ChPos 960 890) 0) 0))
                                    (make-world "colorLevel1Q1" (make-Character (make-skin "yellowKeyScientist" "up") (make-ChPos 960 890) 0) 0))           
;function
(define (changeSkinToYellowKey world)
        (cond
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyBoy") (string=? (skin-name (Character-skin (world-character world))) "orangeKeyBoy")  (string=? (skin-name (Character-skin (world-character world))) "boy")) (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowKeyBoy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "orangeKeyJanitor") (string=? (skin-name (Character-skin (world-character world))) "janitor"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowKeyJanitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "orangeKeyScientist") (string=? (skin-name (Character-skin (world-character world))) "scientist"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowKeyScientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [(or (string=? (skin-name (Character-skin (world-character world))) "blueKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "orangeKeyPoliceWoman") (string=? (skin-name (Character-skin (world-character world))) "policeWoman"))  (begin (thread playButtonClick1Sound) (make-world (world-scene world) (make-Character (make-skin "yellowKeyPoliceWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
            [else world]))

;purpose: the door opens when the correct color key skin clicks on it
;contract: correctSkinToDoor: world --> world
;test
;function
(define (correctSkinToDoor world)
  (cond
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueKeyBoy") (string=? (world-scene world) "colorLevel3KeyDoor"))
           (begin (thread playPaintSoundEffect) (make-world "colorLevel3Classroom" (make-Character (make-skin "boy" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueKeyJanitor") (string=? (world-scene world) "colorLevel3KeyDoor"))
           (begin (thread playPaintSoundEffect) (make-world "colorLevel3Classroom" (make-Character (make-skin "janitor" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueKeyPoliceWoman") (string=? (world-scene world) "colorLevel3KeyDoor"))
           (begin (thread playPaintSoundEffect) (make-world "colorLevel3Classroom" (make-Character (make-skin "policeWoman" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
     [(and (string=? (skin-name (Character-skin (world-character world))) "blueKeyScientist") (string=? (world-scene world) "colorLevel3KeyDoor"))
           (begin (thread playPaintSoundEffect) (make-world "colorLevel3Classroom" (make-Character (make-skin "scientist" (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]

     [else (wrongAnswer world)]))

;purpose: to store item1 when clicked
;contract: storeItem1Clicked: world(w) -> world
;test
(check-expect (storeItem1Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "boy" "up")  (make-ChPos 960 890) 0) 0)) 
                                     (make-world "itemFull" (make-Character  (make-skin "boy" "up")  (make-ChPos 960 890) 0) 0))
(check-expect (storeItem1Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "janitor" "up")  (make-ChPos 960 890) 0) 0)) 
                                    (make-world "itemFull" (make-Character  (make-skin "janitor" "up")  (make-ChPos 960 890) 0) 0))
(check-expect (storeItem1Clicked(make-world "colorLevel3Classroom" (make-Character (make-skin "policeWoman" "up") (make-ChPos 960 890) 0) 0)) 
                                    (make-world "itemFull" (make-Character  (make-skin "policeWoman" "up")  (make-ChPos 960 890) 0) 0))
;function
(define (storeItem1Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "itemFull" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item2 when clicked
;contract: storeItem2Clicked: world(w) -> world
;test
(check-expect (storeItem2Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "boy" "up")  (make-ChPos 960 890) 0) 0)) 
                                     (make-world "item2"(make-Character (make-skin "boy" "up") (make-ChPos 960 890) 0) 0))
(check-expect (storeItem2Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "janitor" "up")  (make-ChPos 960 890) 0) 0)) 
                                    (make-world "item2" (make-Character  (make-skin "janitor" "up")  (make-ChPos 960 890) 0) 0))
(check-expect (storeItem2Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "policeWoman" "up")  (make-ChPos 960 890) 0) 0)) 
                                    (make-world "item2" (make-Character  (make-skin "policeWoman" "up")  (make-ChPos 960 890) 0) 0))
;function
(define (storeItem2Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item2" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item3 when clicked
;contract: storeItem3Clicked: world(w) -> world
;test
(check-expect (storeItem3Clicked (make-world "colorLevel3Classroom"  (make-Character  (make-skin "boy" "up")  (make-ChPos 960 890) 0) 0)) 
                                   (make-world "item3" (make-Character  (make-skin "boy" "up")  (make-ChPos 960 890) 0) 0))
(check-expect (storeItem3Clicked (make-world "colorLevel3Classroom" (make-Character (make-skin "janitor" "up") (make-ChPos 960 890) 0) 0)) 
                                    (make-world "item3" (make-Character (make-skin "janitor" "up")  (make-ChPos 960 890) 0) 0))
(check-expect (storeItem3Clicked (make-world "colorLevel3Classroom" (make-Character (make-skin "policeWoman" "up") (make-ChPos 960 890) 0) 0)) 
                                    (make-world "item3" (make-Character  (make-skin "policeWoman" "up")  (make-ChPos 960 890) 0) 0))
;function
(define (storeItem3Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item3" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item4 when clicked
;contract: storeItem4Clicked: world(w) -> world
;test
;function
(define (storeItem4Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item4" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item5 when clicked
;contract: storeItem5Clicked: world(w) -> world
;test
;function
(define (storeItem5Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item5" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item6 when clicked
;contract: storeItem6Clicked: world(w) -> world
;test
;function
(define (storeItem6Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item6" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item7 when clicked
;contract: storeItem7Clicked: world(w) -> world
;test
;function
(define (storeItem7Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item7" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item8 when clicked
;contract: storeItem8Clicked: world(w) -> world
;test
;function
(define (storeItem8Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item8" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item9 when clicked
;contract: storeItem9Clicked: world(w) -> world
;test
;function
(define (storeItem9Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item9"( make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item10 when clicked
;contract: storeItem10Clicked: world(w) -> world
;test
;function
(define (storeItem10Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item10"(make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item11 when clicked
;contract: storeItem11Clicked: world(w) -> world
;test
;function
(define (storeItem11Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item11"(make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))

;purpose: to store item12 when clicked
;contract: storeItem12Clicked: world(w) -> world
;test
;function
(define (storeItem12Clicked world)
    (begin (thread playButtonClick1Sound) (make-world "item12" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0)))


;purpose: place the item into its correct basket
;contract: correctItemToBasket: world(w) -> world
;test
;function
(define (correctItemToBasket world)
    (cond
         [(string=? (world-scene world) "itemFull")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item1" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item2")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item2" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item3")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item3" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item4")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item4" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item5")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item5" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item6")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item6" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item7")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item7" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item8")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item8" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item9")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item9" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item10")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item10" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
        [(string=? (world-scene world) "item11")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item11" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
         [(string=? (world-scene world) "item12")
                 (begin (thread playButtonClick1Sound) (make-world "colorLevel3Item12" (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world)))) (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 0) 0))]
        
        [else (begin (wrongAnswer world))]))

;=======================================================================================
;************************************ Number Game **************************************
;=======================================================================================

(define (drawNumberLobby world) 
     (cond
          [(string=? (world-scene world) "numberLobbyL1")
          (place-image  
            (skinUpdater (Character-skin (world-character world))) 
                                              (ChPos-x (Character-pos (world-character world))) 
                                              (ChPos-y (Character-pos (world-character world)))
                                              numberLobbyL1Bg)]
          [(string=? (world-scene world) "numberLobbyL2")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         numberLobbyL2Bg)]   
          [(string=? (world-scene world) "numberLobbyL3")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         numberLobbyL3Bg)]

           [(string=? (world-scene world) "numberLevel3Door")
          (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         numberLevel3DoorBg)]))                             
                                         
           

(define (drawNumberScore world)
      (cond
          [(string=? (world-scene world) "numberLevel1Score5")
          (place-image numberLevel1Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
         ))

;test

;Purpose: Draws The Levels of the shape game 
(define (drawNumberLevel world) 
     (cond
; level 1
          [(string=? (world-scene world) "numberLevel1Q1")
          (place-image numberLevel1Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel1Q2")
          (place-image numberLevel1Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel1Q3")
          (place-image numberLevel1Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel1Q4")
          (place-image numberLevel1Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel1Q5")
          (place-image numberLevel1Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

; level 2
          [(string=? (world-scene world) "numberLevel2Q1")
          (place-image numberLevel2Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q2")
          (place-image numberLevel2Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q3")
          (place-image numberLevel2Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q4")
          (place-image numberLevel2Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q5")
          (place-image numberLevel2Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q6")
          (place-image numberLevel2Q6Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q7")
          (place-image numberLevel2Q7Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q8")
          (place-image numberLevel2Q8Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q9")
          (place-image numberLevel2Q9Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Q10")
          (place-image numberLevel2Q10Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Score10")
          (place-image numberLevel2Score10 worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "numberLevel2Car")
          (place-image numberLevel2Car worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

          
; level 3
         [(string=? (world-scene world) "numberLevel3Q1")
         (place-image numberLevel3Q1Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Q2")
         (place-image numberLevel3Q2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Q3")
         (place-image numberLevel3Q3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Q4")
         (place-image numberLevel3Q4Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Q5")
         (place-image numberLevel3Q5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Start")
         (place-image numberLevel3StartBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
         [(string=? (world-scene world) "numberLevel3Score")
         (place-image numberLevel3ScoreBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ))


(define (swNumberLobbyL1 w) (begin (thread playBellRingSound) (make-world "numberLobbyL1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLobbyL2 w) (begin (thread playBellRingSound) (make-world "numberLobbyL2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLobbyL3 w) (begin (thread playBellRingSound) (make-world "numberLobbyL3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swNumberLevel1 w) (begin (thread playBellRingSound) (make-world "numberLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2 w) (begin (thread playBellRingSound) (make-world "numberLevel2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3 w) (begin (thread playBellRingSound) (make-world "numberLevel3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swNumberElevator w) (begin (thread playBellRingSound) (make-world "numberElevator" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

; number level 1
(define (swNumberLevel1Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel1Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel1Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel1Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel1Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

(define (swNumberLevel1Score5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel1Score5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Score10 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Score10" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

; number level 2
(define (swNumberLevel2Q1 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q6 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q6" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q7 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q7" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q8 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q8" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q9 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q9" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel2Q10 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel2Q10" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))

;tutorial
(define (swNumb1Tutorial w) (begin (thread playNumberTutorialAudio) (make-world "numb1Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumb1Count w) (make-world "numb1Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb2Tutorial w) (make-world "numb2Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb2Count w) (make-world "numb2Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb3Tutorial w) (make-world "numb3Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb3Count w) (make-world "numb3Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb4Tutorial w) (make-world "numb4Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb4Count w) (make-world "numb4Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb5Tutorial w) (make-world "numb5Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb5Count w) (make-world "numb5Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb6Tutorial w) (make-world "numb6Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb6Count w) (make-world "numb6Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb7Tutorial w) (make-world "numb7Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb7Count w) (make-world "numb7Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb8Tutorial w) (make-world "numb8Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb8Count w) (make-world "numb8Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb9Tutorial w) (make-world "numb9Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb9Count w) (make-world "numb9Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb10Tutorial w) (make-world "numb10Tutorial" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))
(define (swNumb10Count w) (make-world "numb10Count" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0))

;Purpose: Switches the question scenes to the right one or plays the wrong answer sound
;Contract: swNumberLevel2Q: world(w) Ballon-Number(n) -> world
(define (swNumberLevel2Q w n)
    (cond 
        [(and (string=? (world-scene w) "numberLevel2Q1") (= n 1)) 
        (swNumberLevel2Q2 w)]
        [(and (string=? (world-scene w) "numberLevel2Q2") (= n 2))
        (swNumberLevel2Q3 w)]
        [(and (string=? (world-scene w) "numberLevel2Q3") (= n 3))
        (swNumberLevel2Q4 w)]
        [(and (string=? (world-scene w) "numberLevel2Q4") (= n 4))
        (swNumberLevel2Q5 w)]
        [(and (string=? (world-scene w) "numberLevel2Q5") (= n 5))
        (swNumberLevel2Q6 w)]
        [(and (string=? (world-scene w) "numberLevel2Q6") (= n 6))
        (swNumberLevel2Q7 w)]
        [(and (string=? (world-scene w) "numberLevel2Q7") (= n 7))
        (swNumberLevel2Q8 w)]
        [(and (string=? (world-scene w) "numberLevel2Q8") (= n 8))
        (swNumberLevel2Q9 w)]
        [(and (string=? (world-scene w) "numberLevel2Q9") (= n 9))
        (swNumberLevel2Q10 w)]
        [(and (string=? (world-scene w) "numberLevel2Q10") (= n 10))
        (swNumberLevel2Score10 w)]
        [else (wrongAnswer w)]))
        

; number level 3
(define (swNumberLevel3Door w) (begin (thread playBellRingSound) (make-world "numberLevel3Door" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Q1 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Start w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Start" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
(define (swNumberLevel3Score w) (begin (thread playCorrectAnswerEffectSound) (make-world "numberLevel3Score" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0) 0)))
;=======================================================================================
;*********************** Character & Lobby & Keyboard Control **************************
;=======================================================================================

;defines character speed
(define ChSpeed 10)

;Purpose: Draws the Character in the Lobby
;Contract: drawLobby: world --> image
(define (drawLobby world) (place-image  (skinUpdater (Character-skin (world-character world))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         lobbyBg))
;test 

;Purpose: helper function to update the x coordinates of the Character
;Contract: updateChPosx: Character(c), number(cs) --> pos(x)
;function
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))

;test

;Purpose: helper function to update the y coordinates of the Character
;Contract: updateChPosy: Character(c), number(cs) --> pos(y)
;function
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))

;test

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
     
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "redBoy"))
            (skinD-west redBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "redBoy"))
            (skinD-east redBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "redBoy"))
            (skinD-south redBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "redBoy"))
            (skinD-north redBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeBoy"))
            (skinD-west orangeBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeBoy"))
            (skinD-east orangeBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeBoy"))
            (skinD-south orangeBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeBoy"))
            (skinD-north orangeBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowBoy"))
            (skinD-west yellowBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowBoy"))
            (skinD-east yellowBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowBoy"))
            (skinD-south yellowBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowBoy"))
            (skinD-north yellowBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "greenBoy"))
            (skinD-west greenBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "greenBoy"))
            (skinD-east greenBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "greenBoy"))
            (skinD-south greenBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "greenBoy"))
            (skinD-north greenBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueBoy"))
            (skinD-west blueBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueBoy"))
            (skinD-east blueBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueBoy"))
            (skinD-south blueBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueBoy"))
            (skinD-north blueBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "purpleBoy"))
        (skinD-west purpleBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "purpleBoy"))
        (skinD-east purpleBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "purpleBoy"))
        (skinD-south purpleBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "purpleBoy"))
        (skinD-north purpleBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "redJanitor"))
        (skinD-west redJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "redJanitor"))
        (skinD-east redJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "redJanitor"))
        (skinD-south redJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "redJanitor"))
        (skinD-north redJanitorSkin)]

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeJanitor"))
        (skinD-west orangeJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeJanitor"))
        (skinD-east orangeJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeJanitor"))
        (skinD-south orangeJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeJanitor"))
        (skinD-north orangeJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowJanitor"))
        (skinD-west yellowJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowJanitor"))
        (skinD-east yellowJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowJanitor"))
        (skinD-south yellowJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowJanitor"))
        (skinD-north yellowJanitorSkin)]

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "greenJanitor"))
        (skinD-west greenJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "greenJanitor"))
        (skinD-east greenJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "greenJanitor"))
        (skinD-south greenJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "greenJanitor"))
        (skinD-north greenJanitorSkin)]

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueJanitor"))
        (skinD-west blueJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueJanitor"))
        (skinD-east blueJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueJanitor"))
        (skinD-south blueJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueJanitor"))
        (skinD-north blueJanitorSkin)]

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "purpleJanitor"))
        (skinD-west purpleJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "purpleJanitor"))
        (skinD-east purpleJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "purpleJanitor"))
        (skinD-south purpleJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "purpleJanitor"))
        (skinD-north purpleJanitorSkin)]
  
     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "redScientist"))
        (skinD-west redScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "redScientist"))
        (skinD-east redScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "redScientist"))
        (skinD-south redScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "redScientist"))
        (skinD-north redScientistSkin)] 

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeScientist"))
        (skinD-west orangeScientistWest)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeScientist"))
        (skinD-east orangeScientistWest)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeScientist"))
        (skinD-south orangeScientistWest)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeScientist"))
        (skinD-north orangeScientistWest)] 

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowScientist"))
        (skinD-west yellowScientistWest)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowScientist"))
        (skinD-east yellowScientistWest)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowScientist"))
        (skinD-south yellowScientistWest)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowScientist"))
        (skinD-north yellowScientistWest)] 

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "greenScientist"))
        (skinD-west greenScientistWest)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "greenScientist"))
        (skinD-east greenScientistWest)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "greenScientist"))
        (skinD-south greenScientistWest)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "greenScientist"))
        (skinD-north greenScientistWest)] 

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueScientist"))
        (skinD-west blueScientistWest)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueScientist"))
        (skinD-east blueScientistWest)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueScientist"))
        (skinD-south blueScientistWest)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueScientist"))
        (skinD-north blueScientistWest)] 

     [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "purpleScientist"))
        (skinD-west purpleScientistSouth)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "purpleScientist"))
        (skinD-east purpleScientistSouth)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "purpleScientist"))
        (skinD-south purpleScientistSouth)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "purpleScientist"))
        (skinD-north purpleScientistSouth)] 

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "redPoliceWoman"))
        (skinD-west redPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "redPoliceWoman"))
        (skinD-east redPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "redPoliceWoman"))
        (skinD-south redPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "redPoliceWoman"))
        (skinD-north redPoliceWomanSkin)]
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangePoliceWoman"))
        (skinD-west orangePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangePoliceWoman"))
        (skinD-east orangePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangePoliceWoman"))
        (skinD-south orangePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangePoliceWoman"))
        (skinD-north orangePoliceWomanSkin)]
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowPoliceWoman"))
        (skinD-west yellowPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowPoliceWoman"))
        (skinD-east yellowPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowPoliceWoman"))
        (skinD-south yellowPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowPoliceWoman"))
        (skinD-north yellowPoliceWomanSkin)]
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "greenPoliceWoman"))
        (skinD-west greenPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "greenPoliceWoman"))
        (skinD-east greenPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "greenPoliceWoman"))
        (skinD-south greenPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "greenPoliceWoman"))
        (skinD-north greenPoliceWomanSkin)]
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "bluePoliceWoman"))
        (skinD-west bluePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "bluePoliceWoman"))
        (skinD-east bluePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "bluePoliceWoman"))
        (skinD-south bluePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "bluePoliceWoman"))
        (skinD-north bluePoliceWomanSkin)]
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "purplePoliceWoman"))
        (skinD-west purplePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "purplePoliceWoman"))
        (skinD-east purplePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "purplePoliceWoman"))
        (skinD-south purplePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "purplePoliceWoman"))
        (skinD-north purplePoliceWomanSkin)] 
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "circleBoy"))
            (skinD-west circleBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "circleBoy"))
            (skinD-east circleBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "circleBoy"))
            (skinD-south circleBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "circleBoy"))
            (skinD-north circleBoySkin)]
    
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "pentagonBoy"))
            (skinD-west pentagonBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "pentagonBoy"))
            (skinD-east pentagonBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "pentagonBoy"))
            (skinD-south pentagonBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "pentagonBoy"))
            (skinD-north pentagonBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "rectangleBoy"))
            (skinD-west rectangleBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "rectangleBoy"))
            (skinD-east rectangleBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "rectangleBoy"))
            (skinD-south rectangleBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "rectangleBoy"))
            (skinD-north rectangleBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "squareBoy"))
            (skinD-west squareBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "squareBoy"))
            (skinD-east squareBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "squareBoy"))
            (skinD-south squareBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "squareBoy"))
            (skinD-north squareBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "triangleBoy"))
            (skinD-west triangleBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "triangleBoy"))
            (skinD-east triangleBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "triangleBoy"))
            (skinD-south triangleBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "triangleBoy"))
            (skinD-north triangleBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "circleJanitor"))
        (skinD-west circleJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "circleJanitor"))
        (skinD-east circleJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "circleJanitor"))
        (skinD-south circleJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "circleJanitor"))
        (skinD-north circleJanitorSkin)]
    
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "pentagonJanitor"))
        (skinD-west pentagonJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "pentagonJanitor"))
        (skinD-east pentagonJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "pentagonJanitor"))
        (skinD-south pentagonJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "pentagonJanitor"))
        (skinD-north pentagonJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "rectangleJanitor"))
        (skinD-west rectangleJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "rectangleJanitor"))
        (skinD-east rectangleJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "rectangleJanitor"))
        (skinD-south rectangleJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "rectangleJanitor"))
        (skinD-north rectangleJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "squareJanitor"))
        (skinD-west squareJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "squareJanitor"))
        (skinD-east squareJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "squareJanitor"))
        (skinD-south squareJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "squareJanitor"))
        (skinD-north squareJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "triangleJanitor"))
        (skinD-west triangleJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "triangleJanitor"))
        (skinD-east triangleJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "triangleJanitor"))
        (skinD-south triangleJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "triangleJanitor"))
        (skinD-north triangleJanitorSkin)]

   [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "circleScientist"))
        (skinD-west circleScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "circleScientist"))
        (skinD-east circleScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "circleScientist"))
        (skinD-south circleScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "circleScientist"))
        (skinD-north circleScientistSkin)] 

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "circlePoliceWoman"))
            (skinD-west circlePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "circlePoliceWoman"))
            (skinD-east circlePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "circlePoliceWoman"))
            (skinD-south circlePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "circlePoliceWoman"))
            (skinD-north circlePoliceWomanSkin)]
    
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "pentagonPoliceWoman"))
            (skinD-west pentagonPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "pentagonPoliceWoman"))
            (skinD-east pentagonPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "pentagonPoliceWoman"))
            (skinD-south pentagonPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "pentagonPoliceWoman"))
            (skinD-north pentagonPoliceWomanSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "rectanglePoliceWoman"))
            (skinD-west rectanglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "rectanglePoliceWoman"))
            (skinD-east rectanglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "rectanglePoliceWoman"))
            (skinD-south rectanglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "rectanglePoliceWoman"))
            (skinD-north rectanglePoliceWomanSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "squarePoliceWoman"))
            (skinD-west squarePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "squarePoliceWoman"))
            (skinD-east squarePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "squarePoliceWoman"))
            (skinD-south squarePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "squarePoliceWoman"))
            (skinD-north squarePoliceWomanSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "trianglePoliceWoman"))
            (skinD-west trianglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "trianglePoliceWoman"))
            (skinD-east trianglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "trianglePoliceWoman"))
            (skinD-south trianglePoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "trianglePoliceWoman"))
            (skinD-north trianglePoliceWomanSkin)]

   [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "pentagonScientist"))
        (skinD-west pentagonScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "pentagonScientist"))
        (skinD-east pentagonScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "pentagonScientist"))
        (skinD-south pentagonScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "pentagonScientist"))
        (skinD-north pentagonScientistSkin)] 

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "rectangleScientist"))
        (skinD-west rectangleScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "rectangleScientist"))
        (skinD-east rectangleScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "rectangleScientist"))
        (skinD-south rectangleScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "rectangleScientist"))
        (skinD-north rectangleScientistSkin)] 

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "squareScientist"))
        (skinD-west squareScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "squareScientist"))
        (skinD-east squareScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "squareScientist"))
        (skinD-south squareScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "squareScientist"))
        (skinD-north squareScientistSkin)] 

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "triangleScientist"))
        (skinD-west triangleScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "triangleScientist"))
        (skinD-east triangleScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "triangleScientist"))
        (skinD-south triangleScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "triangleScientist"))
        (skinD-north triangleScientistSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueKeyBoy"))
            (skinD-west blueKeyBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueKeyBoy"))
            (skinD-east blueKeyBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueKeyBoy"))
            (skinD-south blueKeyBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueKeyBoy"))
            (skinD-north blueKeyBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeKeyBoy"))
            (skinD-west orangeKeyBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeKeyBoy"))
            (skinD-east orangeKeyBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeKeyBoy"))
            (skinD-south orangeKeyBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeKeyBoy"))
            (skinD-north orangeKeyBoySkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowKeyBoy"))
            (skinD-west yellowKeyBoySkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowKeyBoy"))
            (skinD-east yellowKeyBoySkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowKeyBoy"))
            (skinD-south yellowKeyBoySkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowKeyBoy"))
            (skinD-north yellowKeyBoySkin)]
    
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueKeyJanitor"))
        (skinD-west blueKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueKeyJanitor"))
        (skinD-east blueKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueKeyJanitor"))
        (skinD-south blueKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueKeyJanitor"))
        (skinD-north blueKeyJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeKeyJanitor"))
        (skinD-west orangeKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeKeyJanitor"))
        (skinD-east orangeKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeKeyJanitor"))
        (skinD-south orangeKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeKeyJanitor"))
        (skinD-north orangeKeyJanitorSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowKeyJanitor"))
        (skinD-west yellowKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowKeyJanitor"))
        (skinD-east yellowKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowKeyJanitor"))
        (skinD-south yellowKeyJanitorSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowKeyJanitor"))
        (skinD-north yellowKeyJanitorSkin)]    
        
    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueKeyScientist"))
        (skinD-west blueKeyScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueKeyScientist"))
        (skinD-east blueKeyScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueKeyScientist"))
        (skinD-south blueKeyScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueKeyScientist"))
        (skinD-north blueKeyScientistSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeKeyScientist"))
        (skinD-west orangeKeyScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeKeyScientist"))
        (skinD-east orangeKeyScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeKeyScientist"))
        (skinD-south orangeKeyScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeKeyScientist"))
        (skinD-north orangeKeyScientistSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowKeyScientist"))
        (skinD-west yellowKeyScientistSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowKeyScientist"))
        (skinD-east yellowKeyScientistSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowKeyScientist"))
        (skinD-south yellowKeyScientistSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowKeyScientist"))
        (skinD-north yellowKeyScientistSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "blueKeyPoliceWoman"))
            (skinD-west blueKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "blueKeyPoliceWoman"))
            (skinD-east blueKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "blueKeyPoliceWoman"))
            (skinD-south blueKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "blueKeyPoliceWoman"))
            (skinD-north blueKeyPoliceWomanSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "orangeKeyPoliceWoman"))
            (skinD-west orangeKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "orangeKeyPoliceWoman"))
            (skinD-east orangeKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "orangeKeyPoliceWoman"))
            (skinD-south orangeKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "orangeKeyPoliceWoman"))
            (skinD-north orangeKeyPoliceWomanSkin)]

    [(and (string=? (skin-direction s) "left") (string=? (skin-name s) "yellowKeyPoliceWoman"))
            (skinD-west yellowKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "right") (string=? (skin-name s) "yellowKeyPoliceWoman"))
            (skinD-east yellowKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "down") (string=? (skin-name s) "yellowKeyPoliceWoman"))
            (skinD-south yellowKeyPoliceWomanSkin)]
    [(and (string=? (skin-direction s) "up") (string=? (skin-name s) "yellowKeyPoliceWoman"))
            (skinD-north yellowKeyPoliceWomanSkin)]))

;=============================================================================================================================================================
;x,y coordinates of stuff:

;shape, color, number elevator y coordinates 850(bottom) 390(top)
;shape, color, number elevator x coordinates 130(left) 340(right)

;shape, color, number level 1, 2, 3 door y coordinates 630(bottom) 290(top)
;shape, color, number level 1, 2, 3 door x coordinates 820 (left) 1110(right)

;shape door y coordinates 700(bottom) 670(top)
;shape door x coordinates 420(left) 370(right)

;color door y coordinates 710(bottom) 660(top)
;color door x coordinates 1530(left) 1550(right)

;number door y coordinates 300(bottom) 300(top)
;number door x coordinates 1060 (left) 1140(right)

;exit lobby door y coordinates  792(bottom)  726(top)
;exit lobby door x coordinates 1515(left)  1693(right)

;======================================================================================
;Shape level 2

;path 1, 2, 3 triangleR, pentagon, square y coordinates 170(bottom) 0(top)
;path 1, 2, 3 triangleR, pentagon, square x coordinates 1252(left) 1553(right)
;path 1, 2 ,3 triangleL, rectangle, circle y coordinates 170(bottom) 0(top)
;path 1, 2, 3 triangleL, rectangle, circle x coordinates 348(left) 651(right)

;deadnEnd y coordinates 1080(bottom) 923(top)
;deadEnd x coordinates 800(left) 1107(right)

;======================================================================================
;color level 3
;door 2 y-axis start from  777(bottom) to  419(top)
;door 2 x-axis start from  1569(left) to  1854(right)

;door 2 y-axis start from  777(bottom) to  779(top)
;door 2 x-axis start from  1569(left) to  1854(right)

;=============================================================================================================================================================


;Purpose: Move The Character & change the image of the character to the direction its facing  & changes the scene if the character is in certain areas
;Contract: keyboardControl: world(w), keyboard-input(ki) --> image
;function
(define (keyboardControl w ki)
  (if (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorialMovement") (string=? (world-scene w) "shapeLobbyL1") 
          (string=? (world-scene w) "shapeLobbyL2") (string=? (world-scene w) "shapeLobbyL3") (string=? (world-scene w) "shapeLevel2Train")
          (string=? (world-scene w) "colorLobbyL1") (string=? (world-scene w) "colorLobbyL2") (string=? (world-scene w) "colorLobbyL3") 
          (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel3KeyDoor") (string=? (world-scene w) "colorLevel3Classroom")
          (string=? (world-scene w) "colorLevel3Door2") (string=? (world-scene w) "numberLobbyL1") (string=? (world-scene w) "numberLobbyL2") 
          (string=? (world-scene w) "numberLobbyL3") (string=? (world-scene w) "deadEnd2") (string=? (world-scene w) "deadEnd3")
          (string=? (world-scene w) "numberLevel2") (string=? (world-scene w) "numberLevel3") (string=? (world-scene w) "colorLevel2RedFrame")
          (string=? (world-scene w) "colorLevel2YellowFrame") (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame")
          (string=? (world-scene w) "colorLevel2PurpleFrame") (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "squareCart") 
          (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart") (string=? (world-scene w) "rectangleCart")
          (string=? (world-scene w) "shapeLevel2Path1") (string=? (world-scene w) "shapeLevel2Path2") (string=? (world-scene w) "shapeLevel2Path3")
          (string=? (world-scene w) "deadEnd1") (string=? (world-scene w) "numberLevel3Door")) 

    (cond       

     [(<= (ChPos-y (Character-pos (world-character w))) 0)
           (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "down")  
                               (make-ChPos  
                                           (ChPos-x (Character-pos (world-character w))) (+ (ChPos-y (Character-pos (world-character w))) 50))
                                           (Character-stepCount (world-character w))) 
                                           (world-t w))]


     [(>= (ChPos-y (Character-pos (world-character w))) 1080)
            (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up")  
                               (make-ChPos  
                                           (ChPos-x (Character-pos (world-character w))) (- (ChPos-y (Character-pos (world-character w))) 50))
                                           (Character-stepCount (world-character w))) 
                                           (world-t w))]


     [(<= (ChPos-x (Character-pos (world-character w))) 0)
           (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right")  
                               (make-ChPos 
                                           (+ (ChPos-x (Character-pos (world-character w))) 50) (ChPos-y (Character-pos (world-character w))))
                                           (Character-stepCount (world-character w))) 
                                           (world-t w))]


     [(>= (ChPos-x (Character-pos (world-character w))) 1920)
            (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left")  
                               (make-ChPos 
                                           (- (ChPos-x (Character-pos (world-character w))) 50) (ChPos-y (Character-pos (world-character w))))
                                           (Character-stepCount (world-character w))) 
                                           (world-t w))] 





     [(and (string=? (world-scene w) "Lobby") ;Shape Door
           (<= (ChPos-y (Character-pos (world-character w))) 700)
           (>= (ChPos-y (Character-pos (world-character w))) 670)
           (>= (ChPos-x (Character-pos (world-character w))) 370)
           (<= (ChPos-x (Character-pos (world-character w))) 420)) 
           (swShapeLobbyL1 w)]
          
     [(and (or (string=? (world-scene w) "shapeLobbyL1") (string=? (world-scene w) "shapeLobbyL2") (string=? (world-scene w) "shapeLobbyL3")) ;Shape elevator
           (<= (ChPos-y (Character-pos (world-character w))) 850)
           (>= (ChPos-y (Character-pos (world-character w))) 390)
           (>= (ChPos-x (Character-pos (world-character w))) 130)
           (<= (ChPos-x (Character-pos (world-character w))) 340)) 
           (swShapeElevator w)]

     [(and (string=? (world-scene w) "shapeLobbyL1") ;Shape Level 1 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swShapeLevel1 w)]

     [(and (string=? (world-scene w) "shapeLobbyL2") ;Shape Level 2 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
             (swShapeLevel2 w)]

     [(and (or (string=? (world-scene w) "shapeLevel2Path1") (string=? (world-scene w) "shapeLevel2Path2") ;Shape Level 2 pentagon, triangleR, square path
               (string=? (world-scene w) "shapeLevel2Path3")) 
           (<= (ChPos-y (Character-pos (world-character w))) 170)
           (>= (ChPos-y (Character-pos (world-character w))) 0) 0
           (>= (ChPos-x (Character-pos (world-character w))) 1252)
           (<= (ChPos-x (Character-pos (world-character w))) 1553)) 
             (swPathR w)]       

     [(and (or (string=? (world-scene w) "shapeLevel2Path1") (string=? (world-scene w) "shapeLevel2Path2") ;Shape Level 2 circle, triangleL, rectangle path
               (string=? (world-scene w) "shapeLevel2Path3")) 
           (<= (ChPos-y (Character-pos (world-character w))) 170)
           (>= (ChPos-y (Character-pos (world-character w))) 0) 0
           (>= (ChPos-x (Character-pos (world-character w))) 348)
           (<= (ChPos-x (Character-pos (world-character w))) 651)) 
             (swPathL w)]    

     [(and (or (string=? (world-scene w) "deadEnd1") (string=? (world-scene w) "deadEnd2") ;DeadEnd
               (string=? (world-scene w) "deadEnd3")) 
           (<= (ChPos-y (Character-pos (world-character w))) 1080)
           (>= (ChPos-y (Character-pos (world-character w))) 923)
           (>= (ChPos-x (Character-pos (world-character w))) 800)
           (<= (ChPos-x (Character-pos (world-character w))) 1107)) 
             (swPathDeadEnd w)]          

     [(and (string=? (world-scene w) "shapeLobbyL3") ;Shape Level 3 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swShapeLevel3 w)]

     [(and (or (string=? (world-scene w) "shapeLobbyL1") (string=? (world-scene w) "colorLobbyL1") (string=? (world-scene w) "numberLobbyL1")) ;Shape Level 1 exit door
           (<= (ChPos-y (Character-pos (world-character w))) 792)
           (>= (ChPos-y (Character-pos (world-character w))) 726)
           (>= (ChPos-x (Character-pos (world-character w))) 1515)
           (<= (ChPos-x (Character-pos (world-character w))) 1693)) 
           (cLobby w)]

     [(and (string=? (world-scene w) "Lobby") ;Color Door
           (<= (ChPos-y (Character-pos (world-character w))) 710)
           (>= (ChPos-y (Character-pos (world-character w))) 660)
           (>= (ChPos-x (Character-pos (world-character w))) 1530)
           (<= (ChPos-x (Character-pos (world-character w))) 1550)) 
           (swColorLobbyL1 w)]

     [(and (or (string=? (world-scene w) "colorLobbyL1") (string=? (world-scene w) "colorLobbyL2") (string=? (world-scene w) "colorLobbyL3")) ;color elevator
           (<= (ChPos-y (Character-pos (world-character w))) 850)
           (>= (ChPos-y (Character-pos (world-character w))) 390)
           (>= (ChPos-x (Character-pos (world-character w))) 130)
           (<= (ChPos-x (Character-pos (world-character w))) 340)) 
           (swColorElevator w)]

     [(and (string=? (world-scene w) "colorLobbyL1") ;color Level 1 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swColorLevel1 w)]

     [(and (string=? (world-scene w) "colorLobbyL2") ;color Level 2 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swColorLevel2Q1 w)]

     [(and (string=? (world-scene w) "colorLobbyL3") ;color Level 3 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swColorLevel3KeyDoor w)]

     [(and (string=? (world-scene w) "Lobby") ;Number Door
           (<= (ChPos-y (Character-pos (world-character w))) 300)
           (>= (ChPos-y (Character-pos (world-character w))) 300)
           (>= (ChPos-x (Character-pos (world-character w))) 1060)
           (<= (ChPos-x (Character-pos (world-character w))) 1693)) 
           (swNumberLobbyL1 w)]

     [(and (or (string=? (world-scene w) "numberLobbyL1") (string=? (world-scene w) "numberLobbyL2") (string=? (world-scene w) "numberLobbyL3")) ;number elevator
           (<= (ChPos-y (Character-pos (world-character w))) 850)
           (>= (ChPos-y (Character-pos (world-character w))) 390)
           (>= (ChPos-x (Character-pos (world-character w))) 130)
           (<= (ChPos-x (Character-pos (world-character w))) 340))
           (swNumberElevator w)]

     [(and (string=? (world-scene w) "numberLobbyL1") ;number Level 1 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110))
           (swNumberLevel1 w)]

     [(and (string=? (world-scene w) "numberLobbyL2") ;number Level 2 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swNumberLevel2Q1 w)]

     [(and (string=? (world-scene w) "numberLobbyL3") ;number Level 3 door
           (<= (ChPos-y (Character-pos (world-character w))) 630)
           (>= (ChPos-y (Character-pos (world-character w))) 290)
           (>= (ChPos-x (Character-pos (world-character w))) 820)
           (<= (ChPos-x (Character-pos (world-character w))) 1110)) 
           (swNumberLevel3Door w)]

     [(and (string=? (world-scene w) "numberLevel3Door") ;number Level 3 classroom door
           (<= (ChPos-y (Character-pos (world-character w))) 873)
           (>= (ChPos-y (Character-pos (world-character w))) 302)
           (>= (ChPos-x (Character-pos (world-character w))) 1004)
           (<= (ChPos-x (Character-pos (world-character w))) 1286)) 
           (swNumberLevel3Start w)]

      [(and (string=? (world-scene w) "colorLevel3Door2") ;door 2 color level 3
           (<= (ChPos-y (Character-pos (world-character w))) 777)
           (>= (ChPos-y (Character-pos (world-character w))) 600)
           (>= (ChPos-x (Character-pos (world-character w))) 1569)
           (<= (ChPos-x (Character-pos (world-character w))) 1854)) 
           (swColorLevel3ItemsFull w)]

    


     [(or (key=? ki "left") (key=? ki "a")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left") 
                               (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                           (ChPos-y (Character-pos (world-character w)))) 
                                           (+ (Character-stepCount (world-character w)) 1)) (world-t w)))]

     [(or (key=? ki "right") (key=? ki "d"))
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right")  
                               (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                           (ChPos-y (Character-pos (world-character w))))
                                           (+ (Character-stepCount (world-character w)) 1)) (world-t w)))]

     [(or (key=? ki "up") (key=? ki "w")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) (* ChSpeed -1)))
                                           (+ (Character-stepCount (world-character w)) 1)) (world-t w)))]

     [(or (key=? ki "down") (key=? ki "s")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "down")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) ChSpeed))
                                           (+ (Character-stepCount (world-character w)) 1)) (world-t w)))]
               
        [else w]
        
    )w))


;test 

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================


;defines the character select scene once clicked
(define (cChSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;defines the Lobby scene once clicked 
(define (cLobby world) 
        (begin (thread playButtonClick1Sound) (make-world "Lobby" (make-Character (make-skin (skin-name (Character-skin (world-character world))) "left") (make-ChPos lobbyCenterWidth lobbyCenterHeight) 0) 0)))

;defines the tutorial pop up scene once confirm on chSelect is clicked
(define (cTutorialPopUp world)   
        (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp" 
                                                (make-Character (make-skin (skin-name (Character-skin (world-character world))) "up")
                                                                (make-ChPos worldCenterWidth worldCenterHeight) 
                                                                0) 0)))

;defines the tutorial scene once yes on tutorial pop up is clicked
(define (cTutorial world)   
        (begin (thread playButtonClick1Sound) (make-world "tutorialMovement" 
                                                (make-Character (make-skin (skin-name (Character-skin (world-character world))) "up")
                                                                (make-ChPos worldCenterWidth worldCenterHeight) 
                                                                0) 0)))


;makes the skin boy once clicked
(define (cBoySelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;makes the skin janitor once clicked
(define (cJanitorSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect2" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;makes the skin janitor once clicked
(define (cScientistSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect3" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))

;makes the skin janitor once clicked
(define (cPoliceWomanSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect4" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0) 0)))


;=======================================================================================
;Coordinates of the buttons:

;=============================================================================
;Play button:

;Play button y-axis start from 480(bottom) to 377(top)
;Play button x-axis start from 757(left) to 1148(right)

;=============================================================================
;Movement Tutorial next button:

;Play button y-axis start from 1032(bottom) to 936(top)
;Play button x-axis start from 1559(left) to 1911(right)

;=============================================================================
;Character Info:

;Character Info button y-axis start from 710(bottom) to 606(top)
;Character Info button x-axis start from 762(left) to 1151(right)

;Character Info exit button y-axis start from 68(bottom) to 16(top)
;Character Info exit button x-axis start from 38(left) to 219(right)

;Boy button y-axis start from 357(bottom) to 81(top)
;Boy button x-axis start from 900(left) to 1087(right)

;Janitor button y-axis start from 357(bottom) to 81(top)
;Janitor button x-axis start from 1154(left) to 1345(right)

;Scientist button y-axis start from 357(bottom) to 81(top)
;Scientist button x-axis start from 1409(left) to 1596(right)

;PoliceWoman button y-axis start from 357(bottom) to 81(top)
;PoliceWoman button x-axis start from 1648(left) to 1840(right)

;=============================================================================
;Character Select:

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

;=============================================================================
;Elevator buttons:

;Elevator Level 1 button y-axis start from 453(bottom) to 419(top)
;Elevator Level 1 button x-axis start from 1443(left) to 1480(right)
;Elevator Level 2 button y-axis start from 505(bottom) to 471(top)
;Elevator Level 2 button x-axis start from 1443(left) to 1480(right)
;Elevator Level 3 button y-axis start from 556(bottom) to 522(top)
;Elevator Level 3 button x-axis start from 1443(left) to 1480(right)

;=============================================================================
;Question buttons:

;Shape, Color, and Number Level 1 topLeft question button y-axis start from 808(bottom) to 663(top)
;Shape, Color, and Number Level 1 topLeft question button x-axis start from 357(left) to 855(right)
;Shape, Color, and Number Level 1 bottomLeft question button y-axis start from 990(bottom) to 844(top)
;Shape, Color, and Number Level 1 bottomLeft question button x-axis start from 357(left) to 855(right)
;Shape, Color, and Number Level 1 topRight question button y-axis start from 808(bottom) to 663(top)
;Shape, Color, and Number Level 1 topRight question button x-axis start from 1067(left) to 1564(right)
;Shape, Color, and Number Level 1 bottomRight question button y-axis start from 990(bottom) to 844(top)
;Shape, Color, and Number Level 1 bottomRight question button x-axis start from 1067(left) to 1564(right)

;=============================================================================
;Color Level 2:
;red frame
;y-axis:  530(bottom)  405(top)
;x-axiis:  169(left)  313(right)

;orange frame
;y-axis:  555(bottom)  365(top)
;x-axiis:  421(left)  547(right)

;yellow frame
;y-axis:  504(bottom)  312(top)
;x-axiis:  698(left)  820(right)

;green frame
;y-axis:  504(bottom)  314(top)
;x-axiis:  1095(left)  1217(right)

;blue frame
;y-axis:  555(bottom)  367(top)
;x-axiis:  1360(left)  1485(right)

;purple frame
;y-axis:  511(bottom)  395(top)
;x-axiis:  1589(left)  1768(right)


;red paint bucket
;y-axis:  446(bottom)  393(top)
;x-axiis:  898(left)  942(right)

;orange paint bucket
;y-axis:  378(bottom)  326(top)
;x-axiis:  894(left)  939(right)

;yellow paint bucket
;y-axis:  378(bottom)  324(top)
;x-axiis:  1001(left)  1045(right)

;green paint bucket
;y-axis:  447(bottom)  393(top)
;x-axiis:  949(left)  992(right)

;blue paint bucket
;y-axis:  448(bottom)  393(top)
;x-axiis:  1000(left)  1044(right)

;purple paint bucket
;y-axis:  377(bottom)  325(top)
;x-axiis:  948(left)  992(right)

;red paint bucket mcq y-axis start from  862(bottom) to  680(top)
;red paint bucket mcq x-axis start from  560(left) to  802(right)

;orange paint bucket mcq y-axis start from  864(bottom) to  681(top)
;orange paint bucket mcq x-axis start from  1190(left) to 1434(right)

;yellow paint bucket mcq y-axis start from  660(bottom) to  477(top)
;yellow paint bucket mcq x-axis start from  1191(left) to  1434(right)

;green paint bucket mcq y-axis start from  658(bottom) to  476(top)
;green paint bucket mcq x-axis start from  867(left) to  1110(right)

;blue paint bucket mcq y-axis start from  864(bottom) to  681(top)
;blue paint bucket mcq x-axis start from  867(left) to  1109(right)

;purple paint bucket mcq y-axis start from  659(bottom) to  475(top)
;purple paint bucket mcq x-axis start from  561(left) to  802(right)
;==================================
;Shape Level 3: 

;carts y-axis start from 443(bottom) to 279(top)
;cart 1 square x-axis start from 530(left) to 752(right)
;cart 2 circle x-axis start from 771(left) to 991(right)
;cart 3 triangle x-axis start from 1012(left) to 1233(right)
;cart 4 rectangle x-axis start from 1253(left) to 1474(right)
;cart 5 pentagon x-axis start from 1493(left) to 1714(right)

;pentagon crate y-axis start from 650(bottom) to 537(top)
;pentagon crate x-axis start from 39(left) to 281(right)

;circle crate y-axis start from 788(bottom) to 668(top)
;circle crate x-axis start from 26(left) to 268(right)

;triangle crate y-axis start from 936(bottom) to 823(top)
;triangle crate x-axis start from 13(left) to 257(right)

;square crate y-axis start from 697(bottom) to 563(top)
;square crate x-axis start from 1608(left) to 1851(right)

;rectangle crate y-axis start from 882(bottom) to 752(top)
;rectangle crate x-axis start from 1589(left) to 1833(right)

;ScoreBoard next button:
;y-axis: 1018(bottom) 917(top)
;x-axiis: 1028(left) 1397(right)

;ScoreBoard exit button:
;y-axis:  1018(bottom)  910(top)
;x-axiis:  584(left)  953(right)
;=======================================================================================
;Color Level 3
;blue key y-axis start from  542(bottom) to  463(top)
;blue key x-axis start from  (left) to  930(right)

;orange key y-axis start from  542(bottom) to  463(top)
;orange key x-axis start from  944(left) to  977(right)

;yellow key y-axis start from  542(bottom) to  463(top)
;yellow key x-axis start from  846(left) to  879(right)

;door key y-axis start from  757(bottom) to  355(top)
;door key x-axis start from  770(left) to  1387(right)

;play button y-axis start from 525(bottom) to (430top)
;play button x-axis start from 1356(left) to  1521(right)

;1st button y-axis start from  774(bottom) to  578(top)
;1st button x-axis start from  488(left) to  694(right)

;2nd button y-axis start from  772(bottom) to  576(top)
;2nd button x-axis start from  754(left) to  974(right)

;3rd button y-axis start from  770(bottom) to  573(top)
;3rd button x-axis start from  1027(left) to  1236(right)

;4th button y-axis start from  765(bottom) to  569(top)
;4th button x-axis start from  1296(left) to  1502(right)

;exit  button -axyis start from  828(bottom) to  742(top)
;exit  button x-axis start from  1380(left) to  1752(right)

;red basket y-axis start from  280(bottom) to  179(top)
;red basket x-axis start from  199(left) to  479(right)

;green basket y-axis start from  272(bottom) to  173(top)
;green basket x-axis start from  801(left) to  1100(right)

;yellow basket y-axis start from  715(bottom) to  613(top)
;yellow basket x-axis start fromgrapes  198(left) to  491(right)

;orange basket y-axis start from  501(bottom) to  398(top)
;orange basket x-axis start from  192(left) to  491(right)

;blue basket y-axis start from  495(bottom) to  393(top)
;blue basket x-axis start from  802(left) to  1100(right)

;purple basket y-axis start from  712(bottom) to  607(top)
;purple basket x-axis start from  807(left) to  1106(right)

;item 1 y-axis start from  272(bottom) to  194(top)
;item 1 x-axis start from  1284(left) to  1374(right)

;item 2 y-axis start from  272(bottom) to  194(top)
;item 2 x-axis start from  1428(left) to  1530(right)

;item 3 y-axis start from  270(bottom) to  202(top)
;item 3 x-axis start from  1579(left) to  1716(right)

;item 4 y-axis start from  270(bottom) to  184(top)
;item 4 x-axis start from  1753(left) to  1898(right)

;item 5 y-axis start from  492(bottom) to  382(top)
;item 5 x-axis start from  1245(left) to  1335(right)

;item 6 y-axis start from  493(bottom) to  390(top)
;item 6 x-axis start from  1398(left) to  1480(right)

;item 7 y-axis start from  495(bottom) to  401(top)
;item 7 x-axis start from  1551(left) to  1651(right)

;item 8 y-axis start from  491(bottom) to  383(top)
;item 8 x-axis start from  1724(left) to  1799(right)

;item 9 y-axis start from  710(bottom) to  610(top)
;item 9 x-axis start from  1240(left) to  1347(right)

;item 10 y-axis start from  710(bottom) to  612(top)
;item 10 x-axis start from  1383(left) to  1506(right)

;item 11 y-axis start from  709(bottom) to  636(top)
;item 11 x-axis start from  1581(left) to  1666(right)

;item 12 y-axis start from  708(bottom) to  602(top)
;item 12 x-axis start from  1744(left) to  1823(right)

;next button y-axis start from  1088(bottom) to  920(top)
;next button x-axis start from  1426(left) to  1880(right)

;next score board button y-axis start from  1035(bottom) to  942(top)
;next score board button x-axis start from  1511(left) to  1861(right)

;exit score board button y-axis start from  1037(bottom) to  943(top)
;exit score board button x-axis start from  49(left) to  399(right)
;=======================================================================================
;Shape Level 3

;p1Circle y-axis start from  557(bottom) to  357(top)
;p1Circle x-axis start from  327(left) to  529(right)
;p1Rectangle y-axis start from  818(bottom) to  599(top)
;p1Rectangle x-axis start from  365(left) to  527(right)

;p2Square y-axis start from  557(bottom) to  357(top)
;p2Square x-axis start from  598(left) to  802(right)
;p2Traingle y-axis start from  818(bottom) to  599(top)
;p2Traingle x-axis start from  601(left) to  800(right)

;p3Pentagon y-axis start from  557(bottom) to  357(top)
;p3Pentagon x-axis start from  872(left) to  1083(right)
;p3Circle y-axis start from  818(bottom) to  599(top)
;p3Circle x-axis start from  868(left) to  1081(right)

;p4Triangle y-axis start from  557(bottom) to  357(top)
;p4Triangle x-axis start from  1150(left) to  1358(right)
;p4Square y-axis start from  818(bottom) to  599(top)
;p4Square x-axis start from  1153(left) to  1362(right)

;p5Rectangle y-axis start from  557(bottom) to  357(top)
;p5Rectangle x-axis start from  1427(left) to  1589(right)
;p5Pentagon y-axis start from  818(bottom) to  599(top)
;p5Pentagon x-axis start from  1432(left) to  1643(right)

;mcq
;top left y-axis start from  636(bottom) to  410(top)
;top left x-axis start from  526(left) to  890(right)

;bottom left y-axis start from  902(bottom) to  675(top)
;bottom left x-axis start from  525(left) to  889(right)

;top right y-axis start from  637(bottom) to  412(top)
;top right x-axis start from  1009(left) to  1372(right)

;bottom right y-axis start from  902(bottom) to  676(top)
;bottom right x-axis start from  1008(left) to  1371(right)

;retry button y-axis start from  884(bottom) to  752(top)
;retry button x-axis start from  740(left) to  1188(right)

;=======================================================================================
;Number Level 2

;Balloon 1 y-axis start from  1065(bottom) to  876(top)
;Balloon 1 x-axis start from  581(left) to  719(right) ; done

;Balloon 2 y-axis start from  1065(bottom) to  880(top)
;Balloon 2 x-axis start from  218(left) to  349(right) ; done

;Balloon 3 y-axis start from  1065(bottom) to  881(top)
;Balloon 3 x-axis start from  1154(left) to  1285(right) ; done

;Balloon 4 y-axis start from  1065(bottom) to  876(top)
;Balloon 4 x-axis start from  1537(left) to  1663(right) ; done

;Balloon 5 y-axis start from  1065(bottom) to  876(top)
;Balloon 5 x-axis start from  52(left) to  184(right) ; done

;Balloon 6 y-axis start from  1065(bottom) to  880(top)
;Balloon 6 x-axis start from  1348(left) to  1478(right) ; done

;Balloon 7 y-axis start from  1065(bottom) to  881(top)
;Balloon 7 x-axis start from  960(left) to  1091(right) ; done

;Balloon 8 y-axis start from  1065(bottom) to  876(top)
;Balloon 8 x-axis start from  393(left) to  529(right) ; done

;Balloon 9 y-axis start from  1048(bottom) to  886(top)
;Balloon 9 x-axis start from  775(left) to  905(right) ; done

;Balloon 10 y-axis start from  1065(bottom) to  876(top)
;Balloon 10 x-axis start from  1726(left) to  1852(right) ; done


;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image

;=======================================================================================
;Number Level 3

;Number Level 3 Classrom Door y-axis start from  873(bottom) to  302(top)
;Number Level 3 Classrom Door x-axis start from  1004(left) to  1286(right) ; done

;Number level 3 (click to start) y-axis start from  536(bottom) to  482(top)
;Number level 3 (click to start) x-axis start from  701(left) to  1131(right) ; done

;Number level 3 all questions
;Number level 3 Q (left option) y-axis start from  588(bottom) to  425(top)
;Number level 3 Q (left option) x-axis start from  604(left) to  797(right) ; done

;Number level 3 Q (middle option) y-axis start from  587(bottom) to  425(top)
;Number level 3 Q (middle option) x-axis start from  863(left) to  1052(right) ; done

;Number level 3 Q (right option) y-axis start from  587(bottom) to  426(top)
;Number level 3 Q (right option) x-axis start from  1123(left) to  1317(right) ; done

; Score
;Number level 3 score (exit option) y-axis start from  1014(bottom) to  910(top) ; scene: number lobby 3
;Number level 3 score (exit option) x-axis start from  585(left) to  952(right) ; done

;Number level 3 score (next option) y-axis start from  1019(bottom) to  914(top) ; scene: color number shape lobby
;Number level 3 score (next option) x-axis start from  1026(left) to  1396(right) ; done

;function
(define (mouseRegister w x y me)
  (cond
     [(and (string=? (world-scene w) "menu") ;Play button
           (mouse=? me "button-down")
           (<= y 480) 
           (>= y 377)
           (>= x 757)   
           (<= x 1148))
           (cChSelect)]

    [(and (or (string=? (world-scene w) "characterInfo1") (string=? (world-scene w) "characterInfo2") (string=? (world-scene w) "characterInfo3") 
           (string=? (world-scene w) "characterInfo4")) ;character info exit button
           (mouse=? me "button-down")
           (<= y 68) 
           (>= y 16)
           (>= x 38)   
           (<= x 219))
           swMenu]
      
      [(and (string=? (world-scene w) "menu") ;character info button
           (mouse=? me "button-down")
           (<= y 710) 
           (>= y 606)
           (>= x 762)   
           (<= x 1151))
           (swInfoBoy w)]

      [(and (or (string=? (world-scene w) "characterInfo1") (string=? (world-scene w) "characterInfo2") (string=? (world-scene w) "characterInfo3") 
                (string=? (world-scene w) "characterInfo4")) ;boy character info
                (mouse=? me "button-down")
                (<= y 357) 
                (>= y 81)
                (>= x 900)   
                (<= x 1087))
                (swInfoBoy w)]

      [(and (or (string=? (world-scene w) "characterInfo1") (string=? (world-scene w) "characterInfo2") (string=? (world-scene w) "characterInfo3") 
                (string=? (world-scene w) "characterInfo4"))  ;janitor character info
                (mouse=? me "button-down")
                (<= y 357) 
                (>= y 81)
                (>= x 1154)   
                (<= x 1345))
                (swInfoJanitor w)]

      [(and (or (string=? (world-scene w) "characterInfo1") (string=? (world-scene w) "characterInfo2") (string=? (world-scene w) "characterInfo3") 
                (string=? (world-scene w) "characterInfo4")) ;scientist character info
                (mouse=? me "button-down")
                (<= y 357) 
                (>= y 81)
                (>= x 1409)   
                (<= x 1596))
                (swInfoScientist w)]

      [(and (or (string=? (world-scene w) "characterInfo1") (string=? (world-scene w) "characterInfo2") (string=? (world-scene w) "characterInfo3") 
                (string=? (world-scene w) "characterInfo4")) ;police womna character info
                (mouse=? me "button-down")
                (<= y 357) 
                (>= y 81)
                (>= x 1648)   
                (<= x 1840))
                (swInfoPoliceWoman w)]

     [(and (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2") (string=? (world-scene w) "chSelect3") 
               (string=? (world-scene w) "chSelect4")) ;Boy character select
               (mouse=? me "button-down")
               (<= y 772) 
               (>= y 271)
               (>= x 66)   
               (<= x 448)) 
               (cBoySelect)]

     [(and (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2") (string=? (world-scene w) "chSelect3") 
               (string=? (world-scene w) "chSelect4")) ;Janitor character select
               (mouse=? me "button-down")
               (<= y 772) 
               (>= y 271)
               (>= x 531)   
               (<= x 913))
               (cJanitorSelect)]

     [(and (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2") (string=? (world-scene w) "chSelect3") 
               (string=? (world-scene w) "chSelect4")) ;Scientist character select
               (mouse=? me "button-down")
               (<= y 772) 
               (>= y 271)
               (>= x 990)   
               (<= x 1370))
               (cScientistSelect)]

     [(and (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2") (string=? (world-scene w) "chSelect3") 
               (string=? (world-scene w) "chSelect4")) ;Police Woman character select
               (mouse=? me "button-down")
               (<= y 772) 
               (>= y 271)
               (>= x 1460)   
               (<= x 1840))
          (cPoliceWomanSelect)]

     [(and (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2") (string=? (world-scene w) "chSelect3") 
               (string=? (world-scene w) "chSelect4"))  ;chSelect confirm button
               (mouse=? me "button-down")
               (<= y 1080) 
               (>= y 931)
               (>= x 1570)   
               (<= x 1855)) 
               (cTutorialPopUp w)]

     [(and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp yes button
           (mouse=? me "button-down")
           (<= y 770) 
           (>= y 670)
           (>= x 567)   
           (<= x 915))
          (cTutorial w)]

     [(and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp no button
           (mouse=? me "button-down")
           (<= y 770)
           (>= y 670)
           (>= x 1029)
           (<= x 1376))
           (cLobby w)]

     [(and (string=? (world-scene w) "tutorialMovement") ;next movement tutorial button
           (mouse=? me "button-down")
           (<= y 1032)
           (>= y 936)
           (>= x 1570)
           (<= x 1855)) 
           (swRedTutorial w)]      

     [(and (string=? (world-scene w) "shapeElevator") ;Level 1 Elevator Button
           (mouse=? me "button-down")
           (<= y 453)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swShapeLobbyL1 w)]

     [(and (string=? (world-scene w) "shapeElevator") ;Level 2 Elevator Button
           (mouse=? me "button-down")
           (<= y 505)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swShapeLobbyL2 w)]

     [(and (string=? (world-scene w) "shapeElevator") ;Level 3 Elevator Button3
           (mouse=? me "button-down")
           (<= y 556)
           (>= y 522)
           (>= x 1443)
           (<= x 1480)) 
           (swShapeLobbyL3 w)]

     [(and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 Q1 topRight Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (swShapeLevel1Q2 w)]

     [(and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 Q1 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 Q1 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 Q1 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 1 Q2 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 1 Q2 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 1 Q2 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 1 Q2 bottomLeft Correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (swShapeLevel1Q3 w)]  
        
     [(and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 1 Q3 topRight Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 1 Q3 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (swShapeLevel1Q4 w)]

     [(and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 1 Q3 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 1 Q3 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]   

     [(and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 1 Q4 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 1 Q4 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 1 Q4 topLeft Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (swShapeLevel1Q5 w)]

     [(and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 1 Q4 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)] 

     [(and (string=? (world-scene w) "shapeLevel1Q5") ;Shape Level 1 Q5 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q5") ;Shape Level 1 Q5 bottomRight correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (swShapeLevel1Score5 w)]

     [(and (string=? (world-scene w) "shapeLevel1Q5") ;Shape Level 1 Q5 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "shapeLevel1Q5") ;Shape Level 1 Q5 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)] 

      [(and (string=? (world-scene w) "shapeLevel1Score5") ;level 1 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swShapeLobbyL1 w)]  

     [(and (string=? (world-scene w) "shapeLevel1Score5") ;level 1 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (swShapeLobbyL2 w)]

      [(and (string=? (world-scene w) "shapeLevel2Score8") ;level 1 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swShapeLobbyL2 w)]  

     [(and (string=? (world-scene w) "shapeLevel2Score8") ;level 1 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (swShapeLobbyL3 w)]           

      [(and (string=? (world-scene w) "shapeLevel3Score5") ;level 3 score board exit button
            (mouse=? me "button-down")
            (<= y 1018) 
            (>= y 910)
            (>= x 584)   
            (<= x 953))
            (swShapeLobbyL3 w)]  

      [(and (string=? (world-scene w) "shapeLevel3Score5") ;level 3 next button
            (mouse=? me "button-down")
            (<= y 1018) 
            (>= y 917)
            (>= x 1028)   
            (<= x 1397))
            (cLobby w)]

     [(and (string=? (world-scene w) "colorElevator") ;Level 1 Color Elevator Button
           (mouse=? me "button-down")
           (<= y 453)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swColorLobbyL1 w)]

     [(and (string=? (world-scene w) "colorElevator") ;Level 2 Color Elevator Button
           (mouse=? me "button-down")
           (<= y 505)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swColorLobbyL2 w)]

     [(and (string=? (world-scene w) "colorElevator") ;Level 3 Color Elevator Button3
           (mouse=? me "button-down")
           (<= y 556)
           (>= y 522)
           (>= x 1443)
           (<= x 1480)) 
           (swColorLobbyL3 w)]

     [(and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 Q1 topRight Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 Q1 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 Q1 topLeft right button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (swColorLevel1Q2  w)]

     [(and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 Q1 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q2") ;color Level 1 Q2 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q2") ;color Level 1 Q2 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q2") ;color Level 1 Q2 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q2") ;color Level 1 Q2 bottomLeft Correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (swColorLevel1Q3 w)]  
        
     [(and (string=? (world-scene w) "colorLevel1Q3") ;color Level 1 Q3 topRight Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (swColorLevel1Q4 w)]

     [(and (string=? (world-scene w) "colorLevel1Q3") ;color Level 1 Q3 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q3") ;color Level 1 Q3 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q3") ;color Level 1 Q3 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]   

     [(and (string=? (world-scene w) "colorLevel1Q4") ;color Level 1 Q4 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q4") ;color Level 1 Q4 bottomRight right button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (swColorLevel1Q5 w)]

     [(and (string=? (world-scene w) "colorLevel1Q4") ;color Level 1 Q4 topLeft Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q4") ;color Level 1 Q4 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q5") ;color Level 1 Q5 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q5") ;color Level 1 Q5 bottomRight correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (swColorLevel1Score5 w)]

     [(and (string=? (world-scene w) "colorLevel1Q5") ;color Level 1 Q5 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Q5") ;color Level 1 Q5 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "colorLevel1Score5") ;level 1 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swColorLobbyL1 w)]  

     [(and (string=? (world-scene w) "colorLevel1Score5") ;level 1 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (swColorLobbyL2 w)]

    [(and (string=? (world-scene w) "colorLevel2Score6") ;level 2 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (swColorLobbyL3 w)]

     [(and (string=? (world-scene w) "colorLevel2Score6") ;level 2 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swColorLobbyL2 w)]

     [(and (string=? (world-scene w) "numberElevator") ;Level 1 Number Elevator Button
           (mouse=? me "button-down")
           (<= y 453)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swNumberLobbyL1 w)]

     [(and (string=? (world-scene w) "numberElevator") ;Level 2 Number Elevator Button
           (mouse=? me "button-down")
           (<= y 505)
           (>= y 419)
           (>= x 1443)
           (<= x 1480)) 
           (swNumberLobbyL2 w)]

     [(and (string=? (world-scene w) "numberElevator") ;Level 3 Number Elevator Button3
           (mouse=? me "button-down")
           (<= y 556)
           (>= y 522)
           (>= x 1443)
           (<= x 1480)) 
           (swNumberLobbyL3 w)]

     [(and (string=? (world-scene w) "numberLevel1Q1") ;number Level 1 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q1") ;number Level 1 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q1") ;number Level 1 topLeft correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (swNumberLevel1Q2 w)]

     [(and (string=? (world-scene w) "numberLevel1Q1") ;number Level 1 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q2") ;number Level 2 topRight wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q2") ;number Level 2 bottomRight correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (swNumberLevel1Q3 w)]

     [(and (string=? (world-scene w) "numberLevel1Q2") ;number Level 2 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q2") ;number Level 2 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]  
        
     [(and (string=? (world-scene w) "numberLevel1Q3") ;number Level 3 topRight Correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q3") ;number Level 3 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q3") ;number Level 3 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q3") ;number Level 3 bottomLeft correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (swNumberLevel1Q4 w)]   

     [(and (string=? (world-scene w) "numberLevel1Q4") ;number Level 4 topRight correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (swNumberLevel1Q5 w)]

     [(and (string=? (world-scene w) "numberLevel1Q4") ;number Level 4 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q4") ;number Level 4 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q4") ;number Level 4 bottomLeft wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q5") ;number Level 5 topRight correct button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q5") ;number Level 5 bottomRight wrong button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 1067)
           (<= x 1564)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q5") ;number Level 5 topLeft wrong button
           (mouse=? me "button-down")
           (<= y 808)
           (>= y 663)
           (>= x 357)
           (<= x 855)) 
           (wrongAnswer w)]

     [(and (string=? (world-scene w) "numberLevel1Q5") ;number Level 5 bottomLeft correct button
           (mouse=? me "button-down")
           (<= y 990)
           (>= y 844)
           (>= x 357)
           (<= x 855)) 
           (swNumberLevel1Score5 w)]

     [(and (string=? (world-scene w) "numberLevel1Score5") ;level 1 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swNumberLobbyL1 w)]  

     [(and (string=? (world-scene w) "numberLevel1Score5") ;level 1 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (swNumberLobbyL2 w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame") ;skin update once character clicks on red bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame")) 
           (mouse=? me "button-down")
           (<= y 446) 
           (>= y 393)
           (>= x 898)   
           (<= x 942))
           (changeSkinToRed w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame") ;skin update once character clicks on orange bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame"))  
           (mouse=? me "button-down")
           (<= y 378) 
           (>= y 326)
           (>= x 894)   
           (<= x 939))
           (changeSkinToOrange w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame")  ;skin update once character clicks on yellow bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame")) 
           (mouse=? me "button-down")
           (<= y 378) 
           (>= y 324)
           (>= x 1001)   
           (<= x 1045))
           (changeSkinToYellow w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame") ;skin update once character clicks on green bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame"))  
           (mouse=? me "button-down")
           (<= y 447) 
           (>= y 393)
           (>= x 949)   
           (<= x 992))
           (changeSkinToGreen w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame");skin update once character clicks on blue bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame"))  
           (mouse=? me "button-down")
           (<= y 448) 
           (>= y 393)
           (>= x 1000)   
           (<= x 1044))
           (changeSkinToBlue w)]

     [(and (or (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "colorLevel2RedFrame") ;skin update once character clicks on purple bucket
               (string=? (world-scene w) "colorLevel2OrangeFrame") (string=? (world-scene w) "colorLevel2YellowFrame") 
               (string=? (world-scene w) "colorLevel2GreenFrame") (string=? (world-scene w) "colorLevel2BlueFrame") 
               (string=? (world-scene w) "colorLevel2PurpleFrame"))  
           (mouse=? me "button-down")
           (<= y 377) 
           (>= y 325)
           (>= x 948)   
           (<= x 992))
           (changeSkinToPurple w)]
      
      [(and (or (string=? (world-scene w) "shapeLevel2Train") (string=? (world-scene w) "squareCart") ;skin updates once character clicks on circle crate
                (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart")
                (string=? (world-scene w) "rectangleCart")) 
            (mouse=? me "button-down")
            (<= y 788) 
            (>= y 668)
            (>= x 26)   
            (<= x 268))
            (changeSkinToCircle w)]

      [(and (or (string=? (world-scene w) "shapeLevel2Train") (string=? (world-scene w) "squareCart") ;skin updates once character clicks on rectangle crate
                (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart")
                (string=? (world-scene w) "rectangleCart"))  
            (mouse=? me "button-down")
            (<= y 882) 
            (>= y 752)
            (>= x 1589)   
            (<= x 1833))
            (changeSkinToRecatngle w)]

      [(and (or (string=? (world-scene w) "shapeLevel2Train") (string=? (world-scene w) "squareCart"); skin updates once character clicks on pentagon crate
                (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart")
                (string=? (world-scene w) "rectangleCart"))  
            (mouse=? me "button-down")
            (<= y 650) 
            (>= y 537)
            (>= x 39)   
            (<= x 281))
            (changeSkinToPentagon w)]

       [(and (or (string=? (world-scene w) "shapeLevel2Train") (string=? (world-scene w) "squareCart") ;skin updates once character clicks on triangle crate
                 (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart")
                (string=? (world-scene w) "rectangleCart"))  
            (mouse=? me "button-down")
            (<= y 936) 
            (>= y 823)
            (>= x 13)   
            (<= x 257))
            (changeSkinToTriangle w)]

        [(and (or (string=? (world-scene w) "shapeLevel2Train") (string=? (world-scene w) "squareCart") ;skin updates once character clicks on square crate
                  (string=? (world-scene w) "circleCart") (string=? (world-scene w) "triangleCart")
                (string=? (world-scene w) "rectangleCart"))  
            (mouse=? me "button-down")
            (<= y 697) 
            (>= y 563)
            (>= x 1608)   
            (<= x 1851))
            (changeSkinToSqaure w)]

        [(and (string=? (world-scene w) "shapeLevel2Train") ; square cart becomes full when clicked
            (mouse=? me "button-down")
            (<= y 443) 
            (>= y 279)
            (>= x 530)   
            (<= x 752))
            (correctSkinToCart w)]

        [(and (string=? (world-scene w) "squareCart") ; circle cart becomes full when clicked
            (mouse=? me "button-down")
            (<= y 443) 
            (>= y 279)
            (>= x 771)   
            (<= x 991))
            (correctSkinToCart w)]    

        [(and (string=? (world-scene w) "circleCart") ; triangle cart becomes full when clicked
            (mouse=? me "button-down")
            (<= y 443) 
            (>= y 279)
            (>= x 1012)   
            (<= x 1233))
            (correctSkinToCart w)]       

        [(and (string=? (world-scene w) "triangleCart") ; rectangle cart becomes full when clicked
            (mouse=? me "button-down")
            (<= y 443) 
            (>= y 279)
            (>= x 1253)   
            (<= x 1474))
            (correctSkinToCart w)]   

        [(and (string=? (world-scene w) "rectangleCart") ; pentagon cart becomes full when clicked so score 5 is shown
            (mouse=? me "button-down")
            (<= y 443) 
            (>= y 279)
            (>= x 1493)   
            (<= x 1714))
            (correctSkinToCart w)]    

        [(and (string=? (world-scene w) "colorLevel2") ; frame becomes red when clicked
            (mouse=? me "button-down")
            (<= y 530) 
            (>= y 405)
            (>= x 169)   
            (<= x 313))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel2RedFrame") ; frame becomes orange when clicked
            (mouse=? me "button-down")
            (<= y 555) 
            (>= y 365)
            (>= x 421)   
            (<= x 547))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel2OrangeFrame") ; frame becomes yellow when clicked
            (mouse=? me "button-down")
            (<= y 504) 
            (>= y 312)
            (>= x 698)   
            (<= x 820))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel2YellowFrame") ; frame becomes green when clicked
            (mouse=? me "button-down")
            (<= y 504) 
            (>= y 312)
            (>= x 1095)   
            (<= x 1217))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel2GreenFrame") ; frame becomes blue when clicked
            (mouse=? me "button-down")
            (<= y 555) 
            (>= y 367)
            (>= x 1360)   
            (<= x 1485))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel2BlueFrame") ; frame becomes purple when clicked
            (mouse=? me "button-down")
            (<= y 511) 
            (>= y 395)
            (>= x 1589)   
            (<= x 1768))
            (correctSkinToFrame w)]

        [(and (string=? (world-scene w) "colorLevel3KeyDoor") ; skin changes to blue key 
            (mouse=? me "button-down")
            (<= y 542) 
            (>= y 463)
            (>= x 900)   
            (<= x 930))
            (changeSkinToBlueKey w)]

         [(and (string=? (world-scene w) "colorLevel3KeyDoor") ; skin changes to orange key 
            (mouse=? me "button-down")
            (<= y 542) 
            (>= y 463)
            (>= x 944)   
            (<= x 977))
            (changeSkinToOrangeKey w)]

         [(and (string=? (world-scene w) "colorLevel3KeyDoor") ; skin changes to yellow key 
            (mouse=? me "button-down")
            (<= y 542) 
            (>= y 463)
            (>= x 846)   
            (<= x 879))
            (changeSkinToYellowKey w)]

        [(and (string=? (world-scene w) "colorLevel3KeyDoor") ;color level 3 door opens
            (mouse=? me "button-down")
            (<= y 757) 
            (>= y 355)
            (>= x 770)   
            (<= x 1387))
            (correctSkinToDoor w)]

        [(and (string=? (world-scene w) "colorLevel3Classroom") ;color level 3 play button
            (mouse=? me "button-down")
            (<= y 525) 
            (>= y 430)
            (>= x 1356)   
            (<= x 1524))
            (swColorLevel3Q1 w)]

         [(and (string=? (world-scene w) "colorLevel3Q1") ; q1 color level 3 1st button
            (mouse=? me "button-down")
            (<= y 774) 
            (>= y 578)
            (>= x 488)   
            (<= x 694))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q1") ; q1 color level 3 2nd button
            (mouse=? me "button-down")
            (<= y 772) 
            (>= y 576)
            (>= x 754)   
            (<= x 974))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q1") ; q1 color level 3 3rd button
            (mouse=? me "button-down")
            (<= y 770) 
            (>= y 573)
            (>= x 1027)   
            (<= x 1236))
            (swColorLevel3Q2 w)]

        [(and (string=? (world-scene w) "colorLevel3Q1") ; q1 color level 3 4rth button
            (mouse=? me "button-down")
            (<= y 765) 
            (>= y 569)
            (>= x 1269)   
            (<= x 1502))
            (wrongAnswer w)]

         [(and (string=? (world-scene w) "colorLevel3Q2") ; q2 color level 3 1st button
            (mouse=? me "button-down")
            (<= y 774) 
            (>= y 578)
            (>= x 488)   
            (<= x 694))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q2") ; q2 color level 3 2nd button
            (mouse=? me "button-down")
            (<= y 772) 
            (>= y 576)
            (>= x 754)   
            (<= x 974))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q2") ; q2 color level 3 3rd button
            (mouse=? me "button-down")
            (<= y 770) 
            (>= y 573)
            (>= x 1027)   
            (<= x 1236))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q2") ; q2 color level 3 4rth button
            (mouse=? me "button-down")
            (<= y 765) 
            (>= y 569)
            (>= x 1269)   
            (<= x 1502))
            (swColorLevel3Q3 w)]

        [(and (string=? (world-scene w) "colorLevel3Q3") ; q3 color level 3 1st button
            (mouse=? me "button-down")
            (<= y 774) 
            (>= y 578)
            (>= x 488)   
            (<= x 694))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q3") ; q3 color level 3 2nd button
            (mouse=? me "button-down")
            (<= y 772) 
            (>= y 576)
            (>= x 754)   
            (<= x 974))
            (swColorLevel3SubScore w)]

        [(and (string=? (world-scene w) "colorLevel3Q3") ; q3 color level 3 3rd button
            (mouse=? me "button-down")
            (<= y 770) 
            (>= y 573)
            (>= x 1027)   
            (<= x 1236))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel3Q3") ; q3 color level 3 4rth button
            (mouse=? me "button-down")
            (<= y 765) 
            (>= y 569)
            (>= x 1269)   
            (<= x 1502))
            (wrongAnswer w)]

         [(and (string=? (world-scene w) "colorLevel3SubScore") ; subscore exit button
            (mouse=? me "button-down")
            (<= y 828) 
            (>= y 742)
            (>= x 1380)   
            (<= x 1752))
            (swColorLevel3Door2 w)]

         [(and (string=? (world-scene w) "colorLevel3ItemsFull") ; item 1
            (mouse=? me "button-down")
            (<= y 272) 
            (>= y 194)
            (>= x 1284)   
            (<= x 1374))
            (storeItem1Clicked w)]


        [(and (string=? (world-scene w) "itemFull") ; red basket apple
            (mouse=? me "button-down")
            (<= y 280) 
            (>= y 179)
            (>= x 199)   
            (<= x 479))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item1") ; item 2
            (mouse=? me "button-down")
            (<= y 272) 
            (>= y 194)
            (>= x 1428)   
            (<= x 1530))
            (storeItem2Clicked w)]

        [(and (string=? (world-scene w) "item2") ; yellow basket banna
            (mouse=? me "button-down")
            (<= y 715) 
            (>= y 613)
            (>= x 198)   
            (<= x 491))
            (correctItemToBasket w)]

         [(and (string=? (world-scene w) "colorLevel3Item2") ; item3 fish
            (mouse=? me "button-down")
            (<= y 270) 
            (>= y 202)
            (>= x 1579)   
            (<= x 1716))
            (storeItem3Clicked w)]

        [(and (string=? (world-scene w) "item3") ; blue basket fish
            (mouse=? me "button-down")
            (<= y 495) 
            (>= y 393)
            (>= x 802)   
            (<= x 1100))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item3") ; item 4 carrot
            (mouse=? me "button-down")
            (<= y 270) 
            (>= y 184)
            (>= x 1753)   
            (<= x 1898))
            (storeItem4Clicked w)]

        [(and (string=? (world-scene w) "item4") ; orange basket carrot
            (mouse=? me "button-down")
            (<= y 501) 
            (>= y 393)
            (>= x 192)   
            (<= x 491))
            (correctItemToBasket w)]

         [(and (string=? (world-scene w) "colorLevel3Item4") ; item 5 grapes
            (mouse=? me "button-down")
            (<= y 492) 
            (>= y 382)
            (>= x 1245)   
            (<= x 1335))
            (storeItem5Clicked w)]
        
        [(and (string=? (world-scene w) "item5") ; purple basket grapes
            (mouse=? me "button-down")
            (<= y 712) 
            (>= y 607)
            (>= x 807)   
            (<= x 1106))
            (correctItemToBasket w)]

         [(and (string=? (world-scene w) "colorLevel3Item5") ; item 6 leaf
            (mouse=? me "button-down")
            (<= y 493) 
            (>= y 390)
            (>= x 1398)   
            (<= x 1480))
            (storeItem6Clicked w)]

        [(and (string=? (world-scene w) "item6") ; green basket leaf
            (mouse=? me "button-down")
            (<= y 272) 
            (>= y 173)
            (>= x 801)   
            (<= x 1100))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item6") ; item 7 orange
            (mouse=? me "button-down")
            (<= y 495) 
            (>= y 401)
            (>= x 1551)   
            (<= x 1651))
            (storeItem7Clicked w)]

        [(and (string=? (world-scene w) "item7") ; orange basket orange
            (mouse=? me "button-down")
            (<= y 501) 
            (>= y 398)
            (>= x 192)   
            (<= x 491))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item7") ; item 8 flower
            (mouse=? me "button-down")
            (<= y 491) 
            (>= y 383)
            (>= x 1724)   
            (<= x 1799))
            (storeItem8Clicked w)]

        [(and (string=? (world-scene w) "item8") ; red basket flower
            (mouse=? me "button-down")
            (<= y 280) 
            (>= y 179)
            (>= x 199)   
            (<= x 479))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item8") ; item 9 duck
            (mouse=? me "button-down")
            (<= y 710) 
            (>= y 610)
            (>= x 1240)   
            (<= x 1347))
            (storeItem9Clicked w)]

        [(and (string=? (world-scene w) "item9") ; yellow basket duck
            (mouse=? me "button-down")
            (<= y 715) 
            (>= y 613)
            (>= x 198)   
            (<= x 491))
            (correctItemToBasket w)]

           [(and (string=? (world-scene w) "colorLevel3Item9") ; item 10 butterfly
            (mouse=? me "button-down")
            (<= y 710) 
            (>= y 612)
            (>= x 1383)   
            (<= x 1506))
            (storeItem10Clicked w)]

        [(and (string=? (world-scene w) "item10") ; blue basket butterfly
            (mouse=? me "button-down")
            (<= y 495) 
            (>= y 393)
            (>= x 802)   
            (<= x 1100))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item10") ; item 11 lime
            (mouse=? me "button-down")
            (<= y 709) 
            (>= y 626)
            (>= x 1581)   
            (<= x 1666))
            (storeItem11Clicked w)]

         [(and (string=? (world-scene w) "item11") ; green basket lime
            (mouse=? me "button-down")
            (<= y 272) 
            (>= y 173)
            (>= x 801)   
            (<= x 1100))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item11") ; item 12 plum
            (mouse=? me "button-down")
            (<= y 709) 
            (>= y 602)
            (>= x 1744)   
            (<= x 1823))
            (storeItem12Clicked w)]

        [(and (string=? (world-scene w) "item12") ; purple basket plum
            (mouse=? me "button-down")
            (<= y 712) 
            (>= y 607)
            (>= x 807)   
            (<= x 1106))
            (correctItemToBasket w)]

        [(and (string=? (world-scene w) "colorLevel3Item12") ;next buttom items
            (mouse=? me "button-down")
            (<= y 1088) 
            (>= y 920)
            (>= x 1426)   
            (<= x 1880))
            (swColorLevel3Award w)]

        [(and (string=? (world-scene w) "colorLevel3Award"); color level 3  next score board
            (mouse=? me "button-down")
            (<= y 1035) 
            (>= y 942)
            (>= x 1511)   
            (<= x 1861))
            (swColorLevel3Score16 w)]

        [(and (string=? (world-scene w) "colorLevel3Score16") ;level 3 next button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 917)
           (>= x 1028)   
           (<= x 1397))
           (cLobby w)]

     [(and (string=? (world-scene w) "colorLevel3Score16") ;level 3 score board exit button
           (mouse=? me "button-down")
           (<= y 1018) 
           (>= y 910)
           (>= x 584)   
           (<= x 953))
           (swColorLobbyL3 w)]  
  
        [(and (string=? (world-scene w) "shapeLevel3") ; Circle 1
            (mouse=? me "button-down")
            (<= y 557) 
            (>= y 357)
            (>= x 327)   
            (<= x 529))
            (swShapeLevel3Score0Retry w)]

        [(and (or (string=? (world-scene w) "shapeLevel3Score0Retry") (string=? (world-scene w) "shapeLevel3Score1Retry") 
                  (string=? (world-scene w) "shapeLevel3Score2Retry") (string=? (world-scene w) "shapeLevel3Score3Retry")
                  (string=? (world-scene w) "shapeLevel3Score4Retry")); retry button part 1
            (mouse=? me "button-down")
            (<= y 884) 
            (>= y 752)
            (>= x 740)   
            (<= x 1188))
            (swShapeLevel3RetryButton w)]

        [(and (or (string=? (world-scene w) "shapeLevel3Score5Retry") (string=? (world-scene w) "shapeLevel3Score6Retry") 
                  (string=? (world-scene w) "shapeLevel3Score7Retry") (string=? (world-scene w) "shapeLevel3Score8Retry")
                  (string=? (world-scene w) "shapeLevel3Score9Retry")); retry button part 2
            (mouse=? me "button-down")
            (<= y 884) 
            (>= y 752)
            (>= x 740)   
            (<= x 1188))
            (swShapeLevel3RetryButton2 w)]    

        [(and (string=? (world-scene w) "shapeLevel3") ; Rectangle 1
            (mouse=? me "button-down")
            (<= y 818) 
            (>= y 599)
            (>= x 365)   
            (<= x 527))
            (swRectangleP1 w)]
        
        [(and (string=? (world-scene w) "p1Rectangle") ; square 2
            (mouse=? me "button-down")
            (<= y 557) 
            (>= y 357)
            (>= x 598)   
            (<= x 802))
            (swSquareP2 w)]

         [(and (string=? (world-scene w) "p1Rectangle") ; Triangle 2
            (mouse=? me "button-down")
            (<= y 818) 
            (>= y 599)
            (>= x 601)   
            (<= x 800))
            (swShapeLevel3Score1Retry w)]

        [(and (string=? (world-scene w) "p2Square") ; Cirlce 3
            (mouse=? me "button-down")
            (<= y 818) 
            (>= y 599)
            (>= x 868)   
            (<= x 1081))
            (swCircleP3 w)]

        [(and (string=? (world-scene w) "p2Square") ; Pentagon 3
            (mouse=? me "button-down")
            (<= y 557) 
            (>= y 357)
            (>= x 872)   
            (<= x 1093))
            (swShapeLevel3Score2Retry w)]  

        [(and (string=? (world-scene w) "p3Circle") ; Triangle 4
            (mouse=? me "button-down")
            (<= y 557) 
            (>= y 357)
            (>= x 1150)   
            (<= x 1358))
            (swTriangleP4 w)]

        [(and (string=? (world-scene w) "p3Circle") ; square 4
            (mouse=? me "button-down")
            (<= y 818) 
            (>= y 599)
            (>= x 1153)   
            (<= x 1362))
            (swShapeLevel3Score3Retry w)]  

        [(and (string=? (world-scene w) "p4Triangle") ; Pentagon 5
            (mouse=? me "button-down")
            (<= y 818) 
            (>= y 599)
            (>= x 1432)   
            (<= x 1643))
            (swShapeLevel3Q1 w)]

        [(and (string=? (world-scene w) "p4Triangle") ; Rectangle 5
            (mouse=? me "button-down")
            (<= y 557) 
            (>= y 357)
            (>= x 1427)   
            (<= x 1589))
            (swShapeLevel3Score4Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q1") ; q1 top left
            (mouse=? me "button-down")
            (<= y 636) 
            (>= y 410)
            (>= x 526)   
            (<= x 890))
            (swShapeLevel3Q2 w)] 

         [(and (string=? (world-scene w) "shapeLevel3Q1") ; q1 bottom left
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 675)
            (>= x 525)   
            (<= x 889))
            (swShapeLevel3Score5Retry w)] 
        
        [(and (string=? (world-scene w) "shapeLevel3Q1") ; q1 top right
            (mouse=? me "button-down")
            (<= y 637) 
            (>= y 412)
            (>= x 1009)   
            (<= x 1372))
            (swShapeLevel3Score5Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q1") ; q1 bottom right
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 676)
            (>= x 1008)   
            (<= x 1371))
            (swShapeLevel3Score5Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q2") ; q2 top left
            (mouse=? me "button-down")
            (<= y 636) 
            (>= y 410)
            (>= x 526)   
            (<= x 890))
            (swShapeLevel3Score6Retry w)] 

         [(and (string=? (world-scene w) "shapeLevel3Q2") ; q2 bottom left
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 675)
            (>= x 525)   
            (<= x 889))
            (swShapeLevel3Score6Retry w)] 
        
        [(and (string=? (world-scene w) "shapeLevel3Q2") ; q2 top right
            (mouse=? me "button-down")
            (<= y 637) 
            (>= y 412)
            (>= x 1009)   
            (<= x 1372))
            (swShapeLevel3Q3 w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q2") ; q2 bottom right
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 676)
            (>= x 1008)   
            (<= x 1371))
            (swShapeLevel3Score6Retry w)] 


         [(and (string=? (world-scene w) "shapeLevel3Q3") ; q3 top left
            (mouse=? me "button-down")
            (<= y 636) 
            (>= y 410)
            (>= x 526)   
            (<= x 890))
            (swShapeLevel3Score7Retry w)] 

         [(and (string=? (world-scene w) "shapeLevel3Q3") ; q3 bottom left
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 675)
            (>= x 525)   
            (<= x 889))
            (swShapeLevel3Score7Retry w)] 
        
        [(and (string=? (world-scene w) "shapeLevel3Q3") ; q3 top right
            (mouse=? me "button-down")
            (<= y 637) 
            (>= y 412)
            (>= x 1009)   
            (<= x 1372))
            (swShapeLevel3Score7Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q3") ; q3 bottom right
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 676)
            (>= x 1008)   
            (<= x 1371))
            (swShapeLevel3Q4 w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q4") ; q4 top left
            (mouse=? me "button-down")
            (<= y 636) 
            (>= y 410)
            (>= x 526)   
            (<= x 890))
            (swShapeLevel3Score8Retry w)] 

         [(and (string=? (world-scene w) "shapeLevel3Q4") ; q4 bottom left
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 675)
            (>= x 525)   
            (<= x 889))
            (swShapeLevel3Q5 w)] 
        
        [(and (string=? (world-scene w) "shapeLevel3Q4") ; q4 top right
            (mouse=? me "button-down")
            (<= y 637) 
            (>= y 412)
            (>= x 1009)   
            (<= x 1372))
            (swShapeLevel3Score8Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q4") ; q4 bottom right
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 676)
            (>= x 1008)   
            (<= x 1371))
            (swShapeLevel3Score8Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q5") ; q5 top left
            (mouse=? me "button-down")
            (<= y 636) 
            (>= y 410)
            (>= x 526)   
            (<= x 890))
            (swShapeLevel3Score9Retry w)] 

         [(and (string=? (world-scene w) "shapeLevel3Q5") ; q5 bottom left
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 675)
            (>= x 525)   
            (<= x 889))
            (swShapeLevel3Score5 w)] 
        
        [(and (string=? (world-scene w) "shapeLevel3Q5") ; q5 top right
            (mouse=? me "button-down")
            (<= y 637) 
            (>= y 412)
            (>= x 1009)   
            (<= x 1372))
            (swShapeLevel3Score9Retry w)] 

        [(and (string=? (world-scene w) "shapeLevel3Q5") ; q5 bottom right
            (mouse=? me "button-down")
            (<= y 902) 
            (>= y 676)
            (>= x 1008)   
            (<= x 1371))
            (swShapeLevel3Score9Retry w)] 

         [(and (string=? (world-scene w) "numberLevel2Q1") ; balloon 1
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 581)   
            (<= x 719))
            (swNumberLevel2Q w 1)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2")) ; balloon 2
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 218)   
            (<= x 349))
            (swNumberLevel2Q w 2)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3")) ; balloon 3
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 1154)   
            (<= x 1285))
            (swNumberLevel2Q w 3)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4")); balloon 4
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 1537)   
            (<= x 1663))
            (swNumberLevel2Q w 4)]   

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5")) ; balloon 5
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 52)   
            (<= x 184))
            (swNumberLevel2Q w 5)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5") (string=? (world-scene w) "numberLevel2Q6")) ; balloon 6
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 1348)   
            (<= x 1478))
            (swNumberLevel2Q w 6)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5") (string=? (world-scene w) "numberLevel2Q6") 
                  (string=? (world-scene w) "numberLevel2Q7")) ; balloon 7
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 960)   
            (<= x 1091))
            (swNumberLevel2Q w 7)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5") (string=? (world-scene w) "numberLevel2Q6") 
                  (string=? (world-scene w) "numberLevel2Q7") (string=? (world-scene w) "numberLevel2Q8")) ; balloon 8
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 393)   
            (<= x 529))
            (swNumberLevel2Q w 8)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5") (string=? (world-scene w) "numberLevel2Q6") 
                  (string=? (world-scene w) "numberLevel2Q7") (string=? (world-scene w) "numberLevel2Q8") (string=? (world-scene w) "numberLevel2Q9")) ; balloon 9
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 775)   
            (<= x 905))
            (swNumberLevel2Q w 9)] 

        [(and (or (string=? (world-scene w) "numberLevel2Q1") (string=? (world-scene w) "numberLevel2Q2") (string=? (world-scene w) "numberLevel2Q3") 
                  (string=? (world-scene w) "numberLevel2Q4") (string=? (world-scene w) "numberLevel2Q5") (string=? (world-scene w) "numberLevel2Q6") 
                  (string=? (world-scene w) "numberLevel2Q7") (string=? (world-scene w) "numberLevel2Q8") (string=? (world-scene w) "numberLevel2Q9") 
                  (string=? (world-scene w) "numberLevel2Q10")) ; balloon 10
            (mouse=? me "button-down")
            (<= y 1065) 
            (>= y 876)
            (>= x 1726)   
            (<= x 1825))
            (swNumberLevel2Q w 10)]

            [(and (string=? (world-scene w) "numberLevel2Score10") ; number level 2 score board (next button)
            (mouse=? me "button-down")
            (<= y 1019) 
            (>= y 914)
            (>= x 1026)   
            (<= x 1396))
            (swNumberLobbyL3 w)]  

        [(and (string=? (world-scene w) "numberLevel2Score10") ; number level 2 score board (exit button)
            (mouse=? me "button-down")
            (<= y 1014) 
            (>= y 910)
            (>= x 585)   
            (<= x 952))
            (swNumberLobbyL2 w)]  

          [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 correct red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (swColorLevel2Q2 w)]

        [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 wrong orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 wrong yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 wrong green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
            (<= x 1110))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 wrong blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q1") ; color level 2 q1 wrong purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (wrongAnswer w)]



       [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 wrong red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 wrong orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 wrong yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 correct green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
            (<= x 1110))
            (swColorLevel2Q3 w)] 

        [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 wrong blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q2") ; color level 2 q2 wrong purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (wrongAnswer w)]     



        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 wrong red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 wrong orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 wrong yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 wrong green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
            (<= x 1110))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 correct blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (swColorLevel2Q4 w)] 

        [(and (string=? (world-scene w) "colorLevel2Q3") ; color level 2 q3 wrong purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (wrongAnswer w)]


        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 wrong red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 wrong orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 correct yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (swColorLevel2Q5 w)] 

        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 wrong green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
            (<= x 1110))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 wrong blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q4") ; color level 2 q4 wrong purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 wrong red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 wrong orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 wrong yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 wrong green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
            (<= x 1110))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 wrong blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q5") ; color level 2 q5 correct purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (swColorLevel2Q6 w)]

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 wrong red bucket
            (mouse=? me "button-down")
            (<= y 862) 
            (>= y 680)
            (>= x 560)   
            (<= x 802))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 correct orange bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 1190)   
            (<= x 1434))
            (swColorLevel2 w)] 

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 wrong yellow bucket
            (mouse=? me "button-down")
            (<= y 660) 
            (>= y 477)
            (>= x 1191)   
            (<= x 1434))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 wrong green bucket
            (mouse=? me "button-down")
            (<= y 658) 
            (>= y 476)
            (>= x 867)   
           ` (<= x 1110))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 wrong blue bucket
            (mouse=? me "button-down")
            (<= y 864) 
            (>= y 681)
            (>= x 867)   
            (<= x 1109))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "colorLevel2Q6") ; color level 2 q6 wrong purple bucket
            (mouse=? me "button-down")
            (<= y 659) 
            (>= y 475)
            (>= x 561)   
            (<= x 802))
            (wrongAnswer w)]
        
        [(and (string=? (world-scene w) "numberLevel3Start") ; number level 3 start board
            (mouse=? me "button-down")
            (<= y 536) 
            (>= y 302)
            (>= x 701)   
            (<= x 1131))
            (swNumberLevel3Q1 w)] 

        [(and (string=? (world-scene w) "numberLevel3Q1") ; number level 3 Q1 correct answer (right)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 426)
            (>= x 1123)   
            (<= x 1317))
            (swNumberLevel3Q2 w)] 

        [(and (string=? (world-scene w) "numberLevel3Q1") ; number level 3 Q1 wrong answer
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 425)
            (>= x 863)   
            (<= x 1052))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "numberLevel3Q1") ; number level 3 Q1 wrong answer
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 604)   
            (<= x 797))
            (wrongAnswer w)]      
 
        [(and (string=? (world-scene w) "numberLevel3Q2") ; number level 3 Q2 correct answer (middle)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 425)
            (>= x 863)   
            (<= x 1052))
            (swNumberLevel3Q3 w)]

        [(and (string=? (world-scene w) "numberLevel3Q2") ; number level 3 Q2 wrong answer (left)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 604)   
            (<= x 797))
            (wrongAnswer w)]    

        [(and (string=? (world-scene w) "numberLevel3Q2") ; number level 3 Q2 wrong answer (right)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 426)
            (>= x 1123)   
            (<= x 1317))
            (wrongAnswer w)]  

        [(and (string=? (world-scene w) "numberLevel3Q3") ; number level 3 Q3 correct answer (middle)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 425)
            (>= x 863)   
            (<= x 1052))
            (swNumberLevel3Q4 w)]

        [(and (string=? (world-scene w) "numberLevel3Q3") ; number level 3 Q3 wrong answer (left)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 604)   
            (<= x 797))
            (wrongAnswer w)] 

        [(and (string=? (world-scene w) "numberLevel3Q3") ; number level 3 Q3 wrong answer (right)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 1123)   
            (<= x 1317))
            (wrongAnswer w)]   

        [(and (string=? (world-scene w) "numberLevel3Q4") ; number level 3 Q4 wrong answer (left)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 604)   
            (<= x 797))
            (wrongAnswer w)]  

        [(and (string=? (world-scene w) "numberLevel3Q4") ; number level 3 Q4 wrong answer (middle)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 425)
            (>= x 863)   
            (<= x 1052))
            (wrongAnswer w)]

        [(and (string=? (world-scene w) "numberLevel3Q4") ; number level 3 Q4 correct answer (right)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 1123)   
            (<= x 1317))
            (swNumberLevel3Q5 w)]  

        [(and (string=? (world-scene w) "numberLevel3Q5") ; number level 3 Q5 correct answer (right)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 1123)   
            (<= x 1317))
            (swNumberLevel3Score w)]  

         [(and (string=? (world-scene w) "numberLevel3Q5") ; number level 3 Q5 wrong answer (middle)
            (mouse=? me "button-down")
            (<= y 587) 
            (>= y 425)
            (>= x 863)   
            (<= x 1052))
            (wrongAnswer w)]  

        [(and (string=? (world-scene w) "numberLevel3Q5") ; number level 3 Q5 wrong answer (left)
            (mouse=? me "button-down")
            (<= y 588) 
            (>= y 425)
            (>= x 604)   
            (<= x 797))
            (wrongAnswer w)]  

        [(and (string=? (world-scene w) "numberLevel3Score") ; number level 3 score board (next button)
            (mouse=? me "button-down")
            (<= y 1019) 
            (>= y 914)
            (>= x 1026)   
            (<= x 1396))
            (cLobby w)]  

        [(and (string=? (world-scene w) "numberLevel3Score") ; number level 3 score board (exit button)
            (mouse=? me "button-down")
            (<= y 1014) 
            (>= y 910)
            (>= x 585)   
            (<= x 952))
            (swNumberLobbyL3 w)]  

[else w]))

;test
 

;=======================================================================================
;********************************** Tutorial *******************************************
;=======================================================================================

;Purpose; Draws The Tutorial scenes
;Contract: drawTutorial: world(w) --> image
(define (drawTutorial w)
    (cond 

        [(string=? (world-scene w) "tutorialPopUp") 
        (place-image tutorialPopUpBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "tutorialMovement")
         (place-image (skinUpdater (Character-skin (world-character w))) 
               (ChPos-x (Character-pos (world-character w))) 
               (ChPos-y (Character-pos (world-character w))) 
                tutorialMovementBg)]

        [(string=? (world-scene w) "circleTutorial") 
        (place-image circleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "cSunTutorial") 
        (place-image cSunTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "cBallTutorial") 
        (place-image cBallTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "cTireTutorial") 
        (place-image cTireTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "cManyOtherPlacesTutorial") 
        (place-image cManyOtherPlacesBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "squareTutorial") 
        (place-image squareTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "sPizzaBoxTutorial")
        (place-image sPizzaBoxTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "sWaffleTutorial")
        (place-image sWaffleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "sTostTutorial")
        (place-image sTostTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "sManyOtherPlacesTutorial")
        (place-image sManyOtherPlacesBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "triangleTutorial")
        (place-image triangleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "tBirthdayHatTutorial")
        (place-image tBirthdayHatTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "tSandwhichTutorial")
        (place-image tSandwhichTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "tSailingBoatTutorial")
        (place-image tSailingBoatTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "tManyOtherPlacesTutorial")
        (place-image tManyOtherPlacesBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "rectangleTutorial")
        (place-image rectangleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "rBookTutorial")
        (place-image rBookTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "rPuzzleTutorial")
        (place-image rPuzzleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "rDoorTutorial")
        (place-image rDoorTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "rManyOtherPlacesTutorial")
        (place-image rManyOtherPlacesBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "pentagonTutorial")
        (place-image pentagonTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "pGemTutorial")
        (place-image pGemTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "pDogHouseTutorial")
        (place-image pDogHouseTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "pClockTutorial")
        (place-image pClockTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "pManyOtherPlacesTutorial")
        (place-image pManyOtherPlacesBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "redTutorial")
        (place-image redTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "redStrawberry")
        (place-image redStrawberryBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "redSign2")
        (place-image redSign2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "redEverything")
        (place-image redEverythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "orangeTutorial")
        (place-image orangeTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "orangeBasketBall")
        (place-image orangeBasketBallBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "orangeCarrot")
        (place-image orangeCarrotBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
         [(string=? (world-scene w) "orangeEvrything")
        (place-image orangeEvrythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "yellowTutorial")
        (place-image yellowTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "yellowBanana")
        (place-image yellowBananaBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "yellowTennisBall")
        (place-image yellowTennisBallBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "yellowEvrything")
        (place-image yellowEvrythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
          [(string=? (world-scene w) "greenTutorial")
        (place-image greenTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "greenPear")
        (place-image greenPearBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [(string=? (world-scene w) "greenJuice2")
        (place-image greenJuice2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "greenEvrything")
        (place-image greenEvrythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "blueTutorial")
        (place-image blueTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "blueBalloon2")
        (place-image blueBalloon2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
         [(string=? (world-scene w) "blueFlag2")
        (place-image blueFlag2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "blueEvrything")
        (place-image blueEvrythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "purpleTutorial")
        (place-image purpleTutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "purpleEggplant")
        (place-image purpleEggplantBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
    
        [(string=? (world-scene w) "purpleOctopuse2")
        (place-image purpleOctopuse2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "purpleEvrything")
        (place-image purpleEvrythingBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb1Tutorial")
        (place-image numb1TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb1Count")
        (place-image numb1CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb2Tutorial")
        (place-image numb2TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb2Count")
        (place-image numb2CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb3Tutorial")
        (place-image numb3TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb3Count")
        (place-image numb3CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb4Tutorial")
        (place-image numb4TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb4Count")
        (place-image numb4CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb5Tutorial")
        (place-image numb5TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb5Count")
        (place-image numb5CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb6Tutorial")
        (place-image numb6TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb6Count")
        (place-image numb6CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb7Tutorial")
        (place-image numb7TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb7Count")
        (place-image numb7CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb8Tutorial")
        (place-image numb8TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb8Count")
        (place-image numb8CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb9Tutorial")
        (place-image numb9TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb9Count")
        (place-image numb9CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb10Tutorial")
        (place-image numb10TutorialBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
        
        [(string=? (world-scene w) "numb10Count")
        (place-image numb10CountBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

        [else (empty-scene 1920 1080)]))

;test


;Purpose: changes the tutorial scene when time for the next scene
;Contract: changeTutorialScene: world --> world
;function
(define (changeTutorialScene world)
    (cond 
        [(and (= (world-t world) 45) (string=? (world-scene world) "circleTutorial")) (swCSunTutorial world)]
        [(and (= (world-t world) 80) (string=? (world-scene world) "cSunTutorial")) (swCBallTutorial world)]
        [(and (= (world-t world) 100) (string=? (world-scene world) "cBallTutorial")) (swCTireTutorial world)]
        [(and (= (world-t world) 120) (string=? (world-scene world) "cTireTutorial")) (swCManyOtherPlacesTutorial world)]
        [(and (= (world-t world) 160) (string=? (world-scene world) "cManyOtherPlacesTutorial")) (swSquareTutorial world)]
        [(and (= (world-t world) 200) (string=? (world-scene world) "squareTutorial")) (swSPizzaBoxTutorial world)]
        [(and (= (world-t world) 230) (string=? (world-scene world) "sPizzaBoxTutorial")) (swSWaffleTutorial world)]
        [(and (= (world-t world) 260) (string=? (world-scene world) "sWaffleTutorial")) (swSTostTutorial world)]
        [(and (= (world-t world) 280) (string=? (world-scene world) "sTostTutorial")) (swSManyOtherPlacesTutorial world)]
        [(and (= (world-t world) 320) (string=? (world-scene world) "sManyOtherPlacesTutorial")) (swTriangleTutorial world)]
        [(and (= (world-t world) 360) (string=? (world-scene world) "triangleTutorial")) (swTBirthdayHatTutorial world)]
        [(and (= (world-t world) 390) (string=? (world-scene world) "tBirthdayHatTutorial")) (swTSandwhichTutorial world)]
        [(and (= (world-t world) 450) (string=? (world-scene world) "tSandwhichTutorial")) (swTSailingBoatTutorial world)]
        [(and (= (world-t world) 490) (string=? (world-scene world) "tSailingBoatTutorial")) (swTManyOtherPlacesTutorial world)]
        [(and (= (world-t world) 540) (string=? (world-scene world) "tManyOtherPlacesTutorial")) (swRectangleTutorial world)]
        [(and (= (world-t world) 590) (string=? (world-scene world) "rectangleTutorial")) (swRBookTutorial world)]
        [(and (= (world-t world) 620) (string=? (world-scene world) "rBookTutorial")) (swRPuzzleTutorial world)]
        [(and (= (world-t world) 660) (string=? (world-scene world) "rPuzzleTutorial")) (swRDoorTutorial world)]
        [(and (= (world-t world) 685) (string=? (world-scene world) "rDoorTutorial")) (swRManyOtherPlacesTutorial world)]
        [(and (= (world-t world) 710) (string=? (world-scene world) "rManyOtherPlacesTutorial")) (swPentagonTutorial world)]
        [(and (= (world-t world) 760) (string=? (world-scene world) "pentagonTutorial")) (swPGemTutorial world)]
        [(and (= (world-t world) 790) (string=? (world-scene world) "pGemTutorial")) (swPDogHouseTutorial world)]
        [(and (= (world-t world) 820) (string=? (world-scene world) "pDogHouseTutorial")) (swPClockTutorial world)]
        [(and (= (world-t world) 860) (string=? (world-scene world) "pClockTutorial")) (swPManyOtherPlacesTutorial world)]
        [(and (= (world-t world) 900) (string=? (world-scene world) "pManyOtherPlacesTutorial")) (swRedTutorial world)]

        [(and (= (world-t world) 80) (string=? (world-scene world) "redTutorial")) (swRedStrawberry world)]
        [(and (= (world-t world) 120) (string=? (world-scene world) "redStrawberry")) (swRedSign2 world)]
        [(and (= (world-t world) 160) (string=? (world-scene world) "redSign2")) (swRedEverything world)]
        [(and (= (world-t world) 200) (string=? (world-scene world) "redEverything")) (swOrangeTutorial world)]
        [(and (= (world-t world) 280) (string=? (world-scene world) "orangeTutorial")) (swOrangeBasketBall world)]
        [(and (= (world-t world) 360) (string=? (world-scene world) "orangeBasketBall")) (swOrangeCarrot world)]



        


        [else world]))

;Purpose: keeps track of time in ticks in tutorial scene
;contract: addTime: world --> world
;function
(define (addTime world)
        (changeTutorialScene (make-world (world-scene world) 
                                (make-Character (make-skin (skin-name (Character-skin (world-character world))) (skin-direction (Character-skin (world-character world))))
                                                (make-ChPos (ChPos-x (Character-pos (world-character world))) (ChPos-y (Character-pos (world-character world)))) 
                                                (Character-stepCount (world-character world))) 
                                                (add1 (world-t world)))))





;=======================================================================================
;***************************** Drawing World + big-bang ********************************
;=======================================================================================

;Purpose: Draws The World
;Contract: drawWorld: world(w) --> image
;function
(define (drawWorld world)
  (cond 
        
        [(string=? (world-scene world) "menu") 
                    drawMenu]
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

        [(or (string=? (world-scene world) "tutorialPopUp") (string=? (world-scene world) "tutorialMovement") (string=? (world-scene world) "circleTutorial")
             (string=? (world-scene world) "cSunTutorial") (string=? (world-scene world) "cBallTutorial") (string=? (world-scene world) "cTireTutorial") 
             (string=? (world-scene world) "cManyOtherPlacesTutorial") (string=? (world-scene world) "squareTutorial") (string=? (world-scene world)"sPizzaBoxTutorial")
             (string=? (world-scene world)"sWaffleTutorial") (string=? (world-scene world)"sTostTutorial") (string=? (world-scene world)"sManyOtherPlacesTutorial")
             (string=? (world-scene world)"triangleTutorial") (string=? (world-scene world) "tBirthdayHatTutorial") (string=? (world-scene world) "tSandwhichTutorial")
             (string=? (world-scene world) "tSailingBoatTutorial") (string=? (world-scene world) "tManyOtherPlacesTutorial") (string=? (world-scene world) "rectangleTutorial")
             (string=? (world-scene world) "rBookTutorial") (string=? (world-scene world) "rPuzzleTutorial") (string=? (world-scene world) "rDoorTutorial") 
             (string=? (world-scene world) "rManyOtherPlacesTutorial") (string=? (world-scene world) "pentagonTutorial") (string=? (world-scene world) "pGemTutorial")
             (string=? (world-scene world) "pDogHouseTutorial") (string=? (world-scene world) "pClockTutorial") (string=? (world-scene world) "pManyOtherPlacesTutorial")
             (string=? (world-scene world) "redTutorial") (string=? (world-scene world) "redStrawberry") (string=? (world-scene world) "redSign2") 
             (string=? (world-scene world) "redEverything") (string=? (world-scene world) "orangeTutorial")  (string=? (world-scene world)"orangeBasketBall") 
             (string=? (world-scene world)"orangeCarrot") (string=? (world-scene world)"orangeEvrything") (string=? (world-scene world)"yellowTutorial") 
             (string=? (world-scene world) "yellowBanana") (string=? (world-scene world) "yellowTennisBall") (string=? (world-scene world) "yellowEvrything")
             (string=? (world-scene world) "greenTutorial")  (string=? (world-scene world) "greenPear") (string=? (world-scene world) "greenJuice2")
             (string=? (world-scene world) "greenEvrything") (string=? (world-scene world) "blueTutorial") (string=? (world-scene world) "blueBalloon2")
             (string=? (world-scene world) "blueFlag2") (string=? (world-scene world) "blueEvrything") (string=? (world-scene world) "purpleTutorial")  
             (string=? (world-scene world)"purpleEggplant") (string=? (world-scene world)"purpleOctopuse2") (string=? (world-scene world)"purpleEvrything")
             (string=? (world-scene world) "numb1Tutorial") (string=? (world-scene world) "numb1Count") (string=? (world-scene world) "numb2Tutorial")
             (string=? (world-scene world) "numb2Count")  (string=? (world-scene world) "numb3Tutorial") (string=? (world-scene world) "numb3Count")
             (string=? (world-scene world) "numb4Tutorial") (string=? (world-scene world) "numb4Count") (string=? (world-scene world) "numb5Tutorial")
             (string=? (world-scene world) "numb5Count") (string=? (world-scene world) "numb6Tutorial") (string=? (world-scene world) "numb6Count")  
             (string=? (world-scene world)"numb7Tutorial") (string=? (world-scene world)"numb7Count") (string=? (world-scene world)"numb8Tutorial")
             (string=? (world-scene world) "numb8Count") (string=? (world-scene world) "numb9Tutorial") (string=? (world-scene world) "numb9Count")
             (string=? (world-scene world) "numb10Tutorial") (string=? (world-scene world) "numb10Count"))
              (drawTutorial world)]

        [(or (string=? (world-scene world) "characterInfo1")                 
             (string=? (world-scene world) "characterInfo2")
             (string=? (world-scene world) "characterInfo3")
             (string=? (world-scene world) "characterInfo4"))
                    (drawCharacterInfo world)]


        [(or (string=? (world-scene world) "shapeLobbyL1") (string=? (world-scene world) "shapeLobbyL2") (string=? (world-scene world) "shapeLobbyL3"))
                    (drawShapeLobby world)]
        
       [(or (string=? (world-scene world) "shapeLevel1Q1") (string=? (world-scene world) "shapeLevel1Q2") (string=? (world-scene world) "shapeLevel1Q3") 
            (string=? (world-scene world) "shapeLevel1Q4") (string=? (world-scene world) "shapeLevel1Q5") (string=? (world-scene world) "shapeLevel2Path1") 
            (string=? (world-scene world) "shapeLevel2Train") (string=? (world-scene world) "shapeLevel1Score5") (string=? (world-scene world) "shapeLevel3Score5")
            (string=? (world-scene world) "shapeLevel2Path1") (string=? (world-scene world) "shapeLevel2Path2") (string=? (world-scene world) "shapeLevel2Path3")
            (string=? (world-scene world) "deadEnd1") (string=? (world-scene world) "deadEnd2") (string=? (world-scene world) "deadEnd3") (string=? (world-scene world) "squareCart") (string=? (world-scene world) "circleCart") 
            (string=? (world-scene world) "triangleCart") (string=? (world-scene world) "pentagonCart") (string=? (world-scene world) "rectangleCart")
            (string=? (world-scene world) "shapeLevel2Score8") (string=? (world-scene world) "shapeLevel3") (string=? (world-scene world) "p1Rectangle")
            (string=? (world-scene world) "p2Square") (string=? (world-scene world) "p3Circle") (string=? (world-scene world) "p4Triangle") 
            (string=? (world-scene world) "p5Pentagon") (string=? (world-scene world) "shapeLevel3Q1") (string=? (world-scene world) "shapeLevel3Q2") 
            (string=? (world-scene world) "shapeLevel3Q3") (string=? (world-scene world) "shapeLevel3Q4") (string=? (world-scene world) "shapeLevel3Q5")
            (string=? (world-scene world) "shapeLevel3Score0Retry") (string=? (world-scene world) "shapeLevel3Score1Retry")  (string=? (world-scene world) "shapeLevel3Score2Retry") 
            (string=? (world-scene world) "shapeLevel3Score3Retry") (string=? (world-scene world) "shapeLevel3Score4Retry") (string=? (world-scene world) "shapeLevel3Score5Retry") 
            (string=? (world-scene world) "shapeLevel3Score6Retry") (string=? (world-scene world) "shapeLevel3Score7Retry") (string=? (world-scene world) "shapeLevel3Score8Retry") 
            (string=? (world-scene world) "shapeLevel3Score9Retry"))
                    (drawShapeLevel world)]

       [(string=? (world-scene world) "shapeElevator")
                    elevator]

       [(or (string=? (world-scene world) "colorLobbyL1") (string=? (world-scene world) "colorLobbyL2") (string=? (world-scene world) "colorLobbyL3") 
            (string=? (world-scene world) "colorLevel3KeyDoor") (string=? (world-scene world) "colorLevel3Classroom"))
                    (drawColorLobby world)]

       [(or (string=? (world-scene world) "colorLevel1Q1") (string=? (world-scene world) "colorLevel1Q2") (string=? (world-scene world) "colorLevel1Q3") 
            (string=? (world-scene world) "colorLevel1Q4")(string=? (world-scene world) "colorLevel1Q5") (string=? (world-scene world) "colorLevel2") 
            (string=? (world-scene world) "colorLevel3Q1") (string=? (world-scene world) "colorLevel3Q2") (string=? (world-scene world) "colorLevel3Q3")
            (string=? (world-scene world) "colorLevel3ItemsFull") (string=? (world-scene world) "colorLevel3Item1") (string=? (world-scene world) "colorLevel3Item2") 
            (string=? (world-scene world) "colorLevel3Item3") (string=? (world-scene world) "colorLevel3Item4") (string=? (world-scene world) "colorLevel3Item5") 
            (string=? (world-scene world) "colorLevel3Item6") (string=? (world-scene world) "colorLevel3Item7") (string=? (world-scene world) "colorLevel3Item8") 
            (string=? (world-scene world) "colorLevel3Item9") (string=? (world-scene world) "colorLevel3Item10") (string=? (world-scene world) "colorLevel3Item11") 
            (string=? (world-scene world) "colorLevel3Item12") (string=? (world-scene world) "item1") (string=? (world-scene world) "item2") 
            (string=? (world-scene world) "item3") (string=? (world-scene world) "item4") (string=? (world-scene world) "item5") 
            (string=? (world-scene world) "item6") (string=? (world-scene world) "item7") (string=? (world-scene world) "item8") 
            (string=? (world-scene world) "item9") (string=? (world-scene world) "item10") (string=? (world-scene world) "item11") 
            (string=? (world-scene world) "itemFull") (string=? (world-scene world) "item12") (string=? (world-scene world) "colorLevel2Q1") 
            (string=? (world-scene world) "colorLevel2Q2") (string=? (world-scene world) "colorLevel2Q3") (string=? (world-scene world) "colorLevel2Q4")
            (string=? (world-scene world) "colorLevel2Q5") (string=? (world-scene world) "colorLevel2Q6") (string=? (world-scene world) "colorLevel3Award"))
                    (drawColorLevel world)]

       [(string=? (world-scene world) "colorElevator")
                    elevator]

       [(or (string=? (world-scene world) "colorLevel1Score5") (string=? (world-scene world) "colorLevel2Score6") (string=? (world-scene world) "colorLevel3SubScore")
            (string=? (world-scene world) "colorLevel3Score16"))
                    (drawColorScore world)]

      [(or (string=? (world-scene world) "colorLevel2RedFrame") (string=? (world-scene world) "colorLevel2OrangeFrame") 
            (string=? (world-scene world) "colorLevel2YellowFrame") (string=? (world-scene world) "colorLevel2GreenFrame")
           (string=? (world-scene world) "colorLevel2BlueFrame") (string=? (world-scene world) "colorLevel2PurpleFrame")
           (string=? (world-scene world) "colorLevel3KeyDoor") (string=? (world-scene world) "colorLevel3Classroom")
           (string=? (world-scene world) "colorLevel3Door2"))
                        (drawColorLobby world)]


        [(or (string=? (world-scene world) "numberLobbyL1") (string=? (world-scene world) "numberLobbyL2") (string=? (world-scene world) "numberLobbyL3")
        (string=? (world-scene world) "numberLevel3Door"))
                    (drawNumberLobby world)]

        [(or (string=? (world-scene world) "numberLevel1Q1") (string=? (world-scene world) "numberLevel1Q2") (string=? (world-scene world) "numberLevel1Q3") 
            (string=? (world-scene world) "numberLevel1Q4") (string=? (world-scene world) "numberLevel1Q5") 
            
            (string=? (world-scene world) "numberLevel2Q1")
            (string=? (world-scene world) "numberLevel2Q2") (string=? (world-scene world) "numberLevel2Q3") (string=? (world-scene world) "numberLevel2Q4")
            (string=? (world-scene world) "numberLevel2Q5") (string=? (world-scene world) "numberLevel2Q6") (string=? (world-scene world) "numberLevel2Q7")
            (string=? (world-scene world) "numberLevel2Q8") (string=? (world-scene world) "numberLevel2Q9") (string=? (world-scene world) "numberLevel2Q10") 
            (string=? (world-scene world) "numberLevel2Q11") (string=? (world-scene world) "numberLevel2Car")
            
            (string=? (world-scene world) "numberLevel3Q1") (string=? (world-scene world) "numberLevel3Q2") 
            (string=? (world-scene world) "numberLevel3Q3") (string=? (world-scene world) "numberLevel3Q4") (string=? (world-scene world) "numberLevel3Q5") 
            (string=? (world-scene world) "numberLevel3Start") (string=? (world-scene world) "numberLevel3Score") (string=? (world-scene world) "numberLevel2Score10"))
                    (drawNumberLevel world)]
   
       [(string=? (world-scene world) "numberElevator")
                    elevator]
       [(string=? (world-scene world) "numberLevel1Score5")
                    (drawNumberScore world)]
       
       
        [else (empty-scene 1920 1080)]))

;test


;=======================================================================================
;********************************** Big-Bang *******************************************
;=======================================================================================

(big-bang Menu
(name "Bilgi Kids")
(on-draw drawWorld)
(on-key keyboardControl)
(on-mouse mouseRegister)
(on-tick addTime)
;(state #true) ;useful to see what is exactly going on
;(display-mode 'fullscreen) ;we need to add a quit game thing if we r going to do
)

(test)