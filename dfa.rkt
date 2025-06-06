#lang typed/racket

(struct dfa (
  [states : (Setof Symbol)] ; Changed from Listof to Setof for consistency
  [alphabet : (Setof Char)] ; Changed from Listof to Setof for consistency
  [transitions : (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))] ; Changed Integer to Symbol
  [start-state : Symbol]
  [accept-states : (Setof Symbol)] ; Changed from Listof to Setof for consistency
  ) #:transparent)


; Function to check if a DFA accepts a given string
(: dfa-accepts (dfa String -> Boolean))
(define (dfa-accepts dfa input-string)
  (: loop (Symbol (Listof Symbol) -> Boolean)) ; Type annotation for the recursive function
  (define (loop current-state remaining-input)
    (cond 
      ;; Si no hay más símbolos en la cadena, verificamos si el estado actual es de aceptación
      [(empty? remaining-input)
       (member current-state (set->list (dfa-accept-states dfa)))]
      ;; Si el símbolo actual no está en el alfabeto, rechazamos la cadena
      [(not (member (first remaining-input) (set->list (dfa-alphabet dfa))))
        #f]
      ;; De lo contrario, buscamos la transición correspondiente
      [else
        (define next-state
          (hash-ref (hash-ref (dfa-transitions dfa) current-state (make-hasheq))
                    (first remaining-input)
                    #f))
        ;; Si no hay transición válida, rechazamos la cadena
        (if (not next-state)
            #f
            ;; Continuamos con el siguiente estado y el resto de la cadena
            (loop next-state (rest remaining-input)))]))
  (loop (dfa-start-state dfa) (map string->symbol (string->list input-string))))

; (provide dfa dfa-accepts)


(define my-dfa
  (dfa
    (set 'q0 'q1 'q2) ; States
    (set 'a 'b)       ; Alphabet
    (hasheq           ; Transitions
      (set 'q0) (hasheq 'a (set 'q1) 'b (set 'q0))
      (set 'q1) (hasheq 'a (set 'q2) 'b (set 'q0))
      (set 'q2) (hasheq 'a (set 'q2) 'b (set 'q2)))
    'q0               ; Start state
    (set 'q2)))       ; Accept states

;; Test the DFA with different strings
(define test-string-1 "aab")
(define test-string-2 "aaa")
(define test-string-3 "bba")

;; Check if the strings are accepted
(printf "Does the DFA accept '~a'? ~a\n" test-string-1 (dfa-accepts my-dfa test-string-1))
(printf "Does the DFA accept '~a'? ~a\n" test-string-2 (dfa-accepts my-dfa test-string-2))
(printf "Does the DFA accept '~a'? ~a\n" test-string-3 (dfa-accepts my-dfa test-string-3))