#lang racket
(require "regex-tokens.rkt")

;; Representación de un estado en el NFA
(struct nfa-state (id transitions) #:transparent)

;; Representación de una transición de un NFA
(struct nfa-transition (symbol target) #:transparent)

;; Función para actualizar las transiciones de un estado
(define (update-nfa-state-transitions state new-transitions)
  (nfa-state (nfa-state-id state) new-transitions))

(define (create-basic-nfa symbol)
  (let* 
    (
      [start (nfa-state 'start '())]
      [end (nfa-state 'end '())]
      [transition (nfa-transition symbol end)]
    )
    (update-nfa-state-transitions start (list transition))
    (list start end)
  )
)

;; Función para concatenar dos NFAs
(define (concat-nfa nfa1 nfa2)
  (let* 
    ( 
      [start1 (first nfa1)]
      [end1 (last nfa1)]
      [start2 (first nfa2)]
      [end2 (last nfa2)]
      [epsilon-transition (nfa-transition 'epsilon start2)]
    )
    (update-nfa-state-transitions end1 (list epsilon-transition))
    (append nfa1 nfa2)
  )
)

;; Función para unir dos NFAs (operación OR)
(define (union-nfa nfa1 nfa2)
  (let* 
    (
      [start (nfa-state 'start '())]
      [end (nfa-state 'end '())]
      [start1 (first nfa1)]
      [end1 (last nfa1)]
      [start2 (first nfa2)]
      [end2 (last nfa2)]
      [epsilon-transition1 (nfa-transition 'epsilon start1)]
      [epsilon-transition2 (nfa-transition 'epsilon start2)]
      [end-transition1 (nfa-transition 'epsilon end)]
      [end-transition2 (nfa-transition 'epsilon end)]
    )
    (update-nfa-state-transitions start (list epsilon-transition1 epsilon-transition2))
    (update-nfa-state-transitions end1 (list end-transition1))
    (update-nfa-state-transitions end2 (list end-transition2))
    (append (list start) nfa1 nfa2 (list end))
  )
)

;; Función para aplicar cierre de Kleene (Kleene star)
(define (kleene-star-nfa nfa)
  (let* 
    (
      [start (nfa-state 'start '())]
      [end (nfa-state 'end '())]
      [start-nfa (first nfa)]
      [end-nfa (last nfa)]
      [start-transition (nfa-transition 'epsilon start-nfa)]
      [end-transition (nfa-transition 'epsilon end)]
      [loop-transition (nfa-transition 'epsilon start-nfa)]
      [back-transition (nfa-transition 'epsilon end-nfa)]
    )
    (update-nfa-state-transitions start (list start-transition end-transition))
    (update-nfa-state-transitions end-nfa (list loop-transition back-transition))
    (append (list start) nfa (list end))
  )
)

(define (build-nfa-from-regex regex)
  (match regex
    [(list 'KEYWORD keywords)
      (map create-basic-nfa keywords)]
    [(list 'SOFT_KEYWORD soft-keywords)
      (map create-basic-nfa soft-keywords)]
    [(list 'COMMENT comment)
      (create-basic-nfa comment)]
  )
)

(provide build-nfa-from-regex nfa-state nfa-state-transitions nfa-transition nfa-transition-symbol nfa-transition-target create-basic-nfa)