; load n days of solutions
(map
 load (let ((days 3))
    (map (lambda (day)
          (string-concatenate 
            (list "solutions/day-" (number->string day) ".scm")))
      (iota days 1))))
