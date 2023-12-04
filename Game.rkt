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
(define catSkinEast (bitmap "C:/Users/abdul/Downloads/Cat pfp.png"))


;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================
; Button --> image,pos(x,y)
(define-struct button (image pos))
(define-struct buttonPos(x y))


;Purpose: Draws a button with given string and x,y coordinates
;Contract: drawButton: string, pos(x), pos(y) --> image
;we can change the font & box(button) shape to our liking later on
;function
(define (drawButton string)
  (overlay (text/font string 18 "indigo"
           #f 'modern 'italic 'normal #f) 
           (rectangle 200 30 "outline" "Light Steel Blue")))

;test
(check-expect (drawButton "Start" )
              (overlay (text/font "Start" 18 "indigo"
              #f 'modern 'italic 'normal #f) 
              (rectangle 200 30 "outline" "green")))

;defining the start, character locker and leaderboard buttons
(define startButton (make-button 
                    (drawButton "Start") 
                    (make-buttonPos 960 540)))
(define ChLockerButton (drawButton "Character Locker"))
(define leaderBoard (drawButton "LeaderBoard"))

;Purpose: Draws the menu
;Contract: menu --> image
;function
(define menu 
  (place-image (above (button-image startButton) ChLockerButton leaderBoard)
               960 540 
               (empty-scene 1920 1080)))




; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character catSkinEast (make-ChPos 960 540))))

;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;defines the Lobby scene later on we will have a function that selects scenes for now we can select scenes manually
(define LobbyWidth 1920)
(define LobbyHeight 1080)
(define LobbyScene (empty-scene LobbyWidth LobbyHeight))
(define Lobby (make-world "Lobby" (make-Character catSkinEast (make-ChPos 960 540))))
;defines character speed
(define ChSpeed 50)
;helper function to update the x,y coordinates of the Character
(define (updateChPosx c cs)
  (+ (ChPos-x (Character-pos c)) cs))
(define (updateChPosy c cs)  
  (+ (ChPos-y (Character-pos c)) cs))
;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: world(w), keyboard-input(ki) --> image
(define (moveCharacter w ki)
  (if (string=? (world-scene w) "Lobby")                                          
  (cond
    [(or (key=? ki "left") (key=? ki "a")) 
     (make-world "Lobby" 
                 (make-Character (circle 20 "solid" "blue") 
                                 (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "right") (key=? ki "d")) 
     (make-world "Lobby" 
                 (make-Character catSkinEast 
                                 (make-ChPos (updateChPosx (world-character w) ChSpeed) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "up") (key=? ki "w")) 
     (make-world "Lobby" 
                 (make-Character (circle 20 "solid" "yellow") 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) (* ChSpeed -1)))))]
    [(or (key=? ki "down") (key=? ki "s")) 
     (make-world "Lobby" 
                 (make-Character (circle 20 "solid" "red") 
                                 (make-ChPos (ChPos-x (Character-pos (world-character w))) 
                                             (updateChPosy (world-character w) ChSpeed))))]
    [else w]
    )w))

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================
;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image
;we should add the pos condition for each button later on when we design the buttons image properly
(define (mouseRegister w x y me)
  (cond
  [(and (string=? (world-scene w) "menu")
        (mouse=? me "button-down")) 
        Lobby]
  [else w]))




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


;Purpose: selects the scene
;contract: sceneSelector: world(w) --> world(w)
(define (sceneSelector world)
  (cond [(string=? (world-scene world) "menu")
                   (make-world "menu" (make-Character catSkinEast (make-ChPos 960 540)))]
        [(string=? (world-scene world) "Lobby")
                   (make-world "Lobby" (make-Character catSkinEast (make-ChPos 960 540)))]
        [else world]))
  
;test
(check-expect (sceneSelector (make-world "menu" (make-Character catSkinEast (make-ChPos 960 540)))) (make-world "menu" (make-Character catSkinEast (make-ChPos 960 540))))



;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang (sceneSelector initialWorld)
(on-draw drawWorld)
(on-key moveCharacter)
(on-mouse mouseRegister))

(test)