#lang racket
(require "dfa.rkt")
(require "utils.rkt")
(require "common-alphabet.rkt")

(define (generate-comment-transitions)
  (define all-chars-list (set->list (set-remove (generate-common-alphabet) #\#)))
  (define transition-pairs 
    (map (lambda (char) (cons char (set 'comment-q1))) all-chars-list))
  (make-hash transition-pairs))

(define comment-dfa
  (dfa
    (set 'comment-q0 'comment-q1)  
    (generate-common-alphabet)  
    (hash
      (set 'comment-q0) (hash #\# (set 'comment-q1))  
      (set 'comment-q1) (generate-comment-transitions))  
    'comment-q0                           
    (set 'comment-q1)))                   

(define comments-dfa-list (list comment-dfa))
(provide comments-dfa-list)