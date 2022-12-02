(load "../util.scm")

; https://adventofcode.com/2022/day/2

; pairs of moves. example: (("A" "X") ("B" "Y"))
(define strategy-guide
  (map
    (lambda (game)
      (string-split game #\space))
    (read-lines "inputs/day-2.txt")))

; no need to get fancy. enumerate all combinations
(define
  (roshambo game)
    (cond
      ((equal? '("A" "X") game) (+ 3 1)) ; rock ties rock, draw
      ((equal? '("A" "Y") game) (+ 6 2)) ; rock loses to paper, win
      ((equal? '("A" "Z") game) (+ 0 3)) ; rock beats scissors, lose
      ((equal? '("B" "X") game) (+ 0 1)) ; paper beats rock, lose
      ((equal? '("B" "Y") game) (+ 3 2)) ; paper ties paper, draw
      ((equal? '("B" "Z") game) (+ 6 3)) ; paper loses to scissors, win
      ((equal? '("C" "X") game) (+ 6 1)) ; scissors loses to rock, win
      ((equal? '("C" "Y") game) (+ 0 2)) ; scissors beats paper, lose
      ((equal? '("C" "Z") game) (+ 3 3)))) ; scissors ties scissors, draw

; part one
; (apply + (map roshambo strategy-guide)) => 14531 ☆

(define
  (revised-roshambo game)
    (cond
      ; score operands reversed from prev func
      ((equal? '("A" "X") game) (+ 3 0)) ; select scissors, lose
      ((equal? '("A" "Y") game) (+ 1 3)) ; select rock, draw
      ((equal? '("A" "Z") game) (+ 2 6)) ; select paper, win
      ((equal? '("B" "X") game) (+ 1 0)) ; select rock, lose
      ((equal? '("B" "Y") game) (+ 2 3)) ; select paper, draw
      ((equal? '("B" "Z") game) (+ 3 6)) ; select scissors, win
      ((equal? '("C" "X") game) (+ 2 0)) ; select paper, lose
      ((equal? '("C" "Y") game) (+ 3 3)) ; select scissors, draw
      ((equal? '("C" "Z") game) (+ 1 6)))) ; select rock, win

; part two
; (apply + (map revised-roshambo strategy-guide)) => 11258 ☆
