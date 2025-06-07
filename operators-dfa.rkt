#lang typed/racket
(require "dfa.rkt")
(require "utils.rkt")
(define arithmetic-dfa
  (dfa
    (set 'arith-q0 'arith-q1 'arith-q2) 
    (set #\+ #\- #\* #\/ #\% )          
    (hash
      
      (set 'arith-q0)
        (hash #\+ (set 'arith-q1)
              #\- (set 'arith-q1)
              #\* (set 'arith-q1)
              #\/ (set 'arith-q1)
              #\% (set 'arith-q1))
      
      (set 'arith-q1)
        (hash #\* (set 'arith-q2)  
              #\/ (set 'arith-q2)) 
      
      (set 'arith-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'arith-q0                   
    (set 'arith-q1 'arith-q2))) 
(define comparison-dfa
  (dfa
    (set 'comp-q0 'comp-q1 'comp-q2)  
    (set #\< #\> #\= #\!)              
    (hash
      
      (set 'comp-q0)
        (hash #\< (set 'comp-q1)
              #\> (set 'comp-q1)
              #\= (set 'comp-q1)
              #\! (set 'comp-q1))
      
      (set 'comp-q1)
        (hash #\= (set 'comp-q2))
      
      (set 'comp-q2) (ann (hash) (HashTable Char (Setof Symbol))))
    'comp-q0                    
    (set 'comp-q1 'comp-q2)))   
(define assignment-dfa
  (dfa
    (set 'assign-q0 'assign-q1 'assign-q2 'assign-q3 'assign-q4)  
    (set #\= #\+ #\- #\* #\/ #\% #\& #\| #\^ #\> #\<)              
    (hash
      
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
      
      (set 'assign-q2) (hash #\= (set 'assign-q1))
      
      (set 'assign-q3) (hash
                         #\> (set 'assign-q4)
                         #\< (set 'assign-q4)
                         #\= (set 'assign-q1))
      
      (set 'assign-q4) (hash #\= (set 'assign-q1))
      
      (set 'assign-q1) (ann (hash) (HashTable Char (Setof Symbol))))
    'assign-q0                               
    (set 'assign-q1)))                       

(define operators-dfa-list(list arithmetic-dfa comparison-dfa assignment-dfa))
(provide operators-dfa-list)