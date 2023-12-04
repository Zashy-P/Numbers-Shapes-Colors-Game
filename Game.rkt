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



;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================
;Purpose: Draws a button with given string and x,y coordinates
;Contract: drawButton: string, pos(x), pos(y) --> image
;we can change the font & box(button) shape to our liking later on
;function
(define (drawButton string)
  (overlay (text/font string 18 "indigo"
           #f 'modern 'italic 'normal #f) 
           (rectangle 200 30 "outline" "green")))

;test
(check-expect (drawButton "Start" )
              (overlay (text/font "Start" 18 "indigo"
              #f 'modern 'italic 'normal #f) 
              (rectangle 200 30 "outline" "green")))

;defining the start, character locker and leaderboard buttons
(define startButton (drawButton "Start"))
(define ChLockerButton (drawButton "Character Locker"))
(define leaderBoard (drawButton "LeaderBoard"))

;Purpose: Draws the menu
;Contract: menu --> image
;function
(define menu 
  (place-image (above startButton ChLockerButton leaderBoard)
               960 540 
               (empty-scene 1920 1080)))




; I have initialWorld in menu cuz its basically the menu
(define initialWorld (make-world "menu" (make-Character (circle 20 "solid" "green") (make-ChPos 960 540))))

;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;defines the Lobby scene later on we will have a function that selects scenes for now we can select scenes manually
(define LobbyWidth 1920)
(define LobbyHeight 1080)
(define LobbyScene (empty-scene LobbyWidth LobbyHeight))
(define Lobby (make-world "Lobby" (make-Character (circle 20 "solid" "green") (make-ChPos 960 540))))
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
  (if (string=? (world-scene w) "menu") "controls needed" ;we need to add controls on menu stuff                                           
  (cond
    [(or (key=? ki "left") (key=? ki "a")) 
     (make-world "Lobby" 
                 (make-Character (circle 20 "solid" "blue") 
                                 (make-ChPos (updateChPosx (world-character w) (* ChSpeed -1)) 
                                             (ChPos-y (Character-pos (world-character w))))))]
    [(or (key=? ki "right") (key=? ki "d")) 
     (make-world "Lobby" 
                 (make-Character (circle 20 "solid" "green") 
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
    )))

;=======================================================================================
;************************************ Mouse-Input **************************************
;=======================================================================================
;Purpose: Register the mouse input on the buttons
;Contract: mouseRegister: world(w), pos(x), pos(y) mouse-event(me)--> image
(define (mouseRegister w x y me)
  (...))




;=======================================================================================
;***************************** Drawing World + big-bang ********************************
;=======================================================================================
(define (drawWorld scene)
  (cond [(string=? (world-scene scene) "menu") menu]
        [(string=? (world-scene scene) "Lobby") (place-image (Character-skin (world-character scene)) (ChPos-x (Character-pos (world-character scene))) (ChPos-y (Character-pos (world-character scene))) LobbyScene)]
        [else (empty-scene 1920 1080)]))

;since its all under the same struct we can easily change scenes we just need a function to detirmine 
; when to use which scene and put it next to big-bang rn i  will have both scenes in diff big-bangs
;  untill we make that function
(big-bang initialWorld
(on-draw drawWorld))

(big-bang Lobby
(on-draw drawWorld)
(on-key moveCharacter))
(test)
               