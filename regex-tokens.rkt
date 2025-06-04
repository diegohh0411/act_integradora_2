#lang racket

(define regex-tokens
  `(
    (COMMENT . ("#[^\n]*"))
    (KEYWORD . ("False", "await", "else", "import", "pass", "None", "break", "except", "in", "raise", "True", "class", "finally", "is", "return", "and", "continue", "for", "lambda", "try", "as", "def", "from", "nonlocal", "while", "assert", "del", "global", "not", "with", "async", "elif", "if", "or", "yield"))
    (SOFT_KEYWORD . ("match", "case", "type", "_"))
  )
)

(provide regex-tokens)