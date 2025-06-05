#lang racket

(require racket/set
  racket/hash)

(struct nfa (states alphabet transitions start-state accept-states) #:transparent)
(struct dfa)

(define (epsilon-closure state transitions)
  (define (closure-helper stack visited)
    (cond
      [(null? stack) visited]
      [else
       (let* ([current (car stack)]
              [rest (cdr stack)]
              [epsilon-next (hash-ref (hash-ref transitions current (λ () (hash))) '' '())]
              [new-states (filter (λ (s) (not (set-member? visited s))) epsilon-next)]
              [new-visited (foldl set-add visited new-states)]
              [new-stack (append rest new-states)])
         (closure-helper new-stack new-visited))]))
)