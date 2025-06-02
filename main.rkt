#lang racket

(require "regex-tokens.rkt")
(require "nfa.rkt")
(require racket/string)
(require racket/port)

;; Función para leer el contenido de un archivo
(define (read-file filepath)
  (call-with-input-file filepath
    (lambda (in)
      (port->string in))))

;; Función para verificar si un carácter es alfanumérico o guión bajo
(define (is-word-char? char)
  (or (char-alphabetic? char)
      (char-numeric? char)
      (char=? char #\_)))

;; Función para buscar palabras completas en el texto
(define (find-word-matches text pattern)
  (define pattern-length (string-length pattern))
  (define text-length (string-length text))
  
  (define (search-at-position pos matches)
    (cond
      [(> (+ pos pattern-length) text-length) matches]
      [(and (string=? (substring text pos (+ pos pattern-length)) pattern)
            ;; Verificar que no hay carácter de palabra antes
            (or (= pos 0) 
                (not (is-word-char? (string-ref text (- pos 1)))))
            ;; Verificar que no hay carácter de palabra después
            (or (= (+ pos pattern-length) text-length)
                (not (is-word-char? (string-ref text (+ pos pattern-length))))))
       (search-at-position (+ pos 1) (cons pattern matches))]
      [else (search-at-position (+ pos 1) matches)]))
  
  (reverse (search-at-position 0 '())))

;; Función para buscar patrones de comentarios
(define (find-comment-matches text)
  (define lines (string-split text "\n"))
  (filter (lambda (line) 
            (let ([trimmed-line (string-trim line)])
              (and (> (string-length trimmed-line) 0)
                   (char=? (string-ref trimmed-line 0) #\#))))
          lines))

;; Función para buscar instancias de expresiones regulares en el texto
(define (find-matches-with-patterns text regex-tokens)
  (for/list ([token (in-list regex-tokens)])
    (let* ([key (car token)]
           [patterns (cdr token)])
      (cond
        ;; Para KEYWORD y SOFT_KEYWORD (listas de strings)
        [(and (list? patterns) (not (equal? key 'COMMENT)))
         (let ([all-matches (apply append 
                                   (map (lambda (pattern) 
                                          (find-word-matches text pattern)) 
                                        patterns))])
           (list key all-matches))]
        ;; Para COMMENT (patrón de regex)
        [(equal? key 'COMMENT)
         (let ([matches (find-comment-matches text)])
           (list key matches))]
        ;; Caso por defecto
        [else (list key '())]))))

;; Función principal
(define (process-file filepath)
  (let* ([content (read-file filepath)]
         [matches (find-matches-with-patterns content regex-tokens)])
    (for-each
      (lambda (match)
        (let ([key (first match)]
              [instances (second match)])
          (printf "Key: ~a\nMatches: ~a\n\n" key instances)))
      matches)))

;; Ejecutar la función con el archivo main.py
(process-file "main.py")