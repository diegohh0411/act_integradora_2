#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")


(define int-dfa
  (dfa
    (set 'int-q0 'int-qzero 'int-qd 'int-qu)
    (set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\_)
    (hash
      (set 'int-q0)
      (hash
        #\0 (set 'int-qzero) 
        #\1 (set 'int-qd)
        #\2 (set 'int-qd)
        #\3 (set 'int-qd)
        #\4 (set 'int-qd)
        #\5 (set 'int-qd)
        #\6 (set 'int-qd)
        #\7 (set 'int-qd)
        #\8 (set 'int-qd)
        #\9 (set 'int-qd))
      (set 'int-qzero)
      (ann (hash) (HashTable Char (Setof Symbol)))
      
      (set 'int-qd)
      (hash
        #\0 (set 'int-qd)
        #\1 (set 'int-qd)
        #\2 (set 'int-qd)
        #\3 (set 'int-qd)
        #\4 (set 'int-qd)
        #\5 (set 'int-qd)
        #\6 (set 'int-qd)
        #\7 (set 'int-qd)
        #\8 (set 'int-qd)
        #\9 (set 'int-qd)
        #\_ (set 'int-qu))
      
      ;; After underscore — must follow with digit
      (set 'int-qu)
      (hash
        #\0 (set 'int-qd)
        #\1 (set 'int-qd)
        #\2 (set 'int-qd)
        #\3 (set 'int-qd)
        #\4 (set 'int-qd)
        #\5 (set 'int-qd)
        #\6 (set 'int-qd)
        #\7 (set 'int-qd)
        #\8 (set 'int-qd)
        #\9 (set 'int-qd)))
    
    'int-q0
    (set 'int-qzero 'int-qd)))

(define hex-dfa
  (dfa
    (set 'hex-q0 'hex-q1 'hex-q2 'hex-q3 'hex-q4 'hex-q5 'hex-q6 'hex-q7 'hex-q8
         'hex-q9 'hex-qa 'hex-qb 'hex-qc 'hex-qd 'hex-qu)
    (set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 
         #\a #\b #\c #\d #\e #\f 
         #\A #\B #\C #\D #\E #\F 
         #\x #\X #\_)
    (hash
      (set 'hex-q0)
      (hash #\0 (set 'hex-q1))

      (set 'hex-q1)
      (hash #\x (set 'hex-q2)
            #\X (set 'hex-q2))

      (set 'hex-q2)
      (hash
        #\0 (set 'hex-qd) #\1 (set 'hex-qd) #\2 (set 'hex-qd) #\3 (set 'hex-qd)
        #\4 (set 'hex-qd) #\5 (set 'hex-qd) #\6 (set 'hex-qd) #\7 (set 'hex-qd)
        #\8 (set 'hex-qd) #\9 (set 'hex-qd)
        #\a (set 'hex-qd) #\b (set 'hex-qd) #\c (set 'hex-qd)
        #\d (set 'hex-qd) #\e (set 'hex-qd) #\f (set 'hex-qd)
        #\A (set 'hex-qd) #\B (set 'hex-qd) #\C (set 'hex-qd)
        #\D (set 'hex-qd) #\E (set 'hex-qd) #\F (set 'hex-qd))

      (set 'hex-qd)
      (hash
        #\0 (set 'hex-qd) #\1 (set 'hex-qd) #\2 (set 'hex-qd) #\3 (set 'hex-qd)
        #\4 (set 'hex-qd) #\5 (set 'hex-qd) #\6 (set 'hex-qd) #\7 (set 'hex-qd)
        #\8 (set 'hex-qd) #\9 (set 'hex-qd)
        #\a (set 'hex-qd) #\b (set 'hex-qd) #\c (set 'hex-qd)
        #\d (set 'hex-qd) #\e (set 'hex-qd) #\f (set 'hex-qd)
        #\A (set 'hex-qd) #\B (set 'hex-qd) #\C (set 'hex-qd)
        #\D (set 'hex-qd) #\E (set 'hex-qd) #\F (set 'hex-qd)
        #\_ (set 'hex-qu))

      (set 'hex-qu)
      (hash
        #\0 (set 'hex-qd) #\1 (set 'hex-qd) #\2 (set 'hex-qd) #\3 (set 'hex-qd)
        #\4 (set 'hex-qd) #\5 (set 'hex-qd) #\6 (set 'hex-qd) #\7 (set 'hex-qd)
        #\8 (set 'hex-qd) #\9 (set 'hex-qd)
        #\a (set 'hex-qd) #\b (set 'hex-qd) #\c (set 'hex-qd)
        #\d (set 'hex-qd) #\e (set 'hex-qd) #\f (set 'hex-qd)
        #\A (set 'hex-qd) #\B (set 'hex-qd) #\C (set 'hex-qd)
        #\D (set 'hex-qd) #\E (set 'hex-qd) #\F (set 'hex-qd)))
    
    'hex-q0
    (set 'hex-qd)))

(define octal-dfa
  (dfa
    (set 'oct-q0 'oct-q1 'oct-q2 'oct-qd 'oct-qu)
        (set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\o #\O #\_)
        (hash
      (set 'oct-q0)
      (hash #\0 (set 'oct-q1))
      (set 'oct-q1)
      (hash #\o (set 'oct-q2)
            #\O (set 'oct-q2))
      (set 'oct-q2)
      (hash
        #\0 (set 'oct-qd) #\1 (set 'oct-qd) #\2 (set 'oct-qd)
        #\3 (set 'oct-qd) #\4 (set 'oct-qd) #\5 (set 'oct-qd)
        #\6 (set 'oct-qd) #\7 (set 'oct-qd))
      (set 'oct-qd)
      (hash
        #\0 (set 'oct-qd) #\1 (set 'oct-qd) #\2 (set 'oct-qd)
        #\3 (set 'oct-qd) #\4 (set 'oct-qd) #\5 (set 'oct-qd)
        #\6 (set 'oct-qd) #\7 (set 'oct-qd)
        #\_ (set 'oct-qu))
      (set 'oct-qu)
      (hash
        #\0 (set 'oct-qd) #\1 (set 'oct-qd) #\2 (set 'oct-qd)
        #\3 (set 'oct-qd) #\4 (set 'oct-qd) #\5 (set 'oct-qd)
        #\6 (set 'oct-qd) #\7 (set 'oct-qd)))
        'oct-q0
    (set 'oct-qd)))

(define binary-dfa
  (dfa
    ;; States
    (set 'bin-q0 'bin-q1 'bin-q2 'bin-qd 'bin-qu)
    
    ;; Alphabet
    (set #\0 #\1 #\b #\B #\_)
    
    ;; Transition table
    (hash
      ;; Start → 0
      (set 'bin-q0)
      (hash #\0 (set 'bin-q1))

      ;; 0 → b or B
      (set 'bin-q1)
      (hash #\b (set 'bin-q2)
            #\B (set 'bin-q2))

      ;; 0b → must be followed by a binary digit
      (set 'bin-q2)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd))

      ;; In binary digits → loop or go to underscore
      (set 'bin-qd)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd)
        #\_ (set 'bin-qu))

      ;; After underscore → must get a digit
      (set 'bin-qu)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd)))
    
    ;; Start state
    'bin-q0

    ;; Accepting state(s)
    (set 'bin-qd)))


(define numbers-dfa-list(list int-dfa hex-dfa octal-dfa binary-dfa))

(provide numbers-dfa-list)