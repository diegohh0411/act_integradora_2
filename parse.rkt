
(require racket/string)
(require racket/port)

;; Función para leer el contenido de un archivo
(define (read-file filepath)
  (call-with-input-file filepath
    (lambda (in)
      (port->string in))))