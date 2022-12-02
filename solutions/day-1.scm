(load "../util.scm")

; https://adventofcode.com/2022/day/1

; empty lines are represented as #f
; add newline to input
(define
  (transform-input input)
    (map string->number
      (read-lines input)))

; return list with first two elements summed
(define
  (sum-first-two nums)
    (cond
      ; (sum-first-two '(1)) => (1)
      ((< (length nums) 2) nums)
      ; (v '(1 2 3)) => (3 3)
      (else
        (cons
          (+ (car nums) (car (cdr nums)))
          (cdr (cdr nums))))))

; sum calories for particular elf
(define
  (elf-calories cals)
    (cond
      ; return list if first element is #f
      ; (elf-calories '(#f 1)) => (#f 1)
      ((eq? #f (car cals)) cals)
      ; stop recursion if second element is #f
      ; (elf-calories '(1 #f 2)) => (1 #f 2)
      ((eq? #f (car (cdr cals))) cals)
      ; recursively sum calories up to #f
      ; (elf-calories '(1 2 3 #f 4)) => (6 #f 4)
      (else (elf-calories (sum-first-two cals)))))

; sum calories for all elves
(define
  (sum-calories cals)
  (cond
    ; stop recursion if input list is empty
    ; (sum-calories '((1) ())) => (1)
    ((null? (car (reverse cals)))
      (car cals))
    ; take first sum, drop #f, and create list to collect sums with initial sum
    ; create list containing both the collection list and input list minus first sum
    ; then recurse
    ; first iteration:
    ;   (sum-calories
    ;     '(1 2 #f 3 4 #f 5 #f)) => (
    ;                                          (3)                <- collection list
    ;                                          (3 4 #f 5 #f)  <- remainder of input list
    ;                                        )
    ((not (list? (car cals)))
      (sum-calories
        (list
          (list-head (elf-calories cals) 1) ; drop #f
          (list-tail (elf-calories cals) 2))))
    ; continue to collect sums
    (else
      (sum-calories
        (list
          (append
            (car cals)
            (list-head (elf-calories (car (cdr cals))) 1)) ; sum next subset of cals
          (list-tail (elf-calories (car (cdr cals))) 2))))))

; part one solution
; (apply max (sum-calories (transform-input "inputs/day-1.txt"))) => 69528 ☆

(define
  (sum-top-3 input)
    (apply +
      (list-head
        (reverse
          (sort
            (sum-calories (transform-input input)) (lambda (x y) (< x y))))
        3)))

; part two solution
; (sum-top-3 "inputs/day-1.txt") => 206152 ☆
