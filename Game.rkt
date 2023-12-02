#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;=======================================================================================
;************************************ MENU *********************************************
;=======================================================================================








;=======================================================================================
;******************************* Character & Lobby**************************************
;=======================================================================================
;Character --> image(skin), pos(x,y)
(define-struct pos (x y))
(define-struct Character (skin pos))

;Lobby width & height
(define lobbyWidth 1920)
(define lobbyHeight 1080)

;Starting point
(define LOBBY (make-Character (circle 20 "solid" "green")
                                         (make-pos 960 540)))

;Purpose: Draw The Lobby
;Contract: drawLobby: Character --> image
(define (drawLobby ic)
  (place-image (Character-skin ic)
               (pos-x (Character-pos ic)) (pos-y (Character-pos ic))
               (empty-scene lobbyWidth lobbyHeight)))

;test
(check-expect (drawLobby (make-Character (circle 20 "solid" "green")
                                         (make-pos 250 250)))
              (place-image (circle 20 "solid" "green")
                           250 250
                           (empty-scene 1920 1080)))

;Helper Function To Move Character
(define (updatePosx c x)
  (+ (pos-x (Character-pos c)) x))
(define (updatePosy c y)  
  (+ (pos-y (Character-pos c)) y))

;Purpose: Move The Character
;Contract: moveCharacter: Character, keyboard-input --> image

(define (moveCharacter c ki)
  (cond
    [(or (key=? ki "left") (key=? ki "a")) (make-Character (circle 20 "solid" "blue") (make-pos (updatePosx c -50) (pos-y (Character-pos c))))]
    [(or (key=? ki "right") (key=? ki "d")) (make-Character (circle 20 "solid" "green") (make-pos (updatePosx c 50) (pos-y (Character-pos c))))]
    [(or (key=? ki "up") (key=? ki "w")) (make-Character (circle 20 "solid" "yellow") (make-pos (pos-x (Character-pos c)) (updatePosy c -50)))]
    [(or (key=? ki "down") (key=? ki "s")) (make-Character (circle 20 "solid" "red") (make-pos (pos-x (Character-pos c)) (updatePosy c 50)))]
    [else c]
    ))

;test
(check-expect (moveCharacter (make-Character (circle 20 "solid" "green")
                                             (make-pos 250 250)) "left")
              (make-Character (circle 20 "solid" "blue")
                              (make-pos 200 250)))
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