#lang typed/racket

(require "dfa.rkt")

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

(provide main-dfa)