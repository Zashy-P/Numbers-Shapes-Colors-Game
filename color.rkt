#lang racket/gui
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)
(require (only-in racket/gui/base play-sound))

;=======================================================================================
;************************************ structs ******************************************
;=======================================================================================

;World --> Scene, Character, Sound, LeaderBoard(not now later)
(define-struct world (scene character)) ;leaderBoard)) will do leaderBoard Later
;Character --> image(skin), pos(x,y)
(define-struct Character (skin pos stepCount))
(define-struct ChPos (x y))
;skin --> name direction
(define-struct skin(name direction))
;skinD --> west east south north
(define-struct skinD(west east south north))

;=======================================================================================
;************************************ Sound ********************************************
;=======================================================================================

;Path to the Button Click sound effect
(define buttonClick1Path "./buttonClick1.mp3")
(define footstepPath "./Concretefootstep.mp3")
(define footstep2Path "./Concretefootstep2.mp3")
(define footstepSounds (list footstepPath footstep2Path))
(define bellRingPath "./bellRing.wav")
(define wrongChoiceEffectPath "./wrongChoiceEffect.mp3")
(define correctAnswerEffectPath "./correctAnswerEffect.wav")

(define (playButtonClick1Sound)
  (play-sound buttonClick1Path #f))

(define (playFootstepSound x)
  (cond 
     [(= (modulo x 2) 0) (play-sound (first footstepSounds) #f)]
     [(= (modulo x 2) 1) (begin (play-sound (second footstepSounds) #f))]))


(define (playBellRingSound)
  (play-sound bellRingPath #f))

(define (playWrongChoiceEffectSound)
  (play-sound wrongChoiceEffectPath #f))

(define (playCorrectAnswerEffectSound)
  (play-sound correctAnswerEffectPath #f))  

;=======================================================================================
;************************************ Images *******************************************
;=======================================================================================
;Character skins
;abdulrahman's bitmaps

;boy skin
;(define skinBoyWest(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_left_side.png"))
;(define skinBoyEast(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy right side.png"))
;(define skinBoyNorth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_backside.png"))
;(define skinBoySouth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_frontside.png"))
;(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;Janitor skin
;(define skinJanitorWest(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor left side.png"))
;;(define skinJanitorEast(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor right side.png"))
;(define skinJanitorNorth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor backside.png"))
;(define skinJanitorSouth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor frontside.png"))
;(define janitorSkin (make-skinD skinJanitorWest skinJanitorEast skinJanitorSouth skinJanitorNorth))

;Scientist skin
;(define skinScientistWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist left side.png"))
;(define skinScientistEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist right side.png"))
;(define skinScientistNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist backside.png"))
;(define skinScientistSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist frontside.png"))
;;(define scientistSkin (make-skinD skinScientistWest skinScientistEast skinScientistSouth skinScientistNorth))

;Police woman skin
;(define skinPoliceWomanWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman leftside.png"))
;(define skinPoliceWomanEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman right side.png"))
;(define skinPoliceWomanNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman backside.png"))
;(define skinPoliceWomanSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman frontside.png"))
;(define policeWomanSkin (make-skinD skinPoliceWomanWest skinPoliceWomanEast skinPoliceWomanSouth skinPoliceWomanNorth))

;zainab's bitmaps

;boy skin
(define skinBoyWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_left_side.png"))
(define skinBoyEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy right side.png"))
(define skinBoyNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_backside.png"))
(define skinBoySouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_frontside.png"))
(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;janitor skin
(define skinJanitorWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor left side.png"))
(define skinJanitorEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor right side.png"))
(define skinJanitorNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor backside.png"))
(define skinJanitorSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor frontside.png"))
(define janitorSkin (make-skinD skinJanitorWest skinJanitorEast skinJanitorSouth skinJanitorNorth))

;Scientist skin
(define skinScientistWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist left side.png"))
(define skinScientistEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist right side.png"))
(define skinScientistNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist backside.png"))
(define skinScientistSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist frontside.png"))
(define scientistSkin (make-skinD skinScientistWest skinScientistEast skinScientistSouth skinScientistNorth))

;Police woman skin
(define skinPoliceWomanWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman leftside.png"))
(define skinPoliceWomanEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman right side.png"))
(define skinPoliceWomanNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman backside.png"))
(define skinPoliceWomanSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman frontside.png"))
(define policeWomanSkin (make-skinD skinPoliceWomanWest skinPoliceWomanEast skinPoliceWomanSouth skinPoliceWomanNorth))

;maysam's bitmaps

;boy skin
;(define skinBoyWest (bitmap ""))
;(define skinBoyEast (bitmap ""))
;(define skinBoyNorth (bitmap ""))
;(define skinBoySouth (bitmap ""))
;(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;janitor skin
;(define skinJanitorWest (bitmap ""))
;(define skinJanitorEast (bitmap ""))
;(define skinJanitorNorth (bitmap ""))
;(define skinJanitorSouth (bitmap ""))

;Scientist skin
;(define skinScientistWest (bitmap ""))
;(define skinScientistEast (bitmap ""))
;(define skinScientistNorth (bitmap ""))
;(define skinScientistSouth (bitmap ""))

;Police woman skin
;(define skinPoliceWomantWest (bitmap ""))
;(define skinPoliceWomantEast (bitmap ""))
;(define skinPoliceWomantNorth (bitmap ""))
;(define skinPoliceWomantSouth (bitmap ""))

;Backgrounds just comment others bitmap and uncomment yours

;abdulrahman's bitmap

;Menu Background 
;(define menuBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/backgrounds/Final menu background.jpg")) 

;Character Select Backgrounds
;(define chSelectBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 1.jpeg")) 
;(define chSelect2Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 2.jpeg"))
;(define chSelect3Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 3.jpeg"))
;(define chSelect4Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/charcater select  4.jpeg"))

;Tutorial Pop Up Background
;(define tutorialPopUpBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/tutorial pop up with background.jpg")) 

;Tutorial Background
;(define tutorialBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/tutorial pop up with background.jpg")) 

;Lobby Background
;(define lobbyBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Lobby Background.jpg")) 

;ShapeLobby 
;(define shapeLobbyL1Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/shapes lobby level 1.jpg"))
;(define shapeLobbyL2Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/shapes lobby level 2.jpg"))
;(define shapeLobbyL3Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/shapes lobby level 3.jpg"))
;(define shapeLevel1Q1Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/level 1/question 1.jpg"))
;(define shapeLevel1Q2Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/level 1/question 2.jpg"))
;(define shapeLevel1Q3Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/level 1/question 3.jpg"))
;(define shapeLevel1Q4Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Shapes/level 1/question 4.jpg"))

;(define shapeLevel2Bg (empty-scene 1920 1080))

;(define shapeLevel3Bg (empty-scene 1920 1080))

;NumberLobby 
;(define numberLobbyBg (empty-scene 1920 1080))


;ColorLobby 
;(define colorLobbyL1Bg (bitmap ""))
;(define colorLobbyL2Bg (bitmap ""))
;(define colorLobbyL3Bg (bitmap ""))
;(define colorLevel1Q1Bg (bitmap ""))
;(define colorLevel1Q2Bg (bitmap ""))
;(define colorLevel1Q3Bg (bitmap ""))
;(define colorLevel1Q4Bg (bitmap ))

;(define colorLevel2Bg (empty-scene 1920 1080))

;(define colorLevel3Bg (empty-scene 1920 1080))


;Elevator Background
;(define ElevatorBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/elevator.jpg"))


;zainab's bitmap

;Menu Background
(define menuBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/backgrounds/Final menu background.jpg")) 
(define chSelect2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 2.jpeg"))
(define chSelect3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 3.jpeg"))
(define chSelect4Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/charcater select  4.jpeg"))

;Character Select Background
(define chSelectBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 1.jpeg")) 

;Tutorial Pop Up Background
(define tutorialPopUpBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/tutorial pop up with background.jpg"))

;Tutorial Background
(define tutorialBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/tutorial pop up with background.jpg"))

;Lobby Background
(define lobbyBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Lobby Background.jpg"))

;Elevator Background
(define ElevatorBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/elevator.jpg"))


;ColorLobby 
(define colorLobbyL1Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/colors level 1.jpg"))
(define colorLobbyL2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/colors level 2.jpg"))
(define colorLobbyL3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/colors level 3.jpg"))

(define colorLevel1Q1Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/question 1.jpg"))
(define colorLevel1Q2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/question 2.jpg"))
(define colorLevel1Q3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/question 3.jpg"))
(define colorLevel1Q4Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/question 4.jpg"))
(define colorLevel1Q5Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/question 5.jpg"))

(define colorLevel1Score5Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 1/scores/score 5.jpg"))


(define colorLevel2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Colors/level 2/0 start.jpg"))
;(define colorLevel2GameBg (bitmap ""))
;(define colorLevel2RedSquare (bitmap ""))
;(define colorLevel2OrangeSquare (bitmap ""))
;(define colorLevel2YellowSquare (bitmap ""))
;(define colorLevel2GreenSquare (bitmap ""))
;(define colorLevel2BlueSquare (bitmap ""))
;(define colorLevel2PurpleSquare (bitmap ""))


(define colorLevel3Bg (empty-scene 1920 1080))

;ShapeLobby 
(define shapeLobbyL1Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/shapes lobby level 1.jpg"))
(define shapeLobbyL2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/shapes lobby level 2.jpg"))
(define shapeLobbyL3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/shapes lobby level 3.jpg"))

(define shapeLevel1Q1Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/level 1/question 1.jpg"))
(define shapeLevel1Q2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/level 1/question 2.jpg"))
(define shapeLevel1Q3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/level 1/question 3.jpg"))
(define shapeLevel1Q4Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Shapes/level 1/question 4.jpg"))

(define shapeLevel2Bg (empty-scene 1920 1080))


(define shapeLevel3Bg (empty-scene 1920 1080))


;NumberLobby 
(define numberLobbyBg (empty-scene 1920 1080))



;maysam's bitmap

;Menu Background 
;(define menuBg (bitmap "")) 

;Character Select Background
;(define chSelectBg (bitmap ""))
;(deafine chSelect2Bg (bitmap ""))
;(define chSelect3Bg (bitmap ""))
;(define chSelect4Bg (bitmap ""))

;Tutorial Pop Up Background
;(define tutorialPopUpBg (bitmap ""))

;Tutorial Background
;(define tutorialBg (bitmap ""))

;Lobby Background
;(define lobbyBg (bitmap ""))

;ShapeLobby (Lobby is scene one) Background
;(define shapeLobbyL1Bg (empty-scene 1920 1080))
;(define shapeLevel1Q1Bg (empty-scene 1920 1080))

;Elevator Background
;(define ElevatorBg (bitmap ""))

;ColorLobby 
;(define colorLobbyL1Bg (bitmap ""))
;(define colorLobbyL2Bg (bitmap ""))
;(define colorLobbyL3Bg (bitmap ""))
;(define colorLevel1Q1Bg (bitmap ""))
;(define colorLevel1Q2Bg (bitmap ""))
;(define colorLevel1Q3Bg (bitmap ""))
;(define colorLevel1Q4Bg (bitmap ))

;(define colorLevel2Bg (empty-scene 1920 1080))

;(define colorLevel3Bg (empty-scene 1920 1080))


;NumberLobby (Lobby is scene one) Background
;(define numberLobbyBg (empty-scene 1920 1080))




; pixel character
;for getting x,y position of stuff (Testing Purposes)
;(define skinBoyWest (line 0 2 "red"))
;(define skinBoyEast (line 0 2 "red"))
;(define skinBoyNorth (line 0 2 "red"))
;(define skinBoySouth (line 0 2 "red"))


;world's center width and height
(define worldCenterWidth 960)
(define worldCenterHeight 540)

;lobby's center width and height
(define lobbyCenterWidth 1010)
(define lobbyCenterHeight 700)

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================

;Purpose: Draws the menu 
;Contract: menu --> image
(define menu    
  (place-image menuBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))



; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))

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
;************************************ Shape Game ***************************************
;=======================================================================================
;Purpose: Draws The lobbies of the shape game
;Contract: drawShapeLobby: world --> image
(define (drawShapeLobby world) 
     (cond
          [(string=? (world-scene world) "shapeLobbyL1")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
           -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                              (ChPos-x (Character-pos (world-character world))) 
                                              (ChPos-y (Character-pos (world-character world)))
                                              shapeLobbyL1Bg)]
          [(string=? (world-scene world) "shapeLobbyL2")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeLobbyL2Bg)]   
          [(string=? (world-scene world) "shapeLobbyL3")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
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

          [(string=? (world-scene world) "shapeLevel2")
          (place-image shapeLevel2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "shapeLevel3")
          (place-image shapeLevel3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]))

;Elevator image basically 
(define elevator    
  (place-image ElevatorBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

(define (swShapeLobbyL1 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLobbyL2 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLobbyL3 w) (begin (thread playBellRingSound) (make-world "shapeLobbyL3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swShapeLevel1 w) (begin (thread playBellRingSound) (make-world "shapeLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLevel2 w) (begin (thread playBellRingSound) (make-world "shapeLevel2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLevel3 w) (begin (thread playBellRingSound) (make-world "shapeLevel3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swShapeElevator w) (begin (thread playBellRingSound) (make-world "shapeElevator" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swShapeLevel1Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLevel1Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swShapeLevel1Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "shapeLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

;Purpose: plays the wrong answer sound effect and returns the world to the same question
;Contract: wrongAnswer: world --> world
(define (wrongAnswer w)
     (cond
     [(string=? (world-scene w) "shapeLevel1Q1") (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "shapeLevel1Q2") (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "shapeLevel1Q3") (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "shapeLevel1Q4") (begin (thread playWrongChoiceEffectSound) (make-world "shapeLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "colorLevel1Q1") (begin (thread playWrongChoiceEffectSound) (make-world "colorLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "colorLevel1Q2") (begin (thread playWrongChoiceEffectSound) (make-world "colorLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "colorLevel1Q3") (begin (thread playWrongChoiceEffectSound) (make-world "colorLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "colorLevel1Q4") (begin (thread playWrongChoiceEffectSound) (make-world "colorLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]
     [(string=? (world-scene w) "colorLevel1Q5") (begin (thread playWrongChoiceEffectSound) (make-world "colorLevel1Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0)))]))
;test


;=======================================================================================
;************************************ Color Game ***************************************
;=======================================================================================
;purpose: draw the lobbies/levels of the color game
;contract: drawColorLobby: world --> image
;test

(define (drawColorLobby world) 
     (cond
          [(string=? (world-scene world) "colorLobbyL1")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  
             #f 'modern 'italic 'normal #f)
           -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                              (ChPos-x (Character-pos (world-character world))) 
                                              (ChPos-y (Character-pos (world-character world)))
                                              colorLobbyL1Bg)]

          [(string=? (world-scene world) "colorLobbyL2")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLobbyL2Bg)]   
                                         
          [(string=? (world-scene world) "colorLobbyL3")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLobbyL3Bg)]))
(define (drawColorScore world)
      (cond
          [(string=? (world-scene world) "colorLevel1Score5")
          (place-image colorLevel1Score5Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          
         ))
;test

;Purpose: Draws The Levels of the Color game 
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
       
          [(string=? (world-scene world) "colorLevel2")
          (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         colorLevel2Bg)]

          [(string=? (world-scene world) "colorLevel3")
          (place-image colorLevel3Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]

          ;[(string=? (world-scene world) "colorLevel2Game")
          ;[(string=? (world-scene world) "colorLevel2RedSquare")
          ;(place-image colorLevel2RedSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ;[(string=? (world-scene world) "colorLevel2OrangeSquare")
          ;(place-image colorLevel2OrangeSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ;[(string=? (world-scene world) "colorLevel2YellowSquare")
          ;(place-image colorLevel2YellowSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ;[(string=? (world-scene world) "colorLevel2GreenSquare")
          ;(place-image colorLevel2GreenSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ;[(string=? (world-scene world) "colorLevel2BlueSquare")
          ;(place-image colorLevel2BlueSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ;[(string=? (world-scene world) "colorLevel2PurpleSquare")
          ;(place-image colorLevel2PurpleSquare worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          ))
          


(define (swColorLobbyL1 w) (begin (thread playBellRingSound) (make-world "colorLobbyL1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLobbyL2 w) (begin (thread playBellRingSound) (make-world "colorLobbyL2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLobbyL3 w) (begin (thread playBellRingSound) (make-world "colorLobbyL3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swColorLevel1 w) (begin (thread playBellRingSound) (make-world "colorLevel1Q1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLevel2 w) (begin (thread playBellRingSound) (make-world "colorLevel2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLevel3 w) (begin (thread playBellRingSound) (make-world "colorLevel3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swColorElevator w) (begin (thread playBellRingSound) (make-world "colorElevator" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swColorLevel1Q2 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q2" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLevel1Q3 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q3" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLevel1Q4 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q4" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
(define (swColorLevel1Q5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Q5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (swColorLevel1Score5 w) (begin (thread playCorrectAnswerEffectSound) (make-world "colorLevel1Score5" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

;change sound effecta
;(define (swColorLevel2Game w) (begin (thread playBellRingSound) (make-world "colorLevel2Game" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2RedSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2RedSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2OrangeSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2OrangeSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2YellowSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2YellowSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2GreenSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2GreenSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2BlueSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2BlueSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))
;(define (swColorLevel2PurpleSquare w) (begin (thread playBellRingSound) (make-world "colorLevel2PurpleSquare" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up") (make-ChPos 960 890) 0))))

(define (drawColorLevel2 world)
     (cond
          [(string=? (world-scene world) "colorLevel2")
          (place-image  colorLevel2Bg worldCenterWidth worldCenterHeight (empty-scene 1920 1080))]
          [(string=? (world-scene world) "redFrameClicked")
          (overlay/xy (rectangle 100 100 "solid" "red") 1125 988) colorLevel2Bg]
          
          [else world]))

(define (mouseColor world x y)
     (cond
          [(string=? (world-scene world) "colorLevel2")
          (cond
               [(and (= x 712) (= y 951))
                    (make-world "redFramedClicked" (world-character world))]
                    [else world])]
          [else world]))

(define (mouseLevel2 world x y)
     (cond 
          [(string=? (world-scene world) "colorLevel2")
          (cond
               [(and (= x 712) (= y 951))
                    (make-world "redFramedClicked" (world-character world))]
               [else world])]
          [else world]))



;=======================================================================================
;************************************ Number Game **************************************
;=======================================================================================

(define (drawNumberLobby world) (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         numberLobbyBg))

(define (swNumber w) (begin (thread playBellRingSound) (make-world "numberLobby" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left") (make-ChPos worldCenterWidth worldCenterHeight) 0))))



;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================

;defines character speed
(define ChSpeed 10)

;Purpose: Draws the Character in the Lobby
;Contract: drawLobby: world --> image
(define (drawLobby world) (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
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
        (skinD-north policeWomanSkin)] ))


;x,y coordinates of the doors 

;shape door y coordinates 700(bottom) 670(top)
;shape door x coordinates 420(left) 370(right)
;shape elevator y coordinates 850(bottom) 390(top)
;shape elevator x coordinates 130(left) 340(right)
;shape level 1 door y coordinates 630(bottom) 290(top)
;shape level 1 door x coordinates 820 (left) 1110(right)


;color door y coordinates 710(bottom) 660(top)
;color door x coordinates 1530(left) 1550(right)

;number door y coordinates 300(bottom) 300(top)
;number door x coordinates 1060 (left) 1140(right)




;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: keyboardControl: world(w), keyboard-input(ki) --> image
;function
(define (keyboardControl w ki)
  (if (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorial") (string=? (world-scene w) "shapeLobbyL1") (string=? (world-scene w) "shapeLobbyL2") (string=? (world-scene w) "shapeLobbyL3") (string=? (world-scene w) "colorLobbyL1") (string=? (world-scene w) "colorLobbyL2") (string=? (world-scene w) "colorLobbyL3") (string=? (world-scene w) "colorLevel2") (string=? (world-scene w) "numberLobby"))                                          
    (cond                                       

     [(and (string=? (world-scene w) "Lobby") ;Shape Door
      (and (<= (ChPos-y (Character-pos (world-character w))) 700)
             (>= (ChPos-y (Character-pos (world-character w))) 670))
      (and (>= (ChPos-x (Character-pos (world-character w))) 370)
             (<= (ChPos-x (Character-pos (world-character w))) 420))) 
             (swShapeLobbyL1 w)]
          
         [(and (or (string=? (world-scene w) "shapeLobbyL1") (string=? (world-scene w) "shapeLobbyL2") (string=? (world-scene w) "shapeLobbyL3")) ;Shape elevator
      (and (<= (ChPos-y (Character-pos (world-character w))) 850)
             (>= (ChPos-y (Character-pos (world-character w))) 390))
      (and (>= (ChPos-x (Character-pos (world-character w))) 130)
             (<= (ChPos-x (Character-pos (world-character w))) 340))) 
             (swShapeElevator w)]

     [(and (string=? (world-scene w) "shapeLobbyL1") ;Shape Level 1 door
      (and (<= (ChPos-y (Character-pos (world-character w))) 630)
             (>= (ChPos-y (Character-pos (world-character w))) 290))
      (and (>= (ChPos-x (Character-pos (world-character w))) 820)
             (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
             (swShapeLevel1 w)]

     [(and (string=? (world-scene w) "shapeLobbyL2") ;Shape Level 2 door
      (and (<= (ChPos-y (Character-pos (world-character w))) 630)
             (>= (ChPos-y (Character-pos (world-character w))) 290))
      (and (>= (ChPos-x (Character-pos (world-character w))) 820)
             (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
             (swShapeLevel2 w)]

     [(and (string=? (world-scene w) "shapeLobbyL3") ;Shape Level 3 door
      (and (<= (ChPos-y (Character-pos (world-character w))) 630)
          (>= (ChPos-y (Character-pos (world-character w))) 290))
      (and (>= (ChPos-x (Character-pos (world-character w))) 820)
             (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
             (swShapeLevel3 w)]



     [(and (string=? (world-scene w) "Lobby") ;Color Door
       (and (<= (ChPos-y (Character-pos (world-character w))) 710)
            (>= (ChPos-y (Character-pos (world-character w))) 660))
       (and (>= (ChPos-x (Character-pos (world-character w))) 1530)
            (<= (ChPos-x (Character-pos (world-character w))) 1550))) 
            (swColorLobbyL1 w)]

     [(and (or (string=? (world-scene w) "colorLobbyL1") (string=? (world-scene w) "colorLobbyL2") (string=? (world-scene w) "colorLobbyL3")) ;color elevator
     (and (<= (ChPos-y (Character-pos (world-character w))) 850)
          (>= (ChPos-y (Character-pos (world-character w))) 390))
     (and (>= (ChPos-x (Character-pos (world-character w))) 130)
          (<= (ChPos-x (Character-pos (world-character w))) 340))) 
          (swColorElevator w)]

     [(and (string=? (world-scene w) "colorLobbyL1") ;color Level 1 door
     (and (<= (ChPos-y (Character-pos (world-character w))) 630)
          (>= (ChPos-y (Character-pos (world-character w))) 290))
     (and (>= (ChPos-x (Character-pos (world-character w))) 820)
          (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
          (swColorLevel1 w)]

     [(and (string=? (world-scene w) "colorLobbyL2") ;color Level 2 door
     (and (<= (ChPos-y (Character-pos (world-character w))) 630)
          (>= (ChPos-y (Character-pos (world-character w))) 290))
     (and (>= (ChPos-x (Character-pos (world-character w))) 820)
          (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
          (swColorLevel2 w)]

     [(and (string=? (world-scene w) "colorLobbyL3") ;color Level 3 door
          (and (<= (ChPos-y (Character-pos (world-character w))) 630)
               (>= (ChPos-y (Character-pos (world-character w))) 290))
          (and (>= (ChPos-x (Character-pos (world-character w))) 820)
               (<= (ChPos-x (Character-pos (world-character w))) 1110))) 
               (swColorLevel3 w)]

     [(and (string=? (world-scene w) "Lobby") ;Number Door
          (and (<= (ChPos-y (Character-pos (world-character w))) 300)
               (>= (ChPos-y (Character-pos (world-character w))) 300))
          (and (>= (ChPos-x (Character-pos (world-character w))) 1060)
               (<= (ChPos-x (Character-pos (world-character w))) 1140))) 
               (swNumber w)]


     [(or (key=? ki "left") (key=? ki "a")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left") 
                               (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                           (ChPos-y (Character-pos (world-character w)))) 
                                           (+ (Character-stepCount (world-character w)) 1))))]

     [(or (key=? ki "right") (key=? ki "d"))
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right")  
                               (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                           (ChPos-y (Character-pos (world-character w))))
                                           (+ (Character-stepCount (world-character w)) 1))))]

     [(or (key=? ki "up") (key=? ki "w")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) (* ChSpeed -1)))
                                           (+ (Character-stepCount (world-character w)) 1))))]

     [(or (key=? ki "down") (key=? ki "s")) 
          (begin 
          (thread (lambda () (playFootstepSound (Character-stepCount (world-character w)))))
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "down")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) ChSpeed))
                                           (+ (Character-stepCount (world-character w)) 1))))]
               
        [else w]
        
    )w))


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

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================

;defines the character select scene once clicked
(define (cChSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))))

;defines the Lobby scene once clicked 
(define (cLobby world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "Lobby" (make-Character (make-skin "janitor" "down") (make-ChPos lobbyCenterWidth lobbyCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "boy" "down") (make-ChPos lobbyCenterWidth lobbyCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "scientist" "down") (make-ChPos lobbyCenterWidth lobbyCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "policeWoman" "down") (make-ChPos lobbyCenterWidth lobbyCenterHeight) 0)))]
        [else world]))

;defines the tutorial pop up scene once confirm on chSelect is clicked
(define (cTutorialPopUp world)
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
         [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [else world]))

;defines the tutorial scene once yes on tutorial pop up is clicked
(define (cTutorial world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0)))]
        [else world]))

;makes the skin boy once clicked
(define (cBoySelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))))

;makes the skin janitor once clicked
(define (cJanitorSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect2" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))))

;makes the skin janitor once clicked
(define (cScientistSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect3" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))))

;makes the skin janitor once clicked
(define (cPoliceWomanSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect4" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))))

;Coordinates of the buttons

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

;Elevator Level 1 button y-axis start from 453(bottom) to 419(top)
;Elevator Level 1 button x-axis start from 1443(left) to 1480(right)
;Elevator Level 2 button y-axis start from 505(bottom) to 471(top)
;Elevator Level 2 button x-axis start from 1443(left) to 1480(right)
;Elevator Level 3 button y-axis start from 556(bottom) to 522(top)
;Elevator Level 3 button x-axis start from 1443(left) to 1480(right)

;Shape, Color, and Number Level 1 topLeft question button y-axis start from 808(bottom) to 663(top)
;Shape, Color, and Number Level 1 topLeft question button x-axis start from 357(left) to 855(right)
;Shape, Color, and Number Level 1 bottomLeft question button y-axis start from 990(bottom) to 844(top)
;Shape, Color, and Number Level 1 bottomLeft question button x-axis start from 357(left) to 855(right)
;Shape, Color, and Number Level 1 topRight question button y-axis start from 808(bottom) to 663(top)
;Shape, Color, and Number Level 1 topRight question button x-axis start from 1067(left) to 1564(right)
;Shape, Color, and Number Level 1 bottomRight question button y-axis start from 990(bottom) to 844(top)
;Shape, Color, and Number Level 1 bottomRight question button x-axis start from 1067(left) to 1564(right)

;Color Level 2:
;red frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;orange frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;yellow frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;green frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;blue frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;purple frame
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)


;red paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;orange paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;yellow paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;green paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;blue paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)

;purple paint bucket
;y-axis:  (bottom)  (top)
;x-axiis:  (left)  (right)


;ScoreBoard next button:
;y-axis:  1018(bottom)  917(top)
;x-axiis:  1028(left)  1397(right)

;ScoreBoard exit button:
;y-axis:  1018(bottom)  910(top)
;x-axiis:  584(left)  953(right)

;LeaderBoard button y-axis start from ?(bottom) to ?(top)
;LeaderBoard button x-axis start from ?(left) to ?(right)

;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image
;function
(define (mouseRegister w x y me)
  (cond

     [(and (and (string=? (world-scene w) "menu") ;Play button
                (mouse=? me "button-down"))
          (and (<= y 480) 
               (>= y 377))
          (and (>= x 757)   
               (<= x 1148))) 
          (cChSelect)]

     [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Boy character select
                (mouse=? me "button-down"))
          (and (<= y 772) 
               (>= y 271))
          (and (>= x 66)   
               (<= x 448))) 
          (cBoySelect)]

     [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Janitor character select
                (mouse=? me "button-down"))
          (and (<= y 772) 
               (>= y 271))
          (and (>= x 531)   
               (<= x 913)))
          (cJanitorSelect)]

     [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Scientist character select
                (mouse=? me "button-down"))
          (and (<= y 772) 
               (>= y 271))
          (and (>= x 990)   
               (<= x 1370)))
          (cScientistSelect)]

     [(and (and (or (or (string=? (world-scene w) "chSelect") (string=? (world-scene w) "chSelect2")) (string=? (world-scene w) "chSelect3") (string=? (world-scene w) "chSelect4")) ;Police Woman character select
                (mouse=? me "button-down"))
          (and (<= y 772) 
               (>= y 271))
          (and (>= x 1460)   
               (<= x 1840)))
          (cPoliceWomanSelect)]

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

     [(and (and (string=? (world-scene w) "shapeElevator") ;Level 1 Elevator Button
                (mouse=? me "button-down"))
        (and (<= y 453)
             (>= y 419))
        (and (>= x 1443)
             (<= x 1480))) 
             (swShapeLobbyL1 w)]

     [(and (and (string=? (world-scene w) "shapeElevator") ;Level 2 Elevator Button
                (mouse=? me "button-down"))
        (and (<= y 505)
             (>= y 419))
        (and (>= x 1443)
             (<= x 1480))) 
             (swShapeLobbyL2 w)]

     [(and (and (string=? (world-scene w) "shapeElevator") ;Level 3 Elevator Button3
                (mouse=? me "button-down"))
        (and (<= y 556)
             (>= y 522))
        (and (>= x 1443)
             (<= x 1480))) 
             (swShapeLobbyL3 w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 topRight Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (swShapeLevel1Q2 w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q1") ;Shape Level 1 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 2 topRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 2 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 2 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q2") ;Shape Level 2 bottomLeft Correct button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (swShapeLevel1Q3 w)]  
        
     [(and (and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 3 topRight Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 3 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (swShapeLevel1Q4 w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 3 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q3") ;Shape Level 3 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]   

     [(and (and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 4 topRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 4 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 4 topLeft Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (swShapeLobbyL2 w)]

     [(and (and (string=? (world-scene w) "shapeLevel1Q4") ;Shape Level 4 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)] 


     [(and (and (string=? (world-scene w) "colorElevator") ;Level 1 Elevator Button
                (mouse=? me "button-down"))
        (and (<= y 453)
             (>= y 419))
        (and (>= x 1443)
             (<= x 1480))) 
             (swColorLobbyL1 w)]

     [(and (and (string=? (world-scene w) "colorElevator") ;Level 2 Elevator Button
                (mouse=? me "button-down"))
        (and (<= y 505)
             (>= y 419))
        (and (>= x 1443)
             (<= x 1480))) 
             (swColorLobbyL2 w)]

     [(and (and (string=? (world-scene w) "colorElevator") ;Level 3 Elevator Button3
                (mouse=? me "button-down"))
        (and (<= y 556)
             (>= y 522))
        (and (>= x 1443)
             (<= x 1480))) 
             (swColorLobbyL3 w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 topRight Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 topLeft right button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (swColorLevel1Q2  w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q1") ;color Level 1 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q2") ;color Level 2 topRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q2") ;color Level 2 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q2") ;color Level 2 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q2") ;color Level 2 bottomLeft Correct button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (swColorLevel1Q3 w)]  
        
     [(and (and (string=? (world-scene w) "colorLevel1Q3") ;color Level 3 topRight Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (swColorLevel1Q4 w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q3") ;color Level 3 bottomRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q3") ;color Level 3 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q3") ;color Level 3 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]   

     [(and (and (string=? (world-scene w) "colorLevel1Q4") ;color Level 4 topRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q4") ;color Level 4 bottomRight right button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (swColorLevel1Q5 w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q4") ;color Level 4 topLeft Correct button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q4") ;color Level 4 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q") ;color Level 5 topRight wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 1067)
             (<= x 1564))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q5") ;color Level 5 bottomRight correct button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 1067)
             (<= x 1564))) 
             (swColorLevel1Score5 w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q5") ;color Level 5 topLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 808)
             (>= y 663))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Q5") ;color Level 5 bottomLeft wrong button
                (mouse=? me "button-down"))
        (and (<= y 990)
             (>= y 844))
        (and (>= x 357)
             (<= x 855))) 
             (wrongAnswer w)]

     [(and (and (string=? (world-scene w) "colorLevel1Score5") ;level 1 score board exit button
                (mouse=? me "button-down"))
        (and (<= y 1018) 
             (>= y 910))
        (and (>= x 584)   
             (<= x 953)))
         (swColorLobbyL1 w)]  

     [(and (and (string=? (world-scene w) "colorLevel1Score5") ;level 1 next button
                (mouse=? me "button-down"))
        (and (<= y 1018) 
             (>= y 917))
        (and (>= x 1028)   
             (<= x 1397)))
         (swColorLobbyL2 w)]  


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
        [(string=? (world-scene world) "shapeLobbyL1")
                    (drawShapeLobby world)]
        [(string=? (world-scene world) "shapeLobbyL2")
                    (drawShapeLobby world)]
        [(string=? (world-scene world) "shapeLobbyL3")
                    (drawShapeLobby world)]
       [(string=? (world-scene world) "numberLobby")
                    (drawNumberLobby world)]
       [(string=? (world-scene world) "shapeLevel1Q1")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeLevel1Q2")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeLevel1Q3")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeLevel1Q4")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeLevel2")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeLevel3")
                    (drawShapeLevel world)]
       [(string=? (world-scene world) "shapeElevator")
                    elevator]

       [(string=? (world-scene world) "colorLobbyL1")
                    (drawColorLobby world)]
        [(string=? (world-scene world) "colorLobbyL2")
                    (drawColorLobby world)]
        [(string=? (world-scene world) "colorLobbyL3")
                    (drawColorLobby world)]
       [(string=? (world-scene world) "colorLobby")
                    (drawColorLobby world)]
       [(string=? (world-scene world) "colorLevel1Q1")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel1Q2")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel1Q3")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel1Q4")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel1Q5")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel2")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorLevel3")
                    (drawColorLevel world)]
       [(string=? (world-scene world) "colorElevator")
                    elevator]
       [(string=? (world-scene world) "colorLevel1Score5")
                    (drawColorScore world)]

        [else (empty-scene 1920 1080)]))

;test

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character (make-skin (skin-name (Character-skin (world-character world))) "right") (make-ChPos worldCenterWidth worldCenterHeight) 0))]
        [(string=? (world-scene world) "chSelect")
                    (cChSelect)]
        [(string=? (world-scene world) "Lobby")
                   (cLobby world)]
        [(string=? (world-scene world) "tutorial")
                    (cTutorial world)]
        [(string=? (world-scene world) "tutorialPopUp")
                    (cTutorialPopUp)]
        [(string=? (world-scene world) "shapeLobbyL1")
                    (swShapeLobbyL1)]
        [(string=? (world-scene world) "colorLobbyL1")
                    (swColorLobbyL1)] 
        [(string=? (world-scene world) "numberLobby")
                    (swNumber)]            

        [else world]))
  
;test


;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(name "Bilgi Kids")
(on-draw drawWorld)
(on-key keyboardControl)
(on-mouse mouseRegister)
;(on-tick soundPLayer) ;ontick for soundPLayer is wrong I am not quite sure how to add it
;(state #true) ;useful to see what is exactly going on
;(display-mode 'fullscreen) ;we need to add a quit game thing if we r going to do
)

(test)