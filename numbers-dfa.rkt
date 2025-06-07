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
    (set 'bin-q0 'bin-q1 'bin-q2 'bin-qd 'bin-qu)
    
    (set #\0 #\1 #\b #\B #\_)
    
    (hash
      (set 'bin-q0)
      (hash #\0 (set 'bin-q1))

      (set 'bin-q1)
      (hash #\b (set 'bin-q2)
            #\B (set 'bin-q2))

      (set 'bin-q2)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd))

      (set 'bin-qd)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd)
        #\_ (set 'bin-qu))

      (set 'bin-qu)
      (hash
        #\0 (set 'bin-qd)
        #\1 (set 'bin-qd)))
    
    'bin-q0

    (set 'bin-qd)))

(define float-dfa
  (dfa
    (set 'f-q0 'f-q1 'f-q2 'f-q3 'f-q4 'f-q5 'f-q6 'f-q7 'f-q8) 
    (set #\. #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\e #\E #\+ #\-) 
    (hash
      (set 'f-q0) (hash
                   
                    #\0 (set 'f-q1)  #\1 (set 'f-q1) #\2 (set 'f-q1) #\3 (set 'f-q1) #\4 (set 'f-q1)
                    #\5 (set 'f-q1)  #\6 (set 'f-q1) #\7 (set 'f-q1) #\8 (set 'f-q1) #\9 (set 'f-q1)
                   
                    #\. (set 'f-q2))
      (set 'f-q1) (hash
                    #\0 (set 'f-q1) #\1 (set 'f-q1) #\2 (set 'f-q1) #\3 (set 'f-q1) #\4 (set 'f-q1)
                    #\5 (set 'f-q1) #\6 (set 'f-q1) #\7 (set 'f-q1) #\8 (set 'f-q1) #\9 (set 'f-q1)
                    #\. (set 'f-q3)
                    #\e (set 'f-q5)
                    #\E (set 'f-q5))
      (set 'f-q2) (hash
                    #\0 (set 'f-q4) #\1 (set 'f-q4) #\2 (set 'f-q4) #\3 (set 'f-q4) #\4 (set 'f-q4)
                    #\5 (set 'f-q4) #\6 (set 'f-q4) #\7 (set 'f-q4) #\8 (set 'f-q4) #\9 (set 'f-q4))
      (set 'f-q3) (hash
                    #\0 (set 'f-q3) #\1 (set 'f-q3) #\2 (set 'f-q3) #\3 (set 'f-q3) #\4 (set 'f-q3)
                    #\5 (set 'f-q3) #\6 (set 'f-q3) #\7 (set 'f-q3) #\8 (set 'f-q3) #\9 (set 'f-q3)
                    #\e (set 'f-q5)
                    #\E (set 'f-q5))
      (set 'f-q4) (hash
                    #\0 (set 'f-q4) #\1 (set 'f-q4) #\2 (set 'f-q4) #\3 (set 'f-q4) #\4 (set 'f-q4)
                    #\5 (set 'f-q4) #\6 (set 'f-q4) #\7 (set 'f-q4) #\8 (set 'f-q4) #\9 (set 'f-q4)
                    #\e (set 'f-q5)
                    #\E (set 'f-q5))
      (set 'f-q5) (hash
                    #\+ (set 'f-q6)
                    #\- (set 'f-q6)
                    #\0 (set 'f-q7) #\1 (set 'f-q7) #\2 (set 'f-q7) #\3 (set 'f-q7) #\4 (set 'f-q7)
                    #\5 (set 'f-q7) #\6 (set 'f-q7) #\7 (set 'f-q7) #\8 (set 'f-q7) #\9 (set 'f-q7))

      (set 'f-q6) (hash
                    #\0 (set 'f-q7) #\1 (set 'f-q7) #\2 (set 'f-q7) #\3 (set 'f-q7) #\4 (set 'f-q7)
                    #\5 (set 'f-q7) #\6 (set 'f-q7) #\7 (set 'f-q7) #\8 (set 'f-q7) #\9 (set 'f-q7))

      (set 'f-q7) (hash
                    #\0 (set 'f-q7) #\1 (set 'f-q7) #\2 (set 'f-q7) #\3 (set 'f-q7) #\4 (set 'f-q7)
                    #\5 (set 'f-q7) #\6 (set 'f-q7) #\7 (set 'f-q7) #\8 (set 'f-q7) #\9 (set 'f-q7))
      (set 'f-q8) (ann (hash) (HashTable Char (Setof Symbol)))
      )
    'f-q0 
    (set 'f-q3 'f-q4 'f-q7))) 

(define complex-dfa
  (dfa
    (set 'c-q0 'c-q1 'c-q2 'c-q3 'c-q4 'c-q5 'c-q6 'c-q7 'c-q8 'c-qj)
    (set #\. #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\e #\E #\+ #\- #\j #\J) 
    (hash

      (set 'c-q0) (hash
                    #\0 (set 'c-q1)  #\1 (set 'c-q1) #\2 (set 'c-q1) #\3 (set 'c-q1) #\4 (set 'c-q1)
                    #\5 (set 'c-q1)  #\6 (set 'c-q1) #\7 (set 'c-q1) #\8 (set 'c-q1) #\9 (set 'c-q1)

                    #\. (set 'c-q2))
      (set 'c-q1) (hash
                    #\0 (set 'c-q1) #\1 (set 'c-q1) #\2 (set 'c-q1) #\3 (set 'c-q1) #\4 (set 'c-q1)
                    #\5 (set 'c-q1) #\6 (set 'c-q1) #\7 (set 'c-q1) #\8 (set 'c-q1) #\9 (set 'c-q1)
                    #\. (set 'c-q3)
                    #\e (set 'c-q5)
                    #\E (set 'c-q5)
                    #\j (set 'c-qj)
                    #\J (set 'c-qj))

      (set 'c-q2) (hash
                    #\0 (set 'c-q4) #\1 (set 'c-q4) #\2 (set 'c-q4) #\3 (set 'c-q4) #\4 (set 'c-q4)
                    #\5 (set 'c-q4) #\6 (set 'c-q4) #\7 (set 'c-q4) #\8 (set 'c-q4) #\9 (set 'c-q4))

      (set 'c-q3) (hash
                    #\0 (set 'c-q3) #\1 (set 'c-q3) #\2 (set 'c-q3) #\3 (set 'c-q3) #\4 (set 'c-q3)
                    #\5 (set 'c-q3) #\6 (set 'c-q3) #\7 (set 'c-q3) #\8 (set 'c-q3) #\9 (set 'c-q3)
                    #\e (set 'c-q5)
                    #\E (set 'c-q5)
                    #\j (set 'c-qj)
                    #\J (set 'c-qj))
      (set 'c-q4) (hash
                    #\0 (set 'c-q4) #\1 (set 'c-q4) #\2 (set 'c-q4) #\3 (set 'c-q4) #\4 (set 'c-q4)
                    #\5 (set 'c-q4) #\6 (set 'c-q4) #\7 (set 'c-q4) #\8 (set 'c-q4) #\9 (set 'c-q4)
                    #\e (set 'c-q5)
                    #\E (set 'c-q5)
                    #\j (set 'c-qj)
                    #\J (set 'c-qj))
      (set 'c-q5) (hash
                    #\+ (set 'c-q6)
                    #\- (set 'c-q6)
                    #\0 (set 'c-q7) #\1 (set 'c-q7) #\2 (set 'c-q7) #\3 (set 'c-q7) #\4 (set 'c-q7)
                    #\5 (set 'c-q7) #\6 (set 'c-q7) #\7 (set 'c-q7) #\8 (set 'c-q7) #\9 (set 'c-q7))


      (set 'c-q6) (hash
                    #\0 (set 'c-q7) #\1 (set 'c-q7) #\2 (set 'c-q7) #\3 (set 'c-q7) #\4 (set 'c-q7)
                    #\5 (set 'c-q7) #\6 (set 'c-q7) #\7 (set 'c-q7) #\8 (set 'c-q7) #\9 (set 'c-q7))
      (set 'c-q7) (hash
                    #\0 (set 'c-q7) #\1 (set 'c-q7) #\2 (set 'c-q7) #\3 (set 'c-q7) #\4 (set 'c-q7)
                    #\5 (set 'c-q7) #\6 (set 'c-q7) #\7 (set 'c-q7) #\8 (set 'c-q7) #\9 (set 'c-q7)
                    #\j (set 'c-qj)
                    #\J (set 'c-qj))

      (set 'c-qj) (ann (hash) (HashTable Char (Setof Symbol)))
      )
    'c-q0
    (set 'c-qj)))


(define numbers-dfa-list(list int-dfa hex-dfa octal-dfa binary-dfa float-dfa complex-dfa))

(provide numbers-dfa-list)