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
;******************************* Character & Lobby**************************************
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
(on-mouse mouseRegister))

(test)
