#lang racket


;; Parser de regex que interpreta "." como operador "dot" (comodín)

;; Entry point: convierte string regex a AST
(define (parse-regex str)
  (define-values (ast rest) (parse-alt (string->list str)))
  (if (null? rest)
      ast
      (error "Unexpected input at end:" rest)))

;; Parse alternation (a|b)
(define (parse-alt chars)
  (define-values (lhs rest) (parse-concat chars))
  (if (and (pair? rest) (char=? (car rest) #\|))
      (let-values ([(rhs rest2) (parse-alt (cdr rest))])
        (values `(alt ,lhs ,rhs) rest2))
      (values lhs rest)))

;; Parse concatenation (implícito: ab)
(define (parse-concat chars)
  (define-values (lhs rest) (parse-star chars))
  (define (loop acc rest)
    (cond
      [(null? rest) (values (if (null? (cdr acc)) (car acc) `(concat ,@acc)) rest)]
      [(or (char=? (car rest) #\|) (char=? (car rest) #\))) (values (if (null? (cdr acc)) (car acc) `(concat ,@acc)) rest)]
      [else
       (define-values (next rest2) (parse-star rest))
       (loop (append acc (list next)) rest2)]))
  (loop (list lhs) rest))

;; Parse Kleene star (a*)
(define (parse-star chars)
  (define-values (base rest) (parse-atom chars))
  (if (and (pair? rest) (char=? (car rest) #\*))
      (values `(star ,base) (cdr rest))
      (values base rest)))

;; Parse single char, ".", o paréntesis
(define (parse-atom chars)
  (cond
    [(null? chars) (error "Unexpected end of input")]
    [(char=? (car chars) #\() ; grupo
     (define-values (inside rest1) (parse-alt (cdr chars)))
     (if (and (pair? rest1) (char=? (car rest1) #\)))
         (values inside (cdr rest1))
         (error "Expected ')'"))]
    [(char=? (car chars) #\)) (error "Unexpected ')'")]
    [(char=? (car chars) #\.) ; operador dot = comodín
     (values '(dot) (cdr chars))]
    [else
     (values `(char ,(string (car chars))) (cdr chars))]))

;; Estructuras para NFA
(struct nfa (start accept transitions) #:transparent)
(struct transition (from to symbol) #:transparent)

;; Contador para estados únicos
(define state-counter (box 0))
(define (new-state)
  (let ([s (unbox state-counter)])
    (set-box! state-counter (add1 s))
    s))

;; Convierte AST a NFA
(define (ast->nfa ast)
  (match ast
    ;; Caracter simple
    [(list 'char c)
     (define s1 (new-state))
     (define s2 (new-state))
     (nfa s1 s2 (list (transition s1 s2 c)))]
    ;; Concatenación
    [(cons 'concat exprs)
     (foldl
      (λ (expr acc)
        (define nfa2 (ast->nfa expr))
        (define new-trans (append (nfa-transitions acc)
                                  (list (transition (nfa-accept acc) (nfa-start nfa2) 'eps))
                                  (nfa-transitions nfa2)))
        (nfa (nfa-start acc) (nfa-accept nfa2) new-trans))
      (ast->nfa (first exprs))
      (rest exprs))]
    ;; Alternación (|)
    [(list 'alt e1 e2)
     (define nfa1 (ast->nfa e1))
     (define nfa2 (ast->nfa e2))
     (define s (new-state))
     (define f (new-state))
     (nfa s f
          (append
           (list (transition s (nfa-start nfa1) 'eps)
                 (transition s (nfa-start nfa2) 'eps)
                 (transition (nfa-accept nfa1) f 'eps)
                 (transition (nfa-accept nfa2) f 'eps))
           (nfa-transitions nfa1)
           (nfa-transitions nfa2)))]
    ;; Kleene star (*)
    [(list 'star e)
     (define n (ast->nfa e))
     (define s (new-state))
     (define f (new-state))
     (nfa s f
          (append
           (list (transition s (nfa-start n) 'eps)
                 (transition s f 'eps)
                 (transition (nfa-accept n) f 'eps)
                 (transition (nfa-accept n) (nfa-start n) 'eps))
           (nfa-transitions n)))]
    ;; Operador dot (comodín)
    [(list 'dot)
     (define s1 (new-state))
     (define s2 (new-state))
     ;; 'any' simboliza cualquier caracter
     (nfa s1 s2 (list (transition s1 s2 'any)))]
    ;; Caso no soportado
    [_ (error "Unsupported AST node" ast)]))

;; Ejemplo de uso

(define test-regex ".a*b|c")

(define ast (parse-regex test-regex))

(printf "AST: ~a\n" ast)

(define nfa1 (ast->nfa ast))

(printf "NFA transitions:\n")

(for-each
 (λ (t)
   (printf "  ~a --~a--> ~a\n"
           (transition-from t)
           (transition-symbol t)
           (transition-to t)))
 (nfa-transitions nfa1))

(printf "Start state: ~a\n" (nfa-start nfa1))
(printf "Accept state: ~a\n" (nfa-accept nfa1))
