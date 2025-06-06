#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")

;; Define the DFA for the regex "main".
(define main-dfa
  (dfa
    (set 'main-q0 'main-q1 'main-q2 'main-q3 'main-q4)  ;; States
    (set #\m #\a #\i #\n)      ;; Alphabet
    (hash
      (set 'main-q0) (hash #\m (set 'main-q1))  ;; Transitions from q0
      (set 'main-q1) (hash #\a (set 'main-q2))  ;; Transitions from q1
      (set 'main-q2) (hash #\i (set 'main-q3))  ;; Transitions from q2
      (set 'main-q3) (hash #\n (set 'main-q4))  ;; Transitions from q3
      (set 'main-q4) (ann (hash) (HashTable Char (Setof Symbol))))  ;; Empty hash with explicit type
    'main-q0                               ;; Start state
    (set 'main-q4)))                       ;; Accept states

;; Define DFA for Python reserved words
(define def-dfa
  (dfa
    (set 'def-q0 'def-q1 'def-q2 'def-q3)
    (set #\d #\e #\f)
    (hash
      (set 'def-q0) (hash #\d (set 'def-q1))
      (set 'def-q1) (hash #\e (set 'def-q2))
      (set 'def-q2) (hash #\f (set 'def-q3))
      (set 'def-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'def-q0
    (set 'def-q3)))

(define return-dfa
  (dfa
    (set 'ret-q0 'ret-q1 'ret-q2 'ret-q3 'ret-q4 'ret-q5 'ret-q6 'ret-q7)
    (set #\r #\e #\t #\u #\r #\n)
    (hash
      (set 'ret-q0) (hash #\r (set 'ret-q1))
      (set 'ret-q1) (hash #\e (set 'ret-q2))
      (set 'ret-q2) (hash #\t (set 'ret-q3))
      (set 'ret-q3) (hash #\u (set 'ret-q4))
      (set 'ret-q4) (hash #\r (set 'ret-q5))
      (set 'ret-q5) (hash #\n (set 'ret-q6))
      (set 'ret-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'ret-q0
    (set 'ret-q6)))

(define if-dfa
  (dfa
    (set 'if-q0 'if-q1 'if-q2 'if-q3)
    (set #\i #\f)
    (hash
      (set 'if-q0) (hash #\i (set 'if-q1))
      (set 'if-q1) (hash #\f (set 'if-q2))
      (set 'if-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'if-q0
    (set 'if-q2)))

;; Concatenar todos los DFA definidos en este archivo
(define keywords-dfa
  (concatenate-dfas (list main-dfa def-dfa return-dfa if-dfa)))

(displayln (dfa-accepts? main-dfa "main"))
(displayln (dfa-accepts? keywords-dfa "main"))

(provide keywords-dfa)