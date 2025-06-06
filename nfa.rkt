#lang typed/racket

(require racket/set
  racket/hash)

(struct nfa (
  [states: (Setof Symbol)] 
  [alphabet: (Setof Char)] 
  [transitions: (HashTable (Setof Symbol) (HashTable Char (Setof Symbol)))] 
  [start-state: Symbol]
  [accept-states: (Setof Symbol)]
  ) #:transparent)
(struct dfa)