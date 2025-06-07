#lang typed/racket

(require "dfa.rkt")

;; Define el DFA para identificar identificadores válidos en Python.
(define identifiers-dfa
  (dfa
    (set 'id-q0 'id-q1 'id-q2)  ;; Estados
    (set #\_ #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
         #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z
         #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)  ;; Alfabeto
    (hash
      (set 'id-q0) (hash #\_ (set 'id-q1)
                          #\a (set 'id-q1) #\b (set 'id-q1) #\c (set 'id-q1) #\d (set 'id-q1) #\e (set 'id-q1) #\f (set 'id-q1)
                          #\g (set 'id-q1) #\h (set 'id-q1) #\i (set 'id-q1) #\j (set 'id-q1) #\k (set 'id-q1) #\l (set 'id-q1)
                          #\m (set 'id-q1) #\n (set 'id-q1) #\o (set 'id-q1) #\p (set 'id-q1) #\q (set 'id-q1) #\r (set 'id-q1)
                          #\s (set 'id-q1) #\t (set 'id-q1) #\u (set 'id-q1) #\v (set 'id-q1) #\w (set 'id-q1) #\x (set 'id-q1)
                          #\y (set 'id-q1) #\z (set 'id-q1) #\A (set 'id-q1) #\B (set 'id-q1) #\C (set 'id-q1) #\D (set 'id-q1)
                          #\E (set 'id-q1) #\F (set 'id-q1) #\G (set 'id-q1) #\H (set 'id-q1) #\I (set 'id-q1) #\J (set 'id-q1)
                          #\K (set 'id-q1) #\L (set 'id-q1) #\M (set 'id-q1) #\N (set 'id-q1) #\O (set 'id-q1) #\P (set 'id-q1)
                          #\Q (set 'id-q1) #\R (set 'id-q1) #\S (set 'id-q1) #\T (set 'id-q1) #\U (set 'id-q1) #\V (set 'id-q1)
                          #\W (set 'id-q1) #\X (set 'id-q1) #\Y (set 'id-q1) #\Z (set 'id-q1))
      (set 'id-q1) (hash #\_ (set 'id-q1)
                          #\a (set 'id-q1) #\b (set 'id-q1) #\c (set 'id-q1) #\d (set 'id-q1) #\e (set 'id-q1) #\f (set 'id-q1)
                          #\g (set 'id-q1) #\h (set 'id-q1) #\i (set 'id-q1) #\j (set 'id-q1) #\k (set 'id-q1) #\l (set 'id-q1)
                          #\m (set 'id-q1) #\n (set 'id-q1) #\o (set 'id-q1) #\p (set 'id-q1) #\q (set 'id-q1) #\r (set 'id-q1)
                          #\s (set 'id-q1) #\t (set 'id-q1) #\u (set 'id-q1) #\v (set 'id-q1) #\w (set 'id-q1) #\x (set 'id-q1)
                          #\y (set 'id-q1) #\z (set 'id-q1) #\A (set 'id-q1) #\B (set 'id-q1) #\C (set 'id-q1) #\D (set 'id-q1)
                          #\E (set 'id-q1) #\F (set 'id-q1) #\G (set 'id-q1) #\H (set 'id-q1) #\I (set 'id-q1) #\J (set 'id-q1)
                          #\K (set 'id-q1) #\L (set 'id-q1) #\M (set 'id-q1) #\N (set 'id-q1) #\O (set 'id-q1) #\P (set 'id-q1)
                          #\Q (set 'id-q1) #\R (set 'id-q1) #\S (set 'id-q1) #\T (set 'id-q1) #\U (set 'id-q1) #\V (set 'id-q1)
                          #\W (set 'id-q1) #\X (set 'id-q1) #\Y (set 'id-q1) #\Z (set 'id-q1)
                          #\0 (set 'id-q1) #\1 (set 'id-q1) #\2 (set 'id-q1) #\3 (set 'id-q1) #\4 (set 'id-q1) #\5 (set 'id-q1)
                          #\6 (set 'id-q1) #\7 (set 'id-q1) #\8 (set 'id-q1) #\9 (set 'id-q1)))
    'id-q0  ;; Estado inicial
    (set 'id-q1)))  ;; Estado de aceptación

(define identifiers-dfa-list
  (list identifiers-dfa))

(provide identifiers-dfa-list)