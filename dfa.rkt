#lang typed/racket

(struct dfa ([states : (Listof Symbol)]
            [alphabet : (Listof Symbol)]
            [transitions : (HashTable (Setof Integer) (HashTable Symbol (Setof Integer)))]
            [start-state : Symbol]
            [accept-states : (Listof Symbol)]))


; Function to check if a DFA accepts a given string
(: dfa-accepts (dfa String -> Boolean))
(define (dfa-accepts dfa input-string)
  [let loop (
    [current-state (dfa-start-state dfa)]
    [remaining-input (string->list input-string)]
  )]

  (cond 
    ;; Si no hay más símbolos en la cadena, verificamos si el estado actual es de aceptación
    [(empty? remaining-input)
     (member current-state (dfa-accept-states dfa))]
    ;; Si el símbolo actual no está en el alfabeto, rechazamos la cadena
    [(not (member (first remaining-input) (dfa-alphabet dfa)))
      #f]
    ;; De lo contrario, buscamos la transición correspondiente
    [else
      (define next-state
        (hash-ref (hash-ref (Dfa-transitions dfa) current-state (make-hasheq))
                  (first remaining-input)
                  #f))
      ;; Si no hay transición válida, rechazamos la cadena
      (if (not next-state)
          #f
          ;; Continuamos con el siguiente estado y el resto de la cadena
          (loop next-state (rest remaining-input)))]
  )
)

(provide dfa dfa-accepts)
