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
(define-struct Character (skin pos))
(define-struct ChPos (x y))
;skin --> name direction
(define-struct skin(name direction))
;skinD --> west east south north
(define-struct skinD(west east south north))
;Sound --> Sound Path, Boolean
(define-struct Sound (path boolean))

;=======================================================================================
;************************************ Sound ********************************************
;=======================================================================================

;Path to the Button Click sound effect
(define buttonClick1Path "./buttonClick1.mp3")
(define footstepPath "./Concretefootstep.mp3")
(define bellRingPath "./bellRing.wav")
(define (playButtonClick1Sound)
  (play-sound buttonClick1Path #f))
(define (playFootstepSound)
  (play-sound footstepPath #f))
(define (playBellRingSound)
  (play-sound bellRingPath #f))

;=======================================================================================
;************************************ Images *******************************************
;=======================================================================================
;Character skins
;abdulrahman's bitmaps

;boy skin
(define skinBoyWest(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_left_side.png"))
(define skinBoyEast(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy right side.png"))
(define skinBoyNorth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_backside.png"))
(define skinBoySouth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_frontside.png"))
(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;Janitor skin
(define skinJanitorWest(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor left side.png"))
(define skinJanitorEast(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor right side.png"))
(define skinJanitorNorth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor backside.png"))
(define skinJanitorSouth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor frontside.png"))
(define janitorSkin (make-skinD skinJanitorWest skinJanitorEast skinJanitorSouth skinJanitorNorth))

;Scientist skin
(define skinScientistWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist left side.png"))
(define skinScientistEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist right side.png"))
(define skinScientistNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist backside.png"))
(define skinScientistSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist frontside.png"))
(define scientistSkin (make-skinD skinScientistWest skinScientistEast skinScientistSouth skinScientistNorth))

;Police woman skin
(define skinPoliceWomanWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman leftside.png"))
(define skinPoliceWomanEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman right side.png"))
(define skinPoliceWomanNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman backside.png"))
(define skinPoliceWomanSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman frontside.png"))
(define policeWomanSkin (make-skinD skinPoliceWomanWest skinPoliceWomanEast skinPoliceWomanSouth skinPoliceWomanNorth))

;zainab's bitmaps

;boy skin
;(define skinBoyWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_left_side.png"))
;(define skinBoyEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy right side.png"))
;(define skinBoyNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_backside.png"))
;(define skinBoySouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/boy/boy_frontside.png"))
;(define boySkin (make-skinD skinBoyWest skinBoyEast skinBoySouth skinBoyNorth))

;janitor skin
;(define skinJanitorWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor left side.png"))
;(define skinJanitorEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor right side.png"))
;(define skinJanitorNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor backside.png"))
;(define skinJanitorSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/janitor/janitor frontside.png"))
;(define janitorSkin (make-skinD skinJanitorWest skinJanitorEast skinJanitorSouth skinJanitorNorth))

;Scientist skin
;(define skinScientistWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist left side.png"))
;(define skinScientistEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist right side.png"))
;(define skinScientistNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist backside.png"))
;(define skinScientistSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/scientist/scientist frontside.png"))
;(define scientistSkin (make-skinD skinScientistWest skinScientistEast skinScientistSouth skinScientistNorth))

;Police woman skin
;(define skinPoliceWomanWest (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman leftside.png"))
;(define skinPoliceWomanEast (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman right side.png"))
;(define skinPoliceWomanNorth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman backside.png"))
;(define skinPoliceWomanSouth (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Characters/police woman/police woman frontside.png"))
;(define policeWomanSkin (make-skinD skinPoliceWomanWest skinPoliceWomanEast skinPoliceWomanSouth skinPoliceWomanNorth))
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
(define menuBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/backgrounds/Final menu background.jpg")) 

;Character Select Backgrounds
(define chSelectBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 1.jpeg")) 
(define chSelect2Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 2.jpeg"))
(define chSelect3Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/character select 3.jpeg"))
(define chSelect4Bg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/selection/charcater select  4.jpeg"))

;Tutorial Pop Up Background
(define tutorialPopUpBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/tutorial pop up with background.jpg")) 

;Tutorial Background
(define tutorialBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/tutorial pop up with background.jpg")) 

;Lobby Background
(define lobbyBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Lobby Background.jpg")) 

;ShapeS1 (s1 is scene one) Background
(define shapeS1Bg (empty-scene 1920 1080))

;zainab's bitmap

;Menu Background
;(define menuBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/backgrounds/Final menu background.jpg")) 
;(define chSelect2Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 2.jpeg"))
;(define chSelect3Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 3.jpeg"))
;(define chSelect4Bg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/charcater select  4.jpeg"))

;Character Select Background
;(define chSelectBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection/character select 1.jpeg")) 

;Tutorial Pop Up Background
;(define tutorialPopUpBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/tutorial pop up with background.jpg"))

;Tutorial Background
;(define tutorialBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/tutorial pop up with background.jpg"))

;Lobby Background
;(define lobbyBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/Lobby Background.jpg"))

;ShapeS1 (s1 is scene one) Background
;(define shapeS1Bg (empty-scene 1920 1080))

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

;ShapeS1 (s1 is scene one) Background
;(define shapeS1Bg (empty-scene 1920 1080))

; pixel character
;for getting x,y position of stuff (Testing Purposes)
;(define skinBoyWest (line 0 2 "red"))
;(define skinBoyEast (line 0 2 "red"))
;(define skinBoyNorth (line 0 2 "red"))
;(define skinBoySouth (line 0 2 "red"))

;world's center width and height
(define worldCenterWidth 960)
(define worldCenterHeight 540)

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
;************************************ Shape Game ***************************************
;=======================================================================================

(define (drawShapeS1 world) (place-image  (overlay/xy (text/font "Zashy" 18 "indigo"  ; we can add name later on
             #f 'modern 'italic 'normal #f)
  -25 0 (skinUpdater (Character-skin (world-character world)))) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         shapeS1Bg))


(define (swShape w) (begin (thread playBellRingSound) (make-world "shapeS1" (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left") (make-ChPos worldCenterWidth worldCenterHeight)))))




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

;shape door y coordinates 590(bottom) 530(top)
;shape door x coordinates 310(left) 380(right)

;number door y coordinates ?(bottom) ?(top)
;number door x coordinates ?(left) ?(right)

;color door y coordinates ?(bottom) ?(top)
;color door x coordinates ?(left) ?(right)

;tutorial door y coordinates ?(bottom) ?(top)
;tutorial door x coordinates ?(left) ?(right)

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: keyboardControl: world(w), keyboard-input(ki) --> image
;function
(define (keyboardControl w ki)
  (if (or (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorial") (string=? (world-scene w) "shapeS1")))                                          
    (cond                                       

        [(and (string=? (world-scene w) "Lobby") ;Shape Door
        (and (<= (ChPos-y (Character-pos (world-character w))) 590)
             (>= (ChPos-y (Character-pos (world-character w))) 530))
        (and (>= (ChPos-x (Character-pos (world-character w))) 310)
             (<= (ChPos-x (Character-pos (world-character w))) 380))) 
             (swShape w)]

        [(or (key=? ki "left") (key=? ki "a")) 
          (begin
          (thread playFootstepSound)
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "left") 
                               (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                           (ChPos-y (Character-pos (world-character w)))))))]

        [(or (key=? ki "right") (key=? ki "d"))
          (begin
          (thread playFootstepSound)
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "right")  
                               (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                           (ChPos-y (Character-pos (world-character w)))))))]

        [(or (key=? ki "up") (key=? ki "w")) 
          (begin
          (thread playFootstepSound)
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "up")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) (* ChSpeed -1))))))]

        [(or (key=? ki "down") (key=? ki "s")) 
          (begin
          (thread playFootstepSound)
          (make-world (world-scene w) 
               (make-Character (make-skin (skin-name (Character-skin (world-character w))) "down")  
                               (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                           (updateChPosy (world-character w) ChSpeed)))))]
                   

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
(define (cChSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))))

;defines the Lobby scene once clicked 
(define (cLobby world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "Lobby" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "Lobby"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [else world]))

;defines the tutorial pop up scene once confirm on chSelect is clicked
(define (cTutorialPopUp world)
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
         [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "tutorialPopUp"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [else world]))

;defines the tutorial scene once yes on tutorial pop up is clicked
(define (cTutorial world) 
    (cond
        [(string=? (skin-name (Character-skin (world-character world))) "janitor") (begin (thread playButtonClick1Sound) (make-world "tutorial" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "boy") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "scientist") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [(string=? (skin-name (Character-skin (world-character world))) "policeWoman") (begin (thread playButtonClick1Sound) (make-world "tutorial"(make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight))))]
        [else world]))

;makes the skin boy once clicked
(define (cBoySelect) (begin (thread playButtonClick1Sound) (make-world "chSelect" (make-Character (make-skin "boy" "right") (make-ChPos worldCenterWidth worldCenterHeight)))))

;makes the skin janitor once clicked
(define (cJanitorSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect2" (make-Character (make-skin "janitor" "right") (make-ChPos worldCenterWidth worldCenterHeight)))))

;makes the skin janitor once clicked
(define (cScientistSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect3" (make-Character (make-skin "scientist" "right") (make-ChPos worldCenterWidth worldCenterHeight)))))

;makes the skin janitor once clicked
(define (cPoliceWomanSelect) (begin (thread playButtonClick1Sound) (make-world "chSelect4" (make-Character (make-skin "policeWoman" "right") (make-ChPos worldCenterWidth worldCenterHeight)))))

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
        [(string=? (world-scene world) "shapeS1")
                    (drawShapeS1 world)]
        [else (empty-scene 1920 1080)]))

;test

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character (make-skin (skin-name (Character-skin (world-character world))) "right") (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "chSelect")
                    (cChSelect)]
        [(string=? (world-scene world) "Lobby")
                   (cLobby world)]
        [(string=? (world-scene world) "tutorial")
                    (cTutorial world)]
        [(string=? (world-scene world) "tutorialPopUp")
                    (cTutorialPopUp)]
        [(string=? (world-scene world) "shapeS1")
                    (swShape)]            

        [else world]))
  
;test


;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(name "Teachify")
(on-draw drawWorld)
(on-key keyboardControl)
(on-mouse mouseRegister)
;(on-tick soundPLayer) ;ontick for soundPLayer is wrong I am not quite sure how to add it
;(state #true) ;useful to see what is exactly going on
;(display-mode 'fullscreen) ;we need to add a quit game thing if we r going to do
)

(test)
