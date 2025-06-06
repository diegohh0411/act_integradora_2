#lang typed/racket

(require "dfa.rkt")

;; Función auxiliar para unir todos los estados de una lista de DFAs
(: union-all-states ((Listof dfa) -> (Setof Symbol)))
(define (union-all-states dfa-list)
  (cond
    [(null? dfa-list) (set)]
    [(null? (rest dfa-list)) (dfa-states (first dfa-list))]
    [else (set-union (dfa-states (first dfa-list))
                     (union-all-states (rest dfa-list)))]))

;; Función auxiliar para unir todos los alfabetos de una lista de DFAs
(: union-all-alphabets ((Listof dfa) -> (Setof Char)))
(define (union-all-alphabets dfa-list)
  (cond
    [(null? dfa-list) (set)]
    [(null? (rest dfa-list)) (dfa-alphabet (first dfa-list))]
    [else (set-union (dfa-alphabet (first dfa-list))
                     (union-all-alphabets (rest dfa-list)))]))

;; Función auxiliar para unir todos los estados de aceptación de una lista de DFAs
(: union-all-accept-states ((Listof dfa) -> (Setof Symbol)))
(define (union-all-accept-states dfa-list)
  (cond
    [(null? dfa-list) (set)]
    [(null? (rest dfa-list)) (dfa-accept-states (first dfa-list))]
    [else (set-union (dfa-accept-states (first dfa-list))
                     (union-all-accept-states (rest dfa-list)))]))

;; Función para unir dos tablas hash de transiciones
(: hash-union-transitions ((HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))
                          (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))
                          -> (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))))
(define (hash-union-transitions ht1 ht2)
  (: merge-hash ((HashTable (Setof Symbol) (HashTable Char (Setof Symbol))) 
                 (HashTable (Setof Symbol) (HashTable Char (Setof Symbol))) 
                 -> (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))))
  (define (merge-hash ht result)
    (if (hash-empty? ht)
        result
        (let* ([keys (hash-keys ht)]
               [key (first keys)]
               [value (hash-ref ht key)]
               [remaining-hash (hash-remove ht key)])
          (merge-hash remaining-hash (hash-set result key value)))))
  (merge-hash ht2 (merge-hash ht1 (ann (make-immutable-hash) (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))))))

;; Función auxiliar para unir todas las transiciones de una lista de DFAs
(: union-all-transitions ((Listof dfa) -> (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))))
(define (union-all-transitions dfa-list)  (cond
    [(null? dfa-list) (ann (make-immutable-hash) (HashTable (Setof Symbol) (HashTable Char (Setof Symbol))))]
    [(null? (rest dfa-list)) (dfa-transitions (first dfa-list))]
    [else (hash-union-transitions (dfa-transitions (first dfa-list))
                                  (union-all-transitions (rest dfa-list)))]))

;; Función para concatenar múltiples DFA en uno solo
(: concatenate-dfas ((Listof dfa) -> dfa))
(define (concatenate-dfas dfa-list)
  (define new-states (union-all-states dfa-list))
  (define new-alphabet (union-all-alphabets dfa-list))
  (define new-transitions (union-all-transitions dfa-list))
  ;; Para la unión de DFAs, tomamos el primer estado inicial como el estado inicial del DFA combinado
  (define new-start-state (if (null? dfa-list) 
                              'q0 
                              (dfa-start-state (first dfa-list))))
  (define new-accept-states (union-all-accept-states dfa-list))

  (dfa new-states new-alphabet new-transitions new-start-state new-accept-states))

(provide concatenate-dfas)