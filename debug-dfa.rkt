#lang racket

(require "main.rkt" "comments-dfa.rkt" "dfa.rkt")

;; Test if the comment DFA accepts the inline comment
(define inline-comment "# aquí importamos la librería math")

(displayln "Testing comment DFA with:")
(displayln (format "'~a'" inline-comment))

(for ([dfa comments-dfa-list]
      [i (in-naturals)])
  (displayln (format "DFA ~a accepts: ~a" i (dfa-accepts? dfa inline-comment))))

;; Test the full highlighting process
(define test-tokens '("import" " " "math" " " "# aquí importamos la librería math"))
(define dfa-pairs (list (cons comments-dfa-list "comment")))

(displayln "\nTesting highlighting:")
(for ([token test-tokens])
  (let ([css-class (find-matching-class token dfa-pairs)])
    (displayln (format "Token: '~a' -> Class: ~a" token css-class))))
