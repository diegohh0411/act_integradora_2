#lang racket

(require "dfa.rkt")
(require "utils.rkt")

;; Helper function to generate a comprehensive alphabet including accented characters
(define (generate-comment-alphabet)
  (define basic-chars
    (set #\# #\space #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
         #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z
         #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9
         #\! #\@ #\$ #\% #\^ #\& #\* #\( #\) #\- #\_ #\+ #\= #\[ #\] #\{ #\} #\| #\\ #\: #\; #\" #\' #\< #\> #\, #\. #\? #\/))
  
  ;; Add common accented characters
  (define accented-chars
    (set #\á #\é #\í #\ó #\ú #\ñ #\ü #\Á #\É #\Í #\Ó #\Ú #\Ñ #\Ü))
  
  (set-union basic-chars accented-chars))

;; Generate the full alphabet for comments
(define comment-alphabet (generate-comment-alphabet))

;; Helper function to generate transitions for all alphabet characters (except #)
(define (generate-comment-transitions)
  (define all-chars-list (set->list (set-remove comment-alphabet #\#)))
  (define transition-pairs 
    (map (lambda (char) (cons char (set 'comment-q1))) all-chars-list))
  (make-hash transition-pairs))

;; Define the DFA for Python line comments (starting with #)
;; This DFA recognizes any comment that starts with # and continues with any characters including accented ones
(define comment-dfa
  (dfa
    (set 'comment-q0 'comment-q1)  ;; States: initial and comment state
    comment-alphabet  ;; Comprehensive alphabet including accented characters
    (hash
      (set 'comment-q0) (hash #\# (set 'comment-q1))  ;; Transition from initial state on #
      (set 'comment-q1) (generate-comment-transitions))  ;; From comment state, accept any character and stay in comment state
    'comment-q0                           ;; Start state
    (set 'comment-q1)))                   ;; Accept states (after reading #)

;; List of all comment DFAs defined in this file
(define comments-dfa-list (list comment-dfa))

(provide comments-dfa-list)