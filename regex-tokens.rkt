#lang racket

;; Función que envuelve cada palabra con delimitadores de palabra \b
(define (wrap-keywords kw-list)
  (map (λ (kw) (string-append "\\b" kw "\\b")) kw-list))

;; Definición de tokens con expresiones regulares delimitadas
(define regex-tokens
  `(
    (COMMENT . ("#[^\n]*"))
    (KEYWORD . ,(wrap-keywords
                 '("False" "await" "else" "import" "pass"
                   "None" "break" "except" "in" "raise"
                   "True" "class" "finally" "is" "return"
                   "and" "continue" "for" "lambda" "try"
                   "as" "def" "from" "nonlocal" "while"
                   "assert" "del" "global" "not" "with"
                   "async" "elif" "if" "or" "yield")))
    (SOFT_KEYWORD . ,(wrap-keywords '("match" "case" "type" "_")))
  ))



(provide regex-tokens)
