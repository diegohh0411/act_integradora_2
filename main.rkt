#lang racket

(require "dfa.rkt"
         "keywords-dfa.rkt"
         "comments-dfa.rkt"
         "numbers-dfa.rkt"
         "operators-dfa.rkt"
         )

;; Pure function to escape HTML special characters
(define (escape-html text)
  (foldr (lambda (replacement acc)
           (string-replace acc (car replacement) (cdr replacement)))
         text
         '(("&" . "&amp;") ("<" . "&lt;") (">" . "&gt;") ("\"" . "&quot;"))))

;; Pure function to split text into tokens while preserving whitespace and separating symbols
(define (tokenize text)
  (define (is-symbol-char? c)
    (or (char=? c #\() (char=? c #\)) (char=? c #\:) (char=? c #\;) 
        (char=? c #\,) (char=? c #\.) (char=? c #\=) (char=? c #\+) 
        (char=? c #\-) (char=? c #\*) (char=? c #\/) (char=? c #\<) 
        (char=? c #\>) (char=? c #\!) (char=? c #\&) (char=? c #\|)
        (char=? c #\[) (char=? c #\]) (char=? c #\{) (char=? c #\})))
  
  (define (is-identifier-char? c)
    (or (char-alphabetic? c) (char-numeric? c) (char=? c #\_)))
  
  ;; Helper function to extract comment from current position to end of line
  (define (extract-comment-line str)
    (define (extract-helper remaining acc)
      (cond
        [(string=? remaining "") acc]
        [(char=? (string-ref remaining 0) #\newline) acc]
        [(char=? (string-ref remaining 0) #\return) acc]
        [else (extract-helper (substring remaining 1) 
                             (string-append acc (string (string-ref remaining 0))))]))
    (extract-helper str ""))
  
  ;; Helper function to skip comment in the string
  (define (skip-comment-line str)
    (define (skip-helper remaining)
      (cond
        [(string=? remaining "") ""]
        [(char=? (string-ref remaining 0) #\newline) remaining]
        [(char=? (string-ref remaining 0) #\return) remaining]
        [else (skip-helper (substring remaining 1))]))
    (skip-helper str))
  
  (define (split-helper str acc current-token token-type)
    (cond
      [(string=? str "") 
       (if (string=? current-token "")
           (reverse acc)
           (reverse (cons current-token acc)))]
      [else
       (let ([first-char (string-ref str 0)]
             [rest-str (substring str 1)])
         (cond           ;; Handle comments - detect # anywhere and treat rest of line as comment
           [(char=? first-char #\#)
            (let ([comment-line (string-append "#" (extract-comment-line rest-str))]
                  [remaining-str (skip-comment-line rest-str)])
              (if (string=? current-token "")
                  (split-helper remaining-str (cons comment-line acc) "" 'none)
                  (split-helper remaining-str (cons comment-line (cons current-token acc)) "" 'none)))]
           ;; Handle whitespace
           [(char-whitespace? first-char)
            (cond
              [(eq? token-type 'whitespace)
               (split-helper rest-str acc (string-append current-token (string first-char)) 'whitespace)]
              [(string=? current-token "")
               (split-helper rest-str acc (string first-char) 'whitespace)]
              [else
               (split-helper rest-str (cons current-token acc) (string first-char) 'whitespace)])]
           ;; Handle symbols
           [(is-symbol-char? first-char)
            (cond
              [(eq? token-type 'symbol)
               (split-helper rest-str acc (string-append current-token (string first-char)) 'symbol)]
              [(string=? current-token "")
               (split-helper rest-str acc (string first-char) 'symbol)]
              [else
               (split-helper rest-str (cons current-token acc) (string first-char) 'symbol)])]
           ;; Handle identifiers and keywords
           [(is-identifier-char? first-char)
            (cond
              [(eq? token-type 'identifier)
               (split-helper rest-str acc (string-append current-token (string first-char)) 'identifier)]
              [(string=? current-token "")
               (split-helper rest-str acc (string first-char) 'identifier)]
              [else
               (split-helper rest-str (cons current-token acc) (string first-char) 'identifier)])]
           ;; Handle other characters
           [else
            (cond
              [(eq? token-type 'other)
               (split-helper rest-str acc (string-append current-token (string first-char)) 'other)]
              [(string=? current-token "")
               (split-helper rest-str acc (string first-char) 'other)]
              [else
               (split-helper rest-str (cons current-token acc) (string first-char) 'other)])]))]))
  
  (split-helper text '() "" 'none))

;; Pure function to check if a token matches any DFA and return the CSS class
(define (find-matching-class token dfa-class-pairs)
  (define (check-dfas pairs)
    (cond
      [(null? pairs) #f]
      [else
       (let ([dfa-list (car (car pairs))]
             [css-class (cdr (car pairs))])
         (if (any-dfa-accepts? dfa-list token)
             css-class
             (check-dfas (cdr pairs))))]))
  
  (check-dfas dfa-class-pairs))

;; Helper function to check if any DFA in a list accepts a token
(define (any-dfa-accepts? dfa-list token)
  (cond
    [(null? dfa-list) #f]
    [(dfa-accepts? (car dfa-list) token) #t]
    [else (any-dfa-accepts? (cdr dfa-list) token)]))

;; Pure function to highlight tokens
(define (highlight-tokens tokens dfa-class-pairs)
  (map (lambda (token)
         (let ([css-class (find-matching-class token dfa-class-pairs)])
           (if css-class
               (format "<span class=\"~a\">~a</span>" css-class token)
               token)))
       tokens))

;; Pure function to highlight text using token-based approach
(define (highlight-with-dfas text dfa-class-pairs)
  (let* ([tokens (tokenize text)]
         [highlighted-tokens (highlight-tokens tokens dfa-class-pairs)])
    (string-join highlighted-tokens "")))

;; Pure function to generate CSS styles
(define (generate-css-styles)
  (string-append
   "        body { font-family: 'Courier New', monospace; background-color: #f5f5f5; margin: 20px; }\n"
   "        .code-container { background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }\n"
   "        .keyword { color: #000fff; font-weight: bold; }\n"
   "        .number { color: #008000; font-weight: bold; }\n"
   "        .string { color: #ff0000; }\n"
   "        .comment { color: #808080; font-style: italic; }\n"
   "        .identifier { color: #000080; }\n"
   "        .operator { color: #ff8000; font-weight: bold; }\n"
   "        pre { white-space: pre-wrap; word-wrap: break-word; line-height: 1.4; }\n"
   "        h2 { color: #333; border-bottom: 2px solid #eee; padding-bottom: 10px; }\n"))

;; Pure function to create HTML template
(define (create-html-template highlighted-code)
  (string-append
   "<!DOCTYPE html>\n"
   "<html lang=\"en\">\n"
   "<head>\n"
   "    <meta charset=\"UTF-8\">\n"
   "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
   "    <title>Python Code Syntax Highlighter</title>\n"
   "    <style>\n"
   (generate-css-styles)
   "    </style>\n"
   "</head>\n"
   "<body>\n"
   "    <div class=\"code-container\">\n"
   "        <h2>Python Code with DFA-based Syntax Highlighting</h2>\n"
   "        <pre>" highlighted-code "</pre>\n"
   "    </div>\n"
   "</body>\n"
   "</html>"))

;; Pure function to process Python code to HTML
(define (python-to-html python-code dfas-with-classes)
  (let* ([escaped-code (escape-html python-code)]
         [highlighted-code (highlight-with-dfas escaped-code dfas-with-classes)])
    (create-html-template highlighted-code)))

;; Pure function to get DFA-class pairs
(define (get-dfa-class-pairs)
  (list (cons keywords-dfa-list "keyword")
        (cons comments-dfa-list "comment")
        (cons numbers-dfa-list "number")
        (cons operators-dfa-list "operator")
        ))

;; IO function to read file safely
(define (safe-read-file filepath)
  (if (file-exists? filepath)
      (file->string filepath)
      #f))

;; IO function to write file safely
(define (safe-write-file filepath content)
  (with-output-to-file filepath
    (lambda () (display content))
    #:exists 'replace))

;; Main IO function - the only impure function
(define (main)
  (let ([python-code (safe-read-file "./main.py")])
    (if python-code
        (let* ([dfa-pairs (get-dfa-class-pairs)]
               [html-output (python-to-html python-code dfa-pairs)])
          (safe-write-file "output.html" html-output)
          (displayln "✓ HTML file generated successfully: output.html")
          (displayln (format "✓ Processed ~a characters of Python code" 
                           (string-length python-code))))
        (displayln "✗ Error: ./main.py file not found!"))))

;; Run the main function
(main)

;; Export for debugging
(provide tokenize find-matching-class get-dfa-class-pairs)

