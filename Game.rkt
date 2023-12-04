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

;Pointer --> image, pos(x,y)
(define-struct pointer (img pos))
(define-struct pointerPos (x y))

;Starting point for the pointer
(define POINTER (make-pointer (triangle 50 "solid" "red")
                              (make-pointerPos 960 540)))

;Purpose: Moves the pointer using mouse input
;Contract: movePointer: pointer, mouse-input --> image
;function
(define (movePointer worldState x y event) ; I am not sure of the parameters but these r the parameters
  (...))                                   ; that big-bang on-mouse requires i am so lost i tried to
                                           ; to make it work but i failed

;test
;...

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
;Contract: menu: pointer  --> image
;function
(define (menu pointer)
  (place-image (overlay (pointer-img pointer) 
               (above startButton ChLockerButton leaderBoard)) 
               960 540 
               (empty-scene 1920 1080)))

;test
(check-expect (menu (make-pointer (triangle 20 "solid" "red") (make-pointerPos 960 540))) 
(place-image (overlay (triangle 20 "solid" "red") 
             (above startButton ChLockerButton leaderBoard)) 
             960 540 
             (empty-scene 1920 1080)))

;big-bang Draws The menu And Adds Movement Functionality
(big-bang POINTER 
    (on-draw menu)
    ;(on-mouse movePointer)
    )











;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;Character --> image(skin), pos(x,y)
(define-struct chPos (x y))
(define-struct Character (skin pos))

;Defining the lobby's width and height and scene
(define lobbyWidth 1920)
(define lobbyHeight 1080)
(define lobbyScene (empty-scene lobbyWidth lobbyHeight))

;Starting character
(define c1 (make-Character (circle 20 "solid" "green")
                              (make-chPos 960 540)))

;Purpose: Draw The Lobby
;Contract: drawLobby: Character --> image
(define (drawLobby ic)
  (place-image (Character-skin ic)
               (chPos-x (Character-pos ic)) (chPos-y (Character-pos ic))
               lobbyScene))

;test
(check-expect (drawLobby (make-Character (circle 20 "solid" "green")
                                         (make-chPos 250 250)))
              (place-image (circle 20 "solid" "green")
                           250 250
                           (empty-scene 1920 1080)))

;defines character speed
(define ChSpeed 50)
;helper function to update the x,y coordinates of the Character
(define (updateChPosx c cs)
  (+ (chPos-x (Character-pos c)) cs))
(define (updateChPosy c cs)  
  (+ (chPos-y (Character-pos c)) cs))
;Purpose: Move The Character & change the image of the character to the direction its facing 
;Contract: moveCharacter: Character(c), keyboard-input(ki) --> image
(define (moveCharacter c ki)
  (cond
    [(or (key=? ki "left") (key=? ki "a")) (make-Character (circle 20 "solid" "blue") (make-chPos (updateChPosx c (* ChSpeed -1)) (chPos-y (Character-pos c))))]
    [(or (key=? ki "right") (key=? ki "d")) (make-Character (circle 20 "solid" "green") (make-chPos (updateChPosx c ChSpeed) (chPos-y (Character-pos c))))]
    [(or (key=? ki "up") (key=? ki "w")) (make-Character (circle 20 "solid" "yellow") (make-chPos (chPos-x (Character-pos c)) (updateChPosy c (* ChSpeed -1))))]
    [(or (key=? ki "down") (key=? ki "s")) (make-Character (circle 20 "solid" "red") (make-chPos (chPos-x (Character-pos c)) (updateChPosy c ChSpeed)))]
    [else c]
    ))

;test
(check-expect (moveCharacter (make-Character (circle 20 "solid" "green")
                                             (make-chPos 250 250)) "left")
              (make-Character (circle 20 "solid" "blue")
                              (make-chPos 200 250)))

;;;; currentStatus --> Current Position And Image Of The Character
;big-bang Draws The lobby And Add Movement Functionality
;(define currentStatus

(big-bang c1
    (on-draw drawLobby)
    (on-key moveCharacter))
;)

;Displays the scenes
(define (sceneSelector Lobby numberLand colorLand shapeLand)
  ...)

(test)