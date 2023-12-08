#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;=======================================================================================
;************************************ world ********************************************
;=======================================================================================

;World --> Scene, Character, LeaderBoard(not now later)
(define-struct world (scene character)) ;leaderBoard)) will do leaderBoard Later

;Character --> image(skin), pos(x,y)
(define-struct Character (skin pos))
(define-struct ChPos (x y))

;Character skins
;abdulrahman's bitmaps
(define skinBoyWest(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_left_side.png"))
(define skinBoyEast(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy right side.png"))
(define skinBoyNorth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_backside.png"))
(define skinBoySouth(bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/boy/boy_frontside.png"))

;zainab's bitmaps
;(define skinBoyWest (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
;(define skinBoyEast (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
;(define skinBoyNorth (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
;(define skinBoySouth (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
;(define skinBoyEast (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))

;maysam's bitmaps
;(define skinBoyWest (bitmap ""))
;(define skinBoyEast (bitmap ""))
;(define skinBoyNorth (bitmap ""))
;(define skinBoySouth (bitmap ""))

;Janitor skin
;abdulrahman's bitmaps
(define skinJanitorWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor left side.png"))
(define skinJanitorEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor right side.png"))
(define skinJanitorNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor backside.png"))
(define skinJanitorSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/janitor/janitor frontside.png"))

;zainab's bitmaps
;(define skinJanitorWest (bitmap ""))
;(define skinJanitorEast (bitmap ""))
;(define skinJanitorNorth (bitmap ""))
;(define skinJanitorSouth (bitmap ""))

;maysam's bitmaps
;(define skinJanitorWest (bitmap ""))
;(define skinJanitorEast (bitmap ""))
;(define skinJanitorNorth (bitmap ""))
;(define skinJanitorSouth (bitmap ""))

;Scientist skin
;abdulrahman's bitmaps
(define skinScientistWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist left side.png"))
(define skinScientistEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist right side.png"))
(define skinScientistNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist backside.png"))
(define skinScientistSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/scientist/scientist frontside.png"))

;zainab's bitmaps
;(define skinScientistWest (bitmap ""))
;(define skinScientistEast (bitmap ""))
;(define skinScientistNorth (bitmap ""))
;(define skinScientistSouth (bitmap ""))

;maysam's bitmaps
;(define skinScientistWest (bitmap ""))
;(define skinScientistEast (bitmap ""))
;(define skinScientistNorth (bitmap ""))
;(define skinScientistSouth (bitmap ""))

;Police Woman
;abdulrahman's bitmaps
(define skinPoliceWomanWest (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman leftside.png"))
(define skinPoliceWomanEast (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman right side.png"))
(define skinPoliceWomanNorth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman backside.png"))
(define skinPoliceWomanSouth (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Characters/police woman/police woman frontside.png"))


;zainab's bitmaps
;(define skinPoliceWomantWest (bitmap ""))
;(define skinPoliceWomantEast (bitmap ""))
;(define skinPoliceWomantNorth (bitmap ""))
;(define skinPoliceWomantSouth (bitmap ""))

;maysam's bitmaps
;(define skinPoliceWomantWest (bitmap ""))
;(define skinPoliceWomantEast (bitmap ""))
;(define skinPoliceWomantNorth (bitmap ""))
;(define skinPoliceWomantSouth (bitmap ""))

; pixel character
;for getting x,y position of stuff (Testing Purposes)
;(define skinBoyWest (line 0 2 "red"))
;(define skinBoyEast (line 0 2 "red"))
;(define skinBoyNorth (line 0 2 "red"))
;(define skinBoySouth (line 0 2 "red"))

;world's center width and height
(define worldCenterWidth 960)
(define worldCenterHeight 540)

;Backgrounds just comment others bitmap and uncomment yours

;Menu Background 
(define menuBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/Final menu background.jpg")) ;abdulrahman bitmap
;(define menuBg (bitmap)) ;zainab bitmap
;(define menuBg (bitmap)) ;maysam bitmap

;Character Select Background
(define chSelectBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/character select 1.jpeg")) ;abdulrahman bitmap
;(bitmap) ;zainab bitmap
;(bitmap) ;maysam bitmap

;Tutorial Pop Up Background
(define tutorialPopUpBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/tutorial pop up with background.jpg")) ;abdulrahman bitmap
;(define lobbyBg (bitmap)) ;zainab bitmap
;(define lobbyBg (bitmap)) ;maysam bitmap

;Tutorial Background
(define tutorialBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/menu background.jpg")) ;abdulrahman bitmap
;(define tutorialBg (bitmap)) ;zainab bitmap
;(define tutorialBg (bitmap)) ;maysam bitmap

;Lobby Background
(define lobbyBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/background 2.jpg")) ;abdulrahman bitmap
;(define lobbyBg (bitmap)) ;zainab bitmap
;(define lobbyBg (bitmap)) ;maysam bitmap

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================

; Button --> image,pos(x,y)
;(define-struct button (image pos))
;(define-struct buttonPos(x y))


;Purpose: Draws a button with given string and x,y coordinates
;Contract: drawButton: string --> image
;we can change the font & box(button) shape to our liking later on
;function
;(define (drawButton string)
;  (overlay (text/font string 18 "indigo"
;           "Gill Sans" 'swiss 'normal 'bold #f) 
;           (rectangle 400 60 "solid" "Alice Blue")))

;test
;(check-expect (drawButton "Start" )
;              (overlay (text/font "Start" 18 "indigo"
;                       "Gill Sans" 'swiss 'normal 'bold #f) 
;                       (rectangle 400 60 "solid" "Alice Blue")))

;defining Buttons: Start, Tutorial, LeaderBoard
;(define startButton (make-button 
;                    (drawButton "Start") 
;                    (make-buttonPos worldCenterWidth worldCenterHeight))) ;pos is pointless here ;/
;(define TutorialButton (make-button 
;                       (drawButton "Tutorial") 
;                       (make-buttonPos worldCenterWidth worldCenterHeight)))
;(define leaderBoard (make-button 
;                    (drawButton "LeaderBoard") 
;                    (make-buttonPos worldCenterWidth worldCenterHeight)))

;Purpose: Draws the menu with empty space in between them using rectangles
;Contract: menu --> image
(define menu    
  (place-image menuBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))



; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

;=======================================================================================
;******************************* Character Select**************************************
;=======================================================================================

;Purpose: Draw the character select buttons
;Contract: drawChSelectButtons: button --> image
;function
;(define (drawChSelectButton button)
 ; (place-image (button-image button) (buttonPos-x (button-pos button)) (buttonPos-y (button-pos button)) (rectangle 400 60 "solid" "Alice Blue")))

;test

;(check-expect (drawChSelectButton (make-button (triangle 30 "solid" "red") (make-buttonPos 100 100))) (place-image (triangle 30 "solid" "red") 100 100 (rectangle 400 60 "solid" "Alice Blue")))
;(check-expect (drawChSelectButton (make-button skinBoyEast (make-buttonPos 100 100))) (place-image skinBoyEast 100 100 (rectangle 400 60 "solid" "Alice Blue")))

;Character Select Buttons
;(define skinBoyButton (make-button skinBoyNorth (make-buttonPos 100 100)))
;(define skinTwoButton (make-button skinBoySouth (make-buttonPos 100 100))) ;pos is pointless here ;/
;(define skinThreeButton (make-button skinBoyEast (make-buttonPos 1000 100)))

;Draw The Character Select Menu
;(define characterSelectMenu
  ;(place-image (above (beside (button-image skinBoyButton) (button-image skinTwoButton)) 
                            ;  (button-image skinThreeButton))                               
                              ; worldCenterWidth worldCenterHeight chSelectBg))
              
;Draw The Character Select Menu
(define characterSelectMenu
   (place-image chSelectBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================

;defines character speed
(define ChSpeed 10)

;Purpose: Draws the Character in the Lobby
;Contract: drawLobby: world --> image
(define (drawLobby world) (place-image  (Character-skin (world-character world)) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         lobbyBg))
;test 
(check-expect (drawLobby (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinBoyEast worldCenterWidth worldCenterHeight lobbyBg))

;Purpose: helper function to update the x coordinates of the Character
;Contract: updateChPosx: Character(c), number(cs) --> pos(x)
;function
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))

;test
(check-expect (updateChPosx (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)) 50) 1010)
(check-expect (updateChPosx (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)) -50) 910)  

;Purpose: helper function to update the y coordinates of the Character
;Contract: updateChPosy: Character(c), number(cs) --> pos(y)
;function
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))

;test
(check-expect (updateChPosy (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)) 50) 590)
(check-expect (updateChPosy (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)) -50) 490)

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: world(w), keyboard-input(ki) --> image
;function
(define (moveCharacter w ki)
  (if (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorial"))                                          
  (cond
    [(or (key=? ki "left") (key=? ki "a")) 
     (make-world (world-scene w) 
                 (make-Character skinBoyWest 
                                 (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "right") (key=? ki "d")) 
     (make-world (world-scene w) 
                 (make-Character skinBoyEast 
                                 (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "up") (key=? ki "w")) 
     (make-world (world-scene w) 
                 (make-Character skinBoyNorth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) (* ChSpeed -1)))))]
    [(or (key=? ki "down") (key=? ki "s")) 
     (make-world (world-scene w) 
                 (make-Character skinBoySouth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) ChSpeed))))]
    [else w]
    )w)
    )

;test ;Question should we keep this style or should we just write in one line this style makes it more readable for us but it takes more time to write this way
(check-expect (moveCharacter 
              (make-world "Lobby" 
                          (make-Character skinBoyEast 
                                          (make-ChPos worldCenterWidth worldCenterHeight)))
                                           "left")
                                            (make-world "Lobby" 
                                                        (make-Character skinBoyWest 
                                                                        (make-ChPos 950 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) "right") (make-world "Lobby" (make-Character skinBoyEast (make-ChPos 970 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) "up") (make-world "Lobby" (make-Character skinBoyNorth (make-ChPos 960 530))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) "down") (make-world "Lobby" (make-Character skinBoySouth (make-ChPos 960 550))))

;=======================================================================================
;******************************* Tutorial**************************************
;=======================================================================================

;Purpose: Draws the Tutorial Pop up
;Contract: drawTutorial: world(w) --> image
(define (drawTutorialPopUp world)
  (place-image tutorialPopUpBg worldCenterWidth worldCenterHeight (empty-scene 1920 1080)))

;Purpose: Draws the Tutorial
;Contract: drawTutorial: world(w) --> image
(define (drawTutorial world)
  (place-image (Character-skin (world-character world)) 
               (ChPos-x (Character-pos (world-character world))) 
               (ChPos-y (Character-pos (world-character world))) 
                tutorialBg))

;test
(check-expect (drawTutorial (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinBoyEast worldCenterWidth worldCenterHeight tutorialBg))

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================

;defines the character select scene once clicked
(define cChSelect (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

;defines the Lobby scene once clicked 
(define (cLobby world) (make-world "Lobby" (make-Character (Character-skin (world-character world)) (make-ChPos worldCenterWidth worldCenterHeight))))

;defines the tutorial pop up scene once confirm on chSelect is clicked
(define cTutorialPopUp (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

;defines the tutorial scene once yes on tutorial pop up is clicked
(define cTutorial (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

;makes the skin boy once clicked
(define cBoySelect (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

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

;Scientist character select y-axis start from ?(bottom) ?(top)
;Scientist character select x-axis start from ?(left) ?(right)

;Police Woman character select y-axis start from 772(bottom) 271(top)
;Police Woman character select x-axis start from ?(left) ?(right)

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
 ; [(and (and (string=? (world-scene w) "chSelect") ;Boy character select
       ;      (mouse=? me "button-down"))
       ; (and (<= y 772) 
       ;      (>= y 271))
       ; (and (>= x 66)   
        ;     (<= x 448))) 
       ; cBoySelect]
  [(and (and (string=? (world-scene w) "chSelect") ;chSelect confirm button
             (mouse=? me "button-down"))
        (and (<= y 1080) 
             (>= y 931))
        (and (>= x 1570)   
             (<= x 1855))) 
        cTutorialPopUp]
  [(and (and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp yes button
             (mouse=? me "button-down"))
        (and (<= y 770) 
             (>= y 670))
        (and (>= x 567)   
             (<= x 915)))
         cTutorial]
  [(and (and (string=? (world-scene w) "tutorialPopUp") ;tutorialPopUp no button
             (mouse=? me "button-down"))
        (and (<= y 770)
             (>= y 670))
        (and (>= x 1029)
             (<= x 1376))) 
             (cLobby w)]
  [else w]))

;test
(check-expect (mouseRegister (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) 800 390 "button-down") (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (mouseRegister (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) 1700 1000 "button-down") (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (mouseRegister (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) 700 700 "button-down") (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (mouseRegister (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))) 1200 700 "button-down") (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))

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
        [(string=? (world-scene world) "Lobby") 
                    (drawLobby world)]
        [(string=? (world-scene world) "tutorialPopUp")
                    (drawTutorialPopUp world)]
        [(string=? (world-scene world) "tutorial")
                    (drawTutorial world)]
        [else (empty-scene 1920 1080)]))

;test
(check-expect (drawWorld (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) menu)
(check-expect (drawWorld (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) characterSelectMenu)
(check-expect (drawWorld (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (drawLobby (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))))
(check-expect (drawWorld (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (drawTutorialPopUp (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))))
(check-expect (drawWorld (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (drawTutorial (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))))

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "chSelect")
                    (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "Lobby")
                   (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "tutorial")
                    (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "tutorialPopUp")
                    (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))
  
;test
(check-expect (sceneSelector (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorialPopUp" (make-Character skinBoyEast (make-ChPos worldCenterWidth worldCenterHeight))))
;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(on-draw drawWorld)
(on-key moveCharacter)
(on-mouse mouseRegister))

(test)
