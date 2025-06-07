#lang typed/racket

(require "dfa.rkt")
(require "utils.rkt")


(define int-dfa
  (dfa
    (set 'int-q0 'int-qzero 'int-qd 'int-qu)
    (set #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\_)
    (hash
      ;; Start state
      (set 'int-q0)
      (hash
        #\0 (set 'int-qzero) ; Only "0" is valid with leading 0
        #\1 (set 'int-qd)
        #\2 (set 'int-qd)
        #\3 (set 'int-qd)
        #\4 (set 'int-qd)
        #\5 (set 'int-qd)
        #\6 (set 'int-qd)
        #\7 (set 'int-qd)
        #\8 (set 'int-qd)
        #\9 (set 'int-qd))
      
      ;; Accepting "0" state — no further transitions
      (set 'int-qzero)
      (ann (hash) (HashTable Char (Setof Symbol)))
      
      ;; After reading a digit from 1–9 or more
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
      ;; Start → 0
      (set 'hex-q0)
      (hash #\0 (set 'hex-q1))

      ;; 0 → x or X
      (set 'hex-q1)
      (hash #\x (set 'hex-q2)
            #\X (set 'hex-q2))

      ;; 0x → expect a hex digit
      (set 'hex-q2)
      (hash
        #\0 (set 'hex-qd) #\1 (set 'hex-qd) #\2 (set 'hex-qd) #\3 (set 'hex-qd)
        #\4 (set 'hex-qd) #\5 (set 'hex-qd) #\6 (set 'hex-qd) #\7 (set 'hex-qd)
        #\8 (set 'hex-qd) #\9 (set 'hex-qd)
        #\a (set 'hex-qd) #\b (set 'hex-qd) #\c (set 'hex-qd)
        #\d (set 'hex-qd) #\e (set 'hex-qd) #\f (set 'hex-qd)
        #\A (set 'hex-qd) #\B (set 'hex-qd) #\C (set 'hex-qd)
        #\D (set 'hex-qd) #\E (set 'hex-qd) #\F (set 'hex-qd))

      ;; hex digits → stay or go to underscore
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

      ;; underscore → must be followed by hex digit
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



(define numbers-dfa-list(list int-dfa hex-dfa))

(provide numbers-dfa-list)