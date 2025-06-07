#lang racket

(require "dfa.rkt" "keywords-dfa.rkt")

;; Simple test to check if individual words match DFAs
(define test-words '("def" "main" "return" "if"))

(displayln "Testing keywords-dfa with individual words:")
(for ([word test-words])
  (displayln (format "Word '~a' matches keywords-dfa: ~a" word (dfa-accepts? keywords-dfa word))))
