#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")

;; Define the DFA for the regex "main".
(define main-dfa
  (dfa
    (set 'q0 'q1 'q2 'q3 'q4)  ;; States
    (set #\m #\a #\i #\n)      ;; Alphabet
    (hash
      (set 'q0) (hash #\m (set 'q1))  ;; Transitions from q0
      (set 'q1) (hash #\a (set 'q2))  ;; Transitions from q1
      (set 'q2) (hash #\i (set 'q3))  ;; Transitions from q2
      (set 'q3) (hash #\n (set 'q4))  ;; Transitions from q3
      (set 'q4) (ann (hash) (HashTable Char (Setof Symbol))))  ;; Empty hash with explicit type
    'q0                               ;; Start state
    (set 'q4)))                       ;; Accept states

;; Define DFA for Python reserved words
(define def-dfa
  (dfa
    (set 'q0 'q1 'q2 'q3)
    (set #\d #\e #\f)
    (hash
      (set 'q0) (hash #\d (set 'q1))
      (set 'q1) (hash #\e (set 'q2))
      (set 'q2) (hash #\f (set 'q3))
      (set 'q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'q0
    (set 'q3)))

(define return-dfa
  (dfa
    (set 'q0 'q1 'q2 'q3 'q4 'q5 'q6 'q7)
    (set #\r #\e #\t #\u #\r #\n)
    (hash
      (set 'q0) (hash #\r (set 'q1))
      (set 'q1) (hash #\e (set 'q2))
      (set 'q2) (hash #\t (set 'q3))
      (set 'q3) (hash #\u (set 'q4))
      (set 'q4) (hash #\r (set 'q5))
      (set 'q5) (hash #\n (set 'q6))
      (set 'q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'q0
    (set 'q6)))

(define if-dfa
  (dfa
    (set 'q0 'q1 'q2 'q3)
    (set #\i #\f)
    (hash
      (set 'q0) (hash #\i (set 'q1))
      (set 'q1) (hash #\f (set 'q2))
      (set 'q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'q0
    (set 'q2)))

;; Concatenar todos los DFA definidos en este archivo
(define keywords-dfa
  (concatenate-dfas (list main-dfa def-dfa return-dfa if-dfa)))

(provide keywords-dfa)