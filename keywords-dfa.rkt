#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")

;; Define the DFA for the regex "main" (exactly the word "main").
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

(define False-dfa
  (dfa
    (set 'false-q0 'false-q1 'false-q2 'false-q3 'false-q4)
    (set #\F #\a #\l #\s #\e)
    (hash
      (set 'false-q0) (hash #\F (set 'false-q1))
      (set 'false-q1) (hash #\a (set 'false-q2))
      (set 'false-q2) (hash #\l (set 'false-q3))
      (set 'false-q3) (hash #\s (set 'false-q4))
      (set 'false-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'false-q0
    (set 'false-q4)))

(define await-dfa
  (dfa
    (set 'await-q0 'await-q1 'await-q2 'await-q3 'await-q4)
    (set #\a #\w #\a #\i #\t)
    (hash
      (set 'await-q0) (hash #\a (set 'await-q1))
      (set 'await-q1) (hash #\w (set 'await-q2))
      (set 'await-q2) (hash #\a (set 'await-q3))
      (set 'await-q3) (hash #\i (set 'await-q4))
      (set 'await-q4) (hash #\t (set 'await-q4))
      (set 'await-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'await-q0
    (set 'await-q4)))

(define else-dfa
  (dfa
    (set 'else-q0 'else-q1 'else-q2 'else-q3 'else-q4)
    (set #\e #\l #\s #\e)
    (hash
      (set 'else-q0) (hash #\e (set 'else-q1))
      (set 'else-q1) (hash #\l (set 'else-q2))
      (set 'else-q2) (hash #\s (set 'else-q3))
      (set 'else-q3) (hash #\e (set 'else-q4))
      (set 'else-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'else-q0
    (set 'else-q4)))

(define import-dfa
  (dfa
    (set 'import-q0 'import-q1 'import-q2 'import-q3 'import-q4 'import-q5 'import-q6)
    (set #\i #\m #\p #\o #\r #\t)
    (hash
      (set 'import-q0) (hash #\i (set 'import-q1))
      (set 'import-q1) (hash #\m (set 'import-q2))
      (set 'import-q2) (hash #\p (set 'import-q3))
      (set 'import-q3) (hash #\o (set 'import-q4))
      (set 'import-q4) (hash #\r (set 'import-q5))
      (set 'import-q5) (hash #\t (set 'import-q6))
      (set 'import-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'import-q0
    (set 'import-q6)))

(define pass-dfa
  (dfa
    (set 'pass-q0 'pass-q1 'pass-q2 'pass-q3 'pass-q4)
    (set #\p #\a #\s)
    (hash
      (set 'pass-q0) (hash #\p (set 'pass-q1))
      (set 'pass-q1) (hash #\a (set 'pass-q2))
      (set 'pass-q2) (hash #\s (set 'pass-q3))
      (set 'pass-q3) (hash #\s (set 'pass-q4))
      (set 'pass-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'pass-q0
    (set 'pass-q4)))

(define None-dfa
  (dfa
    (set 'none-q0 'none-q1 'none-q2 'none-q3 'none-q4)
    (set #\N #\o #\n #\e)
    (hash
      (set 'none-q0) (hash #\N (set 'none-q1))
      (set 'none-q1) (hash #\o (set 'none-q2))
      (set 'none-q2) (hash #\n (set 'none-q3))
      (set 'none-q3) (hash #\e (set 'none-q4))
      (set 'none-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'none-q0
    (set 'none-q4)))

(define break-dfa
  (dfa
    (set 'break-q0 'break-q1 'break-q2 'break-q3 'break-q4 'break-q5)
    (set #\b #\r #\e #\a #\k)
    (hash
      (set 'break-q0) (hash #\b (set 'break-q1))
      (set 'break-q1) (hash #\r (set 'break-q2))
      (set 'break-q2) (hash #\e (set 'break-q3))
      (set 'break-q3) (hash #\a (set 'break-q4))
      (set 'break-q4) (hash #\k (set 'break-q5))
      (set 'break-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'break-q0
    (set 'break-q5)))

(define except-dfa
  (dfa
    (set 'except-q0 'except-q1 'except-q2 'except-q3 'except-q4 'except-q5 'except-q6)
    (set #\e #\x #\c #\p #\t)
    (hash
      (set 'except-q0) (hash #\e (set 'except-q1))
      (set 'except-q1) (hash #\x (set 'except-q2))
      (set 'except-q2) (hash #\c (set 'except-q3))
      (set 'except-q3) (hash #\e (set 'except-q4))
      (set 'except-q4) (hash #\p (set 'except-q5))
      (set 'except-q5) (hash #\t (set 'except-q6))
      (set 'except-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'except-q0
    (set 'except-q6)))




;; Concatenar todos los DFA definidos en este archivo
(define keywords-dfa-list (list 
                            main-dfa def-dfa return-dfa if-dfa 
                            False-dfa await-dfa else-dfa import-dfa 
                            pass-dfa None-dfa break-dfa except-dfa
                            ))

(provide keywords-dfa-list)