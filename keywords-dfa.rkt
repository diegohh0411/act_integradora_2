#lang typed/racket
(require "dfa.rkt")
(require "utils.rkt")
(define main-dfa
  (dfa
    (set 'main-q0 'main-q1 'main-q2 'main-q3 'main-q4)  
    (set #\m #\a #\i #\n)      
    (hash
      (set 'main-q0) (hash #\m (set 'main-q1))  
      (set 'main-q1) (hash #\a (set 'main-q2))  
      (set 'main-q2) (hash #\i (set 'main-q3))  
      (set 'main-q3) (hash #\n (set 'main-q4))  
      (set 'main-q4) (ann (hash) (HashTable Char (Setof Symbol))))  
    'main-q0                               
    (set 'main-q4)))                       
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
(define in-dfa
  (dfa
    (set 'in-q0 'in-q1 'in-q2)
    (set #\i #\n)
    (hash
      (set 'in-q0) (hash #\i (set 'in-q1))
      (set 'in-q1) (hash #\n (set 'in-q2))
      (set 'in-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'in-q0
    (set 'in-q2)))
(define raise-dfa
  (dfa
    (set 'raise-q0 'raise-q1 'raise-q2 'raise-q3 'raise-q4 'raise-q5)
    (set #\r #\a #\i #\s #\e)
    (hash
      (set 'raise-q0) (hash #\r (set 'raise-q1))
      (set 'raise-q1) (hash #\a (set 'raise-q2))
      (set 'raise-q2) (hash #\i (set 'raise-q3))
      (set 'raise-q3) (hash #\s (set 'raise-q4))
      (set 'raise-q4) (hash #\e (set 'raise-q5))
      (set 'raise-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'raise-q0
    (set 'raise-q5)))
(define True-dfa
  (dfa
    (set 'true-q0 'true-q1 'true-q2 'true-q3 'true-q4)
    (set #\T #\r #\u #\e)
    (hash
      (set 'true-q0) (hash #\T (set 'true-q1))
      (set 'true-q1) (hash #\r (set 'true-q2))
      (set 'true-q2) (hash #\u (set 'true-q3))
      (set 'true-q3) (hash #\e (set 'true-q4))
      (set 'true-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'true-q0
    (set 'true-q4)))
(define class-dfa
  (dfa
    (set 'class-q0 'class-q1 'class-q2 'class-q3 'class-q4 'class-q5)
    (set #\c #\l #\a #\s)
    (hash
      (set 'class-q0) (hash #\c (set 'class-q1))
      (set 'class-q1) (hash #\l (set 'class-q2))
      (set 'class-q2) (hash #\a (set 'class-q3))
      (set 'class-q3) (hash #\s (set 'class-q4))
      (set 'class-q4) (hash #\s (set 'class-q5))
      (set 'class-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'class-q0
    (set 'class-q5)))
(define finally-dfa
  (dfa
    (set 'finally-q0 'finally-q1 'finally-q2 'finally-q3 'finally-q4 'finally-q5 'finally-q6 'finally-q7)
    (set #\f #\i #\n #\a #\l #\y)
    (hash
      (set 'finally-q0) (hash #\f (set 'finally-q1))
      (set 'finally-q1) (hash #\i (set 'finally-q2))
      (set 'finally-q2) (hash #\n (set 'finally-q3))
      (set 'finally-q3) (hash #\a (set 'finally-q4))
      (set 'finally-q4) (hash #\l (set 'finally-q5))
      (set 'finally-q5) (hash #\l (set 'finally-q6))
      (set 'finally-q6) (hash #\y (set 'finally-q7))
      (set 'finally-q7) (ann (hash) (HashTable Char (Setof Symbol))))
    'finally-q0
    (set 'finally-q7)))
(define is-dfa
  (dfa
    (set 'is-q0 'is-q1 'is-q2)
    (set #\i #\s)
    (hash
      (set 'is-q0) (hash #\i (set 'is-q1))
      (set 'is-q1) (hash #\s (set 'is-q2))
      (set 'is-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'is-q0
    (set 'is-q2)))
(define and-dfa
  (dfa
    (set 'and-q0 'and-q1 'and-q2 'and-q3)
    (set #\a #\n #\d)
    (hash
      (set 'and-q0) (hash #\a (set 'and-q1))
      (set 'and-q1) (hash #\n (set 'and-q2))
      (set 'and-q2) (hash #\d (set 'and-q3))
      (set 'and-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'and-q0
    (set 'and-q3)))

(define while-dfa
  (dfa
    (set 'while-q0 'while-q1 'while-q2 'while-q3 'while-q4 'while-q5)
    (set #\w #\h #\i #\l #\e)
    (hash
      (set 'while-q0) (hash #\w (set 'while-q1))
      (set 'while-q1) (hash #\h (set 'while-q2))
      (set 'while-q2) (hash #\i (set 'while-q3))
      (set 'while-q3) (hash #\l (set 'while-q4))
      (set 'while-q4) (hash #\e (set 'while-q5))
      (set 'while-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'while-q0
    (set 'while-q5)))
(define not-dfa
  (dfa
    (set 'not-q0 'not-q1 'not-q2 'not-q3)
    (set #\n #\o #\t)
    (hash
      (set 'not-q0) (hash #\n (set 'not-q1))
      (set 'not-q1) (hash #\o (set 'not-q2))
      (set 'not-q2) (hash #\t (set 'not-q3))
      (set 'not-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'not-q0
    (set 'not-q3)))
(define or-dfa
  (dfa
    (set 'or-q0 'or-q1 'or-q2)
    (set #\o #\r)
    (hash
      (set 'or-q0) (hash #\o (set 'or-q1))
      (set 'or-q1) (hash #\r (set 'or-q2))
      (set 'or-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'or-q0
    (set 'or-q2)))

(define continue-dfa
  (dfa
    (set 'continue-q0 'continue-q1 'continue-q2 'continue-q3 'continue-q4 'continue-q5 'continue-q6 'continue-q7 'continue-q8)
    (set #\c #\o #\n #\t #\i #\u #\e)
    (hash
      (set 'continue-q0) (hash #\c (set 'continue-q1))
      (set 'continue-q1) (hash #\o (set 'continue-q2))
      (set 'continue-q2) (hash #\n (set 'continue-q3))
      (set 'continue-q3) (hash #\t (set 'continue-q4))
      (set 'continue-q4) (hash #\i (set 'continue-q5))
      (set 'continue-q5) (hash #\n (set 'continue-q6))
      (set 'continue-q6) (hash #\u (set 'continue-q7))
      (set 'continue-q7) (hash #\e (set 'continue-q8))
      (set 'continue-q8) (ann (hash) (HashTable Char (Setof Symbol))))
    'continue-q0
    (set 'continue-q8)))
(define for-dfa
  (dfa
    (set 'for-q0 'for-q1 'for-q2 'for-q3)
    (set #\f #\o #\r)
    (hash
      (set 'for-q0) (hash #\f (set 'for-q1))
      (set 'for-q1) (hash #\o (set 'for-q2))
      (set 'for-q2) (hash #\r (set 'for-q3))
      (set 'for-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'for-q0
    (set 'for-q3)))
(define lambda-dfa
  (dfa
    (set 'lambda-q0 'lambda-q1 'lambda-q2 'lambda-q3 'lambda-q4 'lambda-q5 'lambda-q6)
    (set #\l #\a #\m #\b #\d)
    (hash
      (set 'lambda-q0) (hash #\l (set 'lambda-q1))
      (set 'lambda-q1) (hash #\a (set 'lambda-q2))
      (set 'lambda-q2) (hash #\m (set 'lambda-q3))
      (set 'lambda-q3) (hash #\b (set 'lambda-q4))
      (set 'lambda-q4) (hash #\d (set 'lambda-q5))
      (set 'lambda-q5) (hash #\a (set 'lambda-q6))
      (set 'lambda-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'lambda-q0
    (set 'lambda-q6)))
(define try-dfa
  (dfa
    (set 'try-q0 'try-q1 'try-q2 'try-q3)
    (set #\t #\r #\y)
    (hash
      (set 'try-q0) (hash #\t (set 'try-q1))
      (set 'try-q1) (hash #\r (set 'try-q2))
      (set 'try-q2) (hash #\y (set 'try-q3))
      (set 'try-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'try-q0
    (set 'try-q3)))
(define as-dfa
  (dfa
    (set 'as-q0 'as-q1 'as-q2)
    (set #\a #\s)
    (hash
      (set 'as-q0) (hash #\a (set 'as-q1))
      (set 'as-q1) (hash #\s (set 'as-q2))
      (set 'as-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'as-q0
    (set 'as-q2)))
(define from-dfa
  (dfa
    (set 'from-q0 'from-q1 'from-q2 'from-q3 'from-q4)
    (set #\f #\r #\o #\m)
    (hash
      (set 'from-q0) (hash #\f (set 'from-q1))
      (set 'from-q1) (hash #\r (set 'from-q2))
      (set 'from-q2) (hash #\o (set 'from-q3))
      (set 'from-q3) (hash #\m (set 'from-q4))
      (set 'from-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'from-q0
    (set 'from-q4)))
(define nonlocal-dfa
  (dfa
    (set 'nonlocal-q0 'nonlocal-q1 'nonlocal-q2 'nonlocal-q3 'nonlocal-q4 'nonlocal-q5 'nonlocal-q6 'nonlocal-q7 'nonlocal-q8)
    (set #\n #\o #\l #\c #\a #\s)
    (hash
      (set 'nonlocal-q0) (hash #\n (set 'nonlocal-q1))
      (set 'nonlocal-q1) (hash #\o (set 'nonlocal-q2))
      (set 'nonlocal-q2) (hash #\n (set 'nonlocal-q3))
      (set 'nonlocal-q3) (hash #\l (set 'nonlocal-q4))
      (set 'nonlocal-q4) (hash #\o (set 'nonlocal-q5))
      (set 'nonlocal-q5) (hash #\c (set 'nonlocal-q6))
      (set 'nonlocal-q6) (hash #\a (set 'nonlocal-q7))
      (set 'nonlocal-q7) (hash #\l (set 'nonlocal-q8))
      (set 'nonlocal-q8) (ann (hash) (HashTable Char (Setof Symbol))))
    'nonlocal-q0
    (set 'nonlocal-q8)))
(define assert-dfa
  (dfa
    (set 'assert-q0 'assert-q1 'assert-q2 'assert-q3 'assert-q4 'assert-q5 'assert-q6)
    (set #\a #\s #\e #\r #\t)
    (hash
      (set 'assert-q0) (hash #\a (set 'assert-q1))
      (set 'assert-q1) (hash #\s (set 'assert-q2))
      (set 'assert-q2) (hash #\s (set 'assert-q3))
      (set 'assert-q3) (hash #\e (set 'assert-q4))
      (set 'assert-q4) (hash #\r (set 'assert-q5))
      (set 'assert-q5) (hash #\t (set 'assert-q6))
      (set 'assert-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'assert-q0
    (set 'assert-q6)))
(define del-dfa
  (dfa
    (set 'del-q0 'del-q1 'del-q2 'del-q3)
    (set #\d #\e #\l)
    (hash
      (set 'del-q0) (hash #\d (set 'del-q1))
      (set 'del-q1) (hash #\e (set 'del-q2))
      (set 'del-q2) (hash #\l (set 'del-q3))
      (set 'del-q3) (ann (hash) (HashTable Char (Setof Symbol))))
    'del-q0
    (set 'del-q3)))
(define global-dfa
  (dfa
    (set 'global-q0 'global-q1 'global-q2 'global-q3 'global-q4 'global-q5 'global-q6)
    (set #\g #\l #\o #\b #\a)
    (hash
      (set 'global-q0) (hash #\g (set 'global-q1))
      (set 'global-q1) (hash #\l (set 'global-q2))
      (set 'global-q2) (hash #\o (set 'global-q3))
      (set 'global-q3) (hash #\b (set 'global-q4))
      (set 'global-q4) (hash #\a (set 'global-q5))
      (set 'global-q5) (hash #\l (set 'global-q6))
      (set 'global-q6) (ann (hash) (HashTable Char (Setof Symbol))))
    'global-q0
    (set 'global-q6)))
(define with-dfa
  (dfa
    (set 'with-q0 'with-q1 'with-q2 'with-q3 'with-q4)
    (set #\w #\i #\t #\h)
    (hash
      (set 'with-q0) (hash #\w (set 'with-q1))
      (set 'with-q1) (hash #\i (set 'with-q2))
      (set 'with-q2) (hash #\t (set 'with-q3))
      (set 'with-q3) (hash #\h (set 'with-q4))
      (set 'with-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'with-q0
    (set 'with-q4)))
(define async-dfa
  (dfa
    (set 'async-q0 'async-q1 'async-q2 'async-q3 'async-q4 'async-q5)
    (set #\a #\s #\y #\n #\c)
    (hash
      (set 'async-q0) (hash #\a (set 'async-q1))
      (set 'async-q1) (hash #\s (set 'async-q2))
      (set 'async-q2) (hash #\y (set 'async-q3))
      (set 'async-q3) (hash #\n (set 'async-q4))
      (set 'async-q4) (hash #\c (set 'async-q5))
      (set 'async-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'async-q0
    (set 'async-q5)))
(define elif-dfa
  (dfa
    (set 'elif-q0 'elif-q1 'elif-q2 'elif-q3 'elif-q4)
    (set #\e #\l #\i #\f)
    (hash
      (set 'elif-q0) (hash #\e (set 'elif-q1))
      (set 'elif-q1) (hash #\l (set 'elif-q2))
      (set 'elif-q2) (hash #\i (set 'elif-q3))
      (set 'elif-q3) (hash #\f (set 'elif-q4))
      (set 'elif-q4) (ann (hash) (HashTable Char (Setof Symbol))))
    'elif-q0
    (set 'elif-q4)))
(define yield-dfa
  (dfa
    (set 'yield-q0 'yield-q1 'yield-q2 'yield-q3 'yield-q4 'yield-q5)
    (set #\y #\i #\e #\l #\d)
    (hash
      (set 'yield-q0) (hash #\y (set 'yield-q1))
      (set 'yield-q1) (hash #\i (set 'yield-q2))
      (set 'yield-q2) (hash #\e (set 'yield-q3))
      (set 'yield-q3) (hash #\l (set 'yield-q4))
      (set 'yield-q4) (hash #\d (set 'yield-q5))
      (set 'yield-q5) (ann (hash) (HashTable Char (Setof Symbol))))
    'yield-q0
    (set 'yield-q5)))

(define keywords-dfa-list (list 
                            main-dfa def-dfa return-dfa if-dfa 
                            False-dfa await-dfa else-dfa import-dfa 
                            pass-dfa None-dfa break-dfa except-dfa
                            in-dfa raise-dfa True-dfa class-dfa 
                            finally-dfa is-dfa and-dfa while-dfa
                            not-dfa or-dfa continue-dfa for-dfa
                            lambda-dfa try-dfa as-dfa from-dfa
                            nonlocal-dfa assert-dfa del-dfa
                            global-dfa with-dfa async-dfa
                            elif-dfa yield-dfa))
(provide keywords-dfa-list)