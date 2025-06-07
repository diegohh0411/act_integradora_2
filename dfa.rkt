#lang typed/racket

(struct dfa (
  [states : (Setof Symbol)]  
  [alphabet : (Setof Char)]  
  [transitions : (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))]  
  [start-state : Symbol]  
  [accept-states : (Setof Symbol)]  
  ) #:transparent)

(: dfa-accepts? (dfa String -> Boolean))

(define (dfa-accepts? dfa input-string)
  
  (let loop ([current-state (set (dfa-start-state dfa))]  
             [remaining-input (string->list input-string)])  
    (cond
      
      [(empty? remaining-input)
       
       (not (set-empty? (set-intersect (dfa-accept-states dfa) current-state)))]  
      
      [else
       (let* ([current-char (first remaining-input)]  
              [state-transitions (hash-ref (dfa-transitions dfa) current-state #f)]  
              [next-state (and state-transitions (hash-ref state-transitions current-char #f))])  
         
         (if next-state
             (loop next-state (rest remaining-input))  
             #f))])))  
(provide dfa
         dfa-alphabet
         dfa-states
         dfa-transitions
         dfa-start-state
         dfa-accept-states
         dfa-accepts?)