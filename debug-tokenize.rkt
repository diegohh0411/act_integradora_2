#lang racket

(require "main.rkt")

;; Test the tokenize function specifically
(define test-line "import math # aquí importamos la librería math")
(define tokens (tokenize test-line))

(displayln "Tokenizing:")
(displayln test-line)
(displayln "\nTokens:")
(for ([token tokens]
      [i (in-naturals)])
  (displayln (format "~a: '~a'" i token)))
