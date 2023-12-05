#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;=======================================================================================
;************************************ world ********************************************
;=======================================================================================
;World --> Scene, Character LeaderBoard(not now later)
(define-struct world (scene character)) ;leaderBoard)) will do leaderBoard Later
;Character --> image(skin), pos(x,y)
(define-struct Character (skin pos))
(define-struct ChPos (x y))

;(define skinOneEast (bitmap "C:/Users/zaina/OneDrive/Pictures/4669e110c981b83cf8185ba56501f27d.jpg"))
(define skinOneWest(circle 20 "solid" "blue"))
(define skinOneEast(circle 20 "solid" "green"))
(define skinOneNorth(circle 20 "solid" "orange"))
(define skinOneSouth(circle 20 "solid" "red"))

;Resolutions
(define LobbyWidth 1920)
(define LobbyHeight 1080)
(define menuWidth 1920)
(define menuHeight 1080)
(define centerWidth 960)
(define centerHeight 540)
;scene resolutions
(define LobbyScene (empty-scene LobbyWidth LobbyHeight))
(define menuScene (empty-scene menuWidth menuHeight))

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
                    (make-buttonPos centerWidth centerHeight)))
(define TutorialButton (make-button 
                       (drawButton "Tutorial") 
                       (make-buttonPos centerWidth centerHeight)))
(define leaderBoard (make-button 
                    (drawButton "LeaderBoard") 
                    (make-buttonPos centerWidth centerHeight)))

;Purpose: Draws the menu with empty space in between them using rectangles
;Contract: menu --> image
(define menu       
    (place-image (overlay (above (button-image startButton)
                                 (rectangle 400 60 "solid" "Royal Blue")
                                 (button-image TutorialButton)
                                 (rectangle 400 60 "solid" "Royal Blue")
                                 (button-image leaderBoard)) 
                                 (bitmap "C:/Users/abdul/OneDrive/Documents/GitHub/CEMPE Project Term1/Shapes-Colors-Game/Photos/background 2.jpg")) ;(bitmap "C:/Users/zaina/Downloads/background 2.jpg"))
                                 centerWidth centerHeight
                                 menuScene))



; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))))

;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;defines the Lobby scene later on we will have a function that selects scenes for now we can select scenes manually
(define Lobby (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))))
;defines character speed
(define ChSpeed 50)

;Purpose: helper function to update the x coordinates of the Character
;Contract: updateChPosx: Character(c), number(cs) --> pos(x)
;function
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))

;test
(check-expect (updateChPosx (make-Character skinOneEast (make-ChPos centerWidth centerHeight)) 50) 1010)
(check-expect (updateChPosx (make-Character skinOneEast (make-ChPos centerWidth centerHeight)) -50) 910)  

;Purpose: helper function to update the y coordinates of the Character
;Contract: updateChPosy: Character(c), number(cs) --> pos(y)
;function
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))

;test
(check-expect (updateChPosy (make-Character skinOneEast (make-ChPos centerWidth centerHeight)) 50) 590)
(check-expect (updateChPosy (make-Character skinOneEast (make-ChPos centerWidth centerHeight)) -50) 490)

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: world(w), keyboard-input(ki) --> image
;function
(define (moveCharacter w ki)
  (if (string=? (world-scene w) "Lobby")                                          
  (cond
    [(or (key=? ki "left") (key=? ki "a")) 
     (make-world "Lobby" 
                 (make-Character skinOneWest 
                                 (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "right") (key=? ki "d")) 
     (make-world "Lobby" 
                 (make-Character skinOneEast 
                                 (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "up") (key=? ki "w")) 
     (make-world "Lobby" 
                 (make-Character skinOneNorth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) (* ChSpeed -1)))))]
    [(or (key=? ki "down") (key=? ki "s")) 
     (make-world "Lobby" 
                 (make-Character skinOneSouth 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) ChSpeed))))]
    [else w]
    )w))

;test ;Question should we keep this style or should we just write in one line this style makes it more readable for us but it takes more time to write this way
(check-expect (moveCharacter 
              (make-world "Lobby" 
                          (make-Character skinOneEast 
                                          (make-ChPos centerWidth centerHeight)))
                                           "left")
                                            (make-world "Lobby" 
                                                        (make-Character skinOneWest 
                                                                        (make-ChPos 910 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))) "right") (make-world "Lobby" (make-Character skinOneEast (make-ChPos 1010 540))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))) "up") (make-world "Lobby" (make-Character skinOneNorth (make-ChPos 960 490))))
(check-expect (moveCharacter (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))) "down") (make-world "Lobby" (make-Character skinOneSouth (make-ChPos 960 590))))

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================
;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image

;start button y-axis start from 455(bottom) to 395(top)
;start button x-axis start from 760(left) to 1160(right)

;Tutorial button y-axis start from 575(bottom) to 515(top)
;Tutorial button x-axis start from 760(left) to 1160(right)

;LeaderBoard button y-axis start from 695(bottom) to 635(top)
;LeaderBoard button x-axis start from 760(left) to 1160(right)

;function
(define (mouseRegister w x y me)
  (cond
  [(and (and (<= y 455)
             (>= y 395))
        (and (>= x 760)   
             (<= x 1160))
        (and (string=? (world-scene w) "menu")
             (mouse=? me "button-down"))) 
        Lobby]
  [else w]))

;test
(check-expect (mouseRegister (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))) 800 400 "button-down") Lobby)

;=======================================================================================
;***************************** Drawing World + big-bang ********************************
;=======================================================================================

;Purpose: Draws The World
;Contract: drawWorld: world(w) --> image
;function
(define (drawWorld world)
  (cond [(string=? (world-scene world) "menu") 
                    menu]
        [(string=? (world-scene world) "Lobby") 
                    (place-image (Character-skin (world-character world)) 
                                 (ChPos-x (Character-pos (world-character world))) 
                                 (ChPos-y (Character-pos (world-character world))) 
                                 LobbyScene)]
        [else (empty-scene 1920 1080)]))

;test
(check-expect (drawWorld (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) menu)
(check-expect (drawWorld (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) (place-image (Character-skin (make-Character skinOneEast (make-ChPos centerWidth centerHeight))) (ChPos-x (Character-pos (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) (ChPos-y (Character-pos (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) LobbyScene))

;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
;function
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))]
        [(string=? (world-scene world) "Lobby")
                   (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))]
        [else world]))
  
;test
(check-expect (sceneSelector (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) (make-world "menu" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))))
(check-expect (sceneSelector (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight)))) (make-world "Lobby" (make-Character skinOneEast (make-ChPos centerWidth centerHeight))))


;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(on-draw drawWorld)
(on-key moveCharacter)
(on-mouse mouseRegister))

(define x 10)
(test)
