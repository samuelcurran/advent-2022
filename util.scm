(use-modules (ice-9 textual-ports))

; read input file as string list split on newlines
(define
  (read-lines file)
    (string-split
    (get-string-all (open-file file "r"))
    #\newline))
