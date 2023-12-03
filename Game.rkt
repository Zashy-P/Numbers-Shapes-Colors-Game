#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)




;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================
;note that if u r using VSC you wont be able to see the images so u have to run it in DrRacket IDE
; I code in VSC then just paste the code in DrRacket to see the images but i think we will be able
;  to see them in VSC when we use big-bang on-draw function

;I am thinking should we do a struct for a pointer contating the pointer image and x,y coordinates
; and then we can use the pointer to select the button

;Pointer --> image, pos(x,y)
(define-struct pointer (image pos))
(define-struct pointerPos (x y))

;Starting point for the pointer
;(define POINTER (...)) Just got a bit lazy to draw the pointer so i will do it later

;Purpose: Draws a pointer with given x,y coordinates
;Contract: drawPointer: imgage(img) pos(x), pos(y) --> image
(define (drawPointer img x y)
  (...))
;test


;Purpose: Moves the pointer using mouse input
;Contract: movePointer: pointer, mouse-input --> image
(define (movePointer p mi)
  (...))



;Purpose: Draws a button with given string and x,y coordinates
;Contract: drawButton: string, pos(x), pos(y) --> image
;we can change the font & box(button) shape to our liking later on
(define (drawButton string)
  (overlay (text/font string 18 "indigo"
             #f 'modern 'italic 'normal #f) (rectangle 200 30 "outline" "green")))

;test
(check-expect (drawButton "Start" )
              (overlay (text/font "Start" 18 "indigo"
             #f 'modern 'italic 'normal #f) (rectangle 200 30 "outline" "green")))

;defining the start, character locker and leaderboard buttons
(define startButton (drawButton "Start"))
(define ChLockerButton (drawButton "Character Locker"))
(define leaderBoard (drawButton "LeaderBoard"))

;Purpose: Draws the menu
;Contract: menu: button1, button2, button3 --> image
(define (menu b1 b2 b3)
  (place-image (above b1 b2 b3) 960 540 (empty-scene 1920 1080)))
(menu startButton ChLockerButton leaderBoard)

;(big-bang POINTER ;Still did not finish the functions so i commented it out
    ;(on-draw menu)
    ;(on-mouse movePointer))









;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;Character --> image(skin), pos(x,y)
(define-struct chPos (x y))
(define-struct Character (skin pos))

;Lobby width & height
(define lobbyWidth 1920)
(define lobbyHeight 1080)

;Starting point
(define LOBBY (make-Character (circle 20 "solid" "green")
                                         (make-chPos 960 540)))

;Purpose: Draw The Lobby
;Contract: drawLobby: Character --> image
(define (drawLobby ic)
  (place-image (Character-skin ic)
               (chPos-x (Character-pos ic)) (chPos-y (Character-pos ic))
               (empty-scene lobbyWidth lobbyHeight)))

;test
(check-expect (drawLobby (make-Character (circle 20 "solid" "green")
                                         (make-chPos 250 250)))
              (place-image (circle 20 "solid" "green")
                           250 250
                           (empty-scene 1920 1080)))

;Helper Function To Move Character
(define (updatePosx c x)
  (+ (chPos-x (Character-pos c)) x))
(define (updatePosy c y)  
  (+ (
    chPos-y (Character-pos c)) y))

;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: Character, keyboard-input --> image

(define (moveCharacter c ki)
  (cond
    [(or (key=? ki "left") (key=? ki "a")) (make-Character (circle 20 "solid" "blue") (make-chPos (updatePosx c -50) (chPos-y (Character-pos c))))]
    [(or (key=? ki "right") (key=? ki "d")) (make-Character (circle 20 "solid" "green") (make-chPos (updatePosx c 50) (chPos-y (Character-pos c))))]
    [(or (key=? ki "up") (key=? ki "w")) (make-Character (circle 20 "solid" "yellow") (make-chPos (chPos-x (Character-pos c)) (updatePosy c -50)))]
    [(or (key=? ki "down") (key=? ki "s")) (make-Character (circle 20 "solid" "red") (make-chPos (chPos-x (Character-pos c)) (updatePosy c 50)))]
    [else c]
    ))

;test
(check-expect (moveCharacter (make-Character (circle 20 "solid" "green")
                                             (make-chPos 250 250)) "left")
              (make-Character (circle 20 "solid" "blue")
                              (make-chPos 200 250)))
(test)
;;;; currentStatus --> Current Position And Image Of The Character
;big-bang Draws The lobby And Add Movement Functionality
;(define currentStatus

(big-bang LOBBY
    (on-draw drawLobby)
    (on-key moveCharacter))
;)

;Displays the scenes
(define (sceneSelector Lobby numberLand colorLand shapeLand)
  ...)