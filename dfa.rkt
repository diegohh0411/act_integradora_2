#lang typed/racket

;; Definición de la estructura `dfa` (Automata Finito Determinista).
;; Contiene los estados, alfabeto, transiciones, estado inicial y estados de aceptación.
(struct dfa (
  [states : (Setof Symbol)]  ;; Conjunto de estados del DFA.
  [alphabet : (Setof Char)]  ;; Conjunto de caracteres que forman el alfabeto.
  [transitions : (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))]  ;; Tabla de transiciones entre estados.
  [start-state : Symbol]  ;; Estado inicial del DFA.
  [accept-states : (Setof Symbol)]  ;; Conjunto de estados de aceptación.
  ) #:transparent)

;; Declaración del tipo de la función `dfa-accepts?`.
;; Esta función toma un DFA y una cadena de entrada, y devuelve un valor booleano.
(: dfa-accepts? (dfa String -> Boolean))

;; Definición de la función `dfa-accepts?`.
;; Determina si una cadena de entrada es aceptada por el DFA.
(define (dfa-accepts? dfa input-string)
  ;; Función recursiva interna `loop` para procesar la cadena de entrada.
  (let loop ([current-state (set (dfa-start-state dfa))]  ;; Estado actual del DFA (inicia en el estado inicial).
             [remaining-input (string->list input-string)])  ;; Lista de caracteres restantes de la cadena de entrada.
    (cond
      ;; Caso base: si no quedan caracteres en la entrada.
      [(empty? remaining-input)
       ;; Verifica si el estado actual intersecta con los estados de aceptación.
       (not (set-empty? (set-intersect (dfa-accept-states dfa) current-state)))]  
      ;; Caso recursivo: aún quedan caracteres por procesar.
      [else
       (let* ([current-char (first remaining-input)]  ;; Obtiene el primer carácter de la entrada.
              [state-transitions (hash-ref (dfa-transitions dfa) current-state #f)]  ;; Obtiene las transiciones del estado actual.
              [next-state (and state-transitions (hash-ref state-transitions current-char #f))])  ;; Determina el siguiente estado basado en el carácter actual.
         ;; Si hay un estado válido al que transitar, continúa la recursión.
         (if next-state
             (loop next-state (rest remaining-input))  ;; Llama recursivamente con el siguiente estado y el resto de la entrada.
             #f))])))  ;; Si no hay transición válida, devuelve falso.

(provide dfa
         dfa-alphabet
         dfa-states
         dfa-transitions
         dfa-start-state
         dfa-accept-states
         dfa-accepts?)