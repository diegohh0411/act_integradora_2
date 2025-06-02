#lang racket

(define regex-tokens
  `(
    (KEYWORD . ("False", "await", "else", "import", "pass", "None", "break", "except", "in", "raise", "True", "class", "finally", "is", "return", "and", "continue", "for", "lambda", "try", "as", "def", "from", "nonlocal", "while", "assert", "del", "global", "not", "with", "async", "elif", "if", "or", "yield"))
    (SOFT_KEYWORD . ("match", "case", "type", "_"))
    (COMMENT . ("#[^\n]*"))
  )
)

(provide regex-tokens)