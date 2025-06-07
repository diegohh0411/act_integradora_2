#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")

(define arithmetic-dfa
  (dfa
    (set 'arith-q0 'arith-q1 'arith-q2) ;; States
    (set #\+ #\- #\* #\/ #\% )          ;; Alphabet (chars that start operators)
    (hash
      ;; From start, see any single-char operator
      (set 'arith-q0)
        (hash #\+ (set 'arith-q1)
              #\- (set 'arith-q1)
              #\* (set 'arith-q1)
              #\/ (set 'arith-q1)
              #\% (set 'arith-q1))

      ;; For * or / after first char, might accept second char * or / (for ** and //)
      (set 'arith-q1)
        (hash #\* (set 'arith-q2)  ;; ** exponentiation
              #\/ (set 'arith-q2)) ;; // floor division

      ;; Accept state for two-char operators
      (set 'arith-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'arith-q0                   ;; Start state
    (set 'arith-q1 'arith-q2))) ;; Accept states

(define comparison-dfa
  (dfa
    (set 'comp-q0 'comp-q1 'comp-q2)  ;; States
    (set #\< #\> #\= #\!)              ;; Alphabet
    (hash
      ;; From start, see any single-char operator
      (set 'comp-q0)
        (hash #\< (set 'comp-q1)
              #\> (set 'comp-q1)
              #\= (set 'comp-q1)
              #\! (set 'comp-q1))

      ;; After < or > or = or ! can have =
      (set 'comp-q1)
        (hash #\= (set 'comp-q2))

      ;; Accept state for two-char operators like <=, >=, ==, !=
      (set 'comp-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'comp-q0                    ;; Start state
    (set 'comp-q1 'comp-q2)))   ;; Accept states

(define assignment-dfa
  (dfa
    (set 'assign-q0 'assign-q1 'assign-q2 'assign-q3 'assign-q4)  ;; States
    (set #\= #\+ #\- #\* #\/ #\% #\& #\| #\^ #\> #\<)              ;; Alphabet
    (hash
      ;; From start, accept '=' for simple assignment
      (set 'assign-q0) (hash 
                         #\= (set 'assign-q1)
                         #\+ (set 'assign-q2)
                         #\- (set 'assign-q2)
                         #\* (set 'assign-q2)
                         #\/ (set 'assign-q2)
                         #\% (set 'assign-q2)
                         #\& (set 'assign-q2)
                         #\| (set 'assign-q2)
                         #\^ (set 'assign-q2)
                         #\> (set 'assign-q3)
                         #\< (set 'assign-q3))

      ;; After + - * / % & | ^ expect '='
      (set 'assign-q2) (hash #\= (set 'assign-q1))

      ;; After > or < expect > or < (for shifts) or '=' (for >=, <=)
      (set 'assign-q3) (hash
                         #\> (set 'assign-q4)
                         #\< (set 'assign-q4)
                         #\= (set 'assign-q1))

      ;; After >> or << expect '='
      (set 'assign-q4) (hash #\= (set 'assign-q1))

      ;; Accepting assignment operators here, no further input
      (set 'assign-q1) (ann (hash) (HashTable Char (Setof Symbol))))
    'assign-q0                               ;; Start state
    (set 'assign-q1)))                       ;; Accept states



(define operators-dfa-list(list arithmetic-dfa comparison-dfa assignment-dfa))

(provide operators-dfa-list)