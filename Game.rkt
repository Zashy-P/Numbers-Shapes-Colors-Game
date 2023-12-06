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

;(define skinOneEast (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
(define skinOneWest(circle 20 "solid" "blue"))
(define skinOneEast(bitmap "C:/Users/zaina/Downloads/boy_right_side-removebg-preview.png"))
(define skinOneNorth(circle 20 "solid" "orange"))
(define skinOneSouth(circle 20 "solid" "red"))

;world's center width and height
(define worldCenterWidth 960)
(define worldCenterHeight 540)

;Backgrounds just comment others bitmap and uncomment yours

;Menu Background 
;(define menuBg (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/background 2.jpg")) ;abdulrahman bitmap
(define menuBg (bitmap "C:/Users/zaina/OneDrive/Desktop/CMPE Term 1 Project/Photos/background 1919x1079.jpg")) ;zainab bitmap
;(define menuBg (bitmap)) ;maysam bitmap

;Character Select Background
;(define chSelectBg (bitmap "C:/Users/abdul/OneDrive/Pictures/Untitled_Artwork.jpg")) ;abdulrahman bitmap
(define chSelectBg (bitmap "C:/Users/zaina/OneDrive/Documents/GitHub/Numbers-Shapes-Colors-Game/Photos/selection 1.jpg")) ;zainab bitmap
;(define chSelectBg (bitmap)) ;maysam bitmap

;Tutorial Background
;(define tutorialBg (bitmap "C:/Users/abdul/OneDrive/Pictures/Screenshots/physics/Projectile Motion/Screenshot (35).png")) ;abdulrahman bitmap
(define tutorialBg (empty-scene 1920 1080)) ;zainab bitmap
;(define tutorialBg (bitmap)) ;maysam bitmap

;Lobby background
;(define lobbyBg (bitmap "C:/Users/abdul/OneDrive/Pictures/Untitled_Artwork.jpg")) ;abdulrahman bitmap
(define lobbyBg (empty-scene 1920 1080)) ;zainab bitmap
;(define lobbyBg (bitmap)) ;maysam bitmap

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================

; Button --> image,pos(x,y)
(define-struct button (image pos))
(define-struct buttonPos(x y))


;Purpose: Draws a button with given string and x,y coordinates
;Contract: drawButton: string --> image
;we can change the font & box(button) shape to our liking later on
;function
(define (drawButton string)
  (overlay (text/font string 18 "indigo"
           "Gill Sans" 'swiss 'normal 'bold #f) 
           (rectangle 400 60 "solid" "Alice Blue")))

;test
(check-expect (drawButton "Start" )
              (overlay (text/font "Start" 18 "indigo"
                       "Gill Sans" 'swiss 'normal 'bold #f) 
                       (rectangle 400 60 "solid" "Alice Blue")))

;defining Buttons: Start, Tutorial, LeaderBoard
(define startButton (make-button 
                    (drawButton "Start") 
                    (make-buttonPos worldCenterWidth worldCenterHeight))) ;pos is pointless here ;/
(define TutorialButton (make-button 
                       (drawButton "Tutorial") 
                       (make-buttonPos worldCenterWidth worldCenterHeight)))
(define leaderBoard (make-button 
                    (drawButton "LeaderBoard") 
                    (make-buttonPos worldCenterWidth worldCenterHeight)))

;Purpose: Draws the menu with empty space in between them using rectangles
;Contract: menu --> image
(define menu       
    (place-image (above (button-image startButton)
                                 (rectangle 400 60 "solid" "Royal Blue")
                                 (button-image TutorialButton)
                                 (rectangle 400 60 "solid" "Royal Blue")
                                 (button-image leaderBoard))                               
                                 worldCenterWidth worldCenterHeight
                                 menuBg))



; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))

;=======================================================================================
;******************************* Character Select**************************************
;=======================================================================================

;Purpose: Draw the character select buttons
;Contract: drawChSelectButtons: button --> image
;function
(define (drawChSelectButton button)
  (place-image (button-image button) (buttonPos-x (button-pos button)) (buttonPos-y (button-pos button)) (rectangle 400 60 "solid" "Alice Blue")))

;test

(check-expect (drawChSelectButton (make-button (triangle 30 "solid" "red") (make-buttonPos 100 100))) (place-image (triangle 30 "solid" "red") 100 100 (rectangle 400 60 "solid" "Alice Blue")))
(check-expect (drawChSelectButton (make-button skinOneEast (make-buttonPos 100 100))) (place-image skinOneEast 100 100 (rectangle 400 60 "solid" "Alice Blue")))

;Character Select Buttons
(define skinOneButton (make-button skinOneNorth (make-buttonPos 100 100)))
(define skinTwoButton (make-button skinOneSouth (make-buttonPos 100 100))) ;pos is pointless here ;/
(define skinThreeButton (make-button skinOneEast (make-buttonPos 1000 100)))

;Draw The Character Select Menu
(define characterSelectMenu
  (place-image (above (beside (button-image skinOneButton) (button-image skinTwoButton)) 
                              (button-image skinThreeButton))                               
                               worldCenterWidth worldCenterHeight chSelectBg))

;defines the character select scene once clicked
(define cChSelect (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))
;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================

;defines the Lobby scene once clicked 
(define cLobby (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))
;defines character speed
(define ChSpeed 50)

;Purpose: Draws the Character in the Lobby
;Contract: drawLobby: world --> image
(define (drawLobby world) (place-image  (Character-skin (world-character world)) 
                                        (ChPos-x (Character-pos (world-character world))) 
                                        (ChPos-y (Character-pos (world-character world)))
                                         lobbyBg))
;test 
(check-expect (drawLobby (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinOneEast worldCenterWidth worldCenterHeight lobbyBg))

;Purpose: helper function to update the x coordinates of the Character
;Contract: updateChPosx: Character(c), number(cs) --> pos(x)
;function
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))

;test
(check-expect (updateChPosx (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)) 50) 1010)
(check-expect (updateChPosx (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)) -50) 910)  

;Purpose: helper function to update the y coordinates of the Character
;Contract: updateChPosy: Character(c), number(cs) --> pos(y)
;function
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))

;test
(check-expect (updateChPosy (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)) 50) 590)
(check-expect (updateChPosy (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)) -50) 490)

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: world(w), keyboard-input(ki) --> image
;function
(define (moveCharacter w ki)
  (if (or (string=? (world-scene w) "Lobby") (string=? (world-scene w) "tutorial"))                                          
  (cond
    [(or (key=? ki "left") (key=? ki "a")) 
     (make-world (world-scene w) 
                 (make-Character skinOneWest 
                                 (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "right") (key=? ki "d")) 
     (make-world (world-scene w) 
                 (make-Character skinOneEast 
                                 (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "up") (key=? ki "w")) 
     (make-world (world-scene w) 
                 (make-Character skinOneNorth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) (* ChSpeed -1)))))]
    [(or (key=? ki "down") (key=? ki "s")) 
     (make-world (world-scene w) 
                 (make-Character skinOneSouth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) ChSpeed))))]
    [else w]
    )w))

;test ;Question should we keep this style or should we just write in one line this style makes it more readable for us but it takes more time to write this way
(check-expect (moveCharacter 
              (make-world "Lobby" 
                          (make-Character skinOneEast 
                                          (make-ChPos worldCenterWidth worldCenterHeight)))
                                           "left")
                                            (make-world "Lobby" 
                                                        (make-Character skinOneWest 
                                                                        (make-ChPos 910 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) "right") (make-world "Lobby" (make-Character skinOneEast (make-ChPos 1010 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) "up") (make-world "Lobby" (make-Character skinOneNorth (make-ChPos 960 490))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) "down") (make-world "Lobby" (make-Character skinOneSouth (make-ChPos 960 590))))

;=======================================================================================
;******************************* Tutorial**************************************
;=======================================================================================

;Purpose: Draws the Tutorial
;Contract: drawTutorial: world(w) --> image
(define (drawTutorial world)
  (place-image (Character-skin (world-character world)) 
               (ChPos-x (Character-pos (world-character world))) 
               (ChPos-y (Character-pos (world-character world))) 
                tutorialBg))

;test
(check-expect (drawTutorial (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (place-image skinOneEast worldCenterWidth worldCenterHeight tutorialBg))

;defines the tutorial scene once clicked
(define cTutorial (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))


;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================

;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image

;start button y-axis start from 450(bottom) to 390(top)
;start button x-axis start from 760(left) to 1160(right)

;Tutorial button y-axis start from 570(bottom) to 510(top)
;Tutorial button x-axis start from 760(left) to 1160(right)

;LeaderBoard button y-axis start from 690(bottom) to 630(top)
;LeaderBoard button x-axis start from 760(left) to 1160(right)

;function
(define (mouseRegister w x y me)
  (cond
  [(and (and (string=? (world-scene w) "menu")
             (mouse=? me "button-down"))
        (and (<= y 450) ;start button
             (>= y 390))
        (and (>= x 760)   
             (<= x 1160))) 
        cChSelect]
  [(and (and (string=? (world-scene w) "menu")
             (mouse=? me "button-down"))
        (and (<= y 570) ;tutorial button
             (>= y 510))
        (and (>= x 760)   
             (<= x 1160))) 
        cTutorial]
  [(and (string=? (world-scene w) "chSelect") 
             (mouse=? me "button-down"))
             cLobby]
  [else w]))

;test
(check-expect (mouseRegister (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) 800 400 "button-down") cChSelect)
(check-expect (mouseRegister (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) 800 550 "button-down") cTutorial)
(check-expect (mouseRegister (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))) 800 550 "button-down") cLobby)

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
        [(string=? (world-scene world) "tutorial")
                    (drawTutorial world)]
        [else (empty-scene 1920 1080)]))

;test
(check-expect (drawWorld (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) menu)
(check-expect (drawWorld (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) characterSelectMenu)
(check-expect (drawWorld (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (drawLobby (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))))
(check-expect (drawWorld (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (drawTutorial (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))))

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "chSelect")
                    (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "Lobby")
                   (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [(string=? (world-scene world) "tutorial")
                    (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))]
        [else world]))
  
;test
(check-expect (sceneSelector (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "menu" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "chSelect" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "Lobby" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))
(check-expect (sceneSelector (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight)))) (make-world "tutorial" (make-Character skinOneEast (make-ChPos worldCenterWidth worldCenterHeight))))

;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(on-draw drawWorld)
(on-key moveCharacter)
(on-mouse mouseRegister))

(test)
