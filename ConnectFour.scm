#lang racket
;Jamison Weber
;this program runs a complete connect-4 game simulation with the ability to match player versus player, player versus computer, or computer versus computer.
;Connect Four
(define (getCell Matrix Row Column)
  (if (null? Matrix)
      '()
      (if (= Row 1)
          (getValue (car Matrix) Column)
          (getCell (cdr Matrix) (- Row 1) Column)
      )
  )
)
(define (setCell Matrix Row Column Item)
  (if (null? Matrix)
      '()
      (if (= Row 1)
          (cons (setValue (car Matrix) Column Item) (cdr Matrix))
          (cons (car Matrix)(setCell (cdr Matrix) (- Row 1) Column Item))
      )
  )
)
(define (getValue List Index)
  (if (null? List)
      '()
      (if (= Index 1)
          (car List)
          (getValue (cdr List) (- Index 1))
      )
  )
)
(define (setValue List Index Value)
  (if (null? List)
      (cons Value '())
      (if (= Index 1)
          (cons Value (cdr List))
          (cons (car List) (setValue (cdr List) (- Index 1) Value))
      )
  )
)
;Connect Four functions
; global variable
(define Game 0)
(define (StartGame)
  (begin
    (set! Game '(R (O O O O O O O)(O O O O O O O)(O O O O O O O)(O O O O O O O)(O O O O O O O)(O O O O O O O)))
    (display "Just Another Machine Intelligence Sorting Out Numbers\n")
    ;(ShowGame)
    #t
  )
)

;show game
(define (ShowGame)
  (begin
      (display (getValue Game 7))
      (newline)
      (display (getValue Game 6))
      (newline)
      (display (getValue Game 5))
      (newline)
      (display (getValue Game 4))
      (newline)
      (display (getValue Game 3))
      (newline)
      (display (getValue Game 2))
      (newline)
     #t
  )
)
; Mark move
(define (MarkMove Col)
  (begin
    (MarkMoveAssist 1 Col)
        (if (eq? (WinP Col) #t)
            (if (eq? (car Game) 'R)
                (display "Black has won!\n")
                (display "Red has won!\n")
            )
            (display "No winner yet!\n")
        )
    (ShowGame)
    Col
  )
)
         
(define (MarkMoveAssist Row Col)
  (if (= Row 7)
      (display "Illegal Move\n") 
      (if (equal? (getCell (cdr Game) Row Col) 'O)
              (set! Game (cons (swapColor) (setCell (cdr Game) Row Col (car Game))))
              (MarkMoveAssist (+ Row 1) Col)
      )
  )
)
(define (swapColor)
  (if (eq? (car Game) 'B)
      'R
      'B
  )
)
; legal move
(define (LegalMoveP Col)
	(LegalMovePassist 1 Col)
)
(define (LegalMovePassist Row Col)
	(if (= Row 7)
		#f
		(if (equal? (getCell (cdr Game) Row Col) 'O)
			#t
			(LegalMovePassist (+ Row 1) Col)
		)
	)
)
; will win testers

(define (WillWinP Col)
	(if (or (or (or (eq? (TestColumns Col (getRow 7 Col) (- (getRow 7 Col) 3) (car Game)) #t) (eq? (TestRows Col (car Game)) #t)) (eq? (TestDiagUpDown Col (car Game)) #t)) (eq? (TestDiagDownUp Col (car Game)) #t))
            #t
            #f
        )
)
(define (WillBlockP Col)
	(if (or (or (or (eq? (TestColumns Col (getRow 7 Col) (- (getRow 7 Col) 3) (swapColor)) #t) (eq? (TestRows Col (swapColor)) #t)) (eq? (TestDiagUpDown Col (swapColor)) #t)) (eq? (TestDiagDownUp Col (swapColor)) #t))
            #t
            #f
        )
)
(define (TestColumns Col Row Bottom Value)
  (if (eq?  (getCell (cdr Game) Row Col) 'O)
      #f
      (if (= Row Bottom)
		#t
		(if (equal? (getCell (cdr Game) Row Col) Value)
			(TestColumns Col (- Row 1) Bottom Value)
                        #f
		)
	)
   )
)				
(define (getRow startRow Col)
  (if ( = startRow 0)
      0
      (if (or (eq? (getCell (cdr Game) startRow Col) 'R ) (eq? (getCell (cdr Game) startRow Col) 'B ))
	    startRow
	    (getRow (- startRow 1) Col )
      )
  )
)
(define (TestRows Col Value)
  (if (>= (+ (getLeft (+ (getRow 7 Col) 1) Col Value 0) (getRight (+ (getRow 7 Col) 1) Col Value 0)) 3)
      #t
      #f
  )
)

(define (getLeft Row Col Value Total)
      (if (eq? (getCell (cdr Game) Row (- Col 1)) Value)
          (getLeft Row (- Col 1) Value (+ Total 1))
          Total
      )
   
)
(define (getRight Row Col Value Total)
  (if (eq? (getCell (cdr Game) Row (+ Col 1)) Value)
      (getRight Row (+ Col 1) Value (+ Total 1))
      Total
  )
)
(define (TestDiagUpDown Col Value)
    (if (>= (+ (getLeftUpDown (+ (getRow 7 Col) 1) Col Value 0) (getRightUpDown (+ (getRow 7 Col) 1) Col Value 0)) 3)
      #t
      #f
  )
)
(define (getLeftUpDown Row Col Value Total)
      (if (eq? (getCell (cdr Game) (+ Row 1) (- Col 1)) Value)
          (getLeftUpDown (+ Row 1) (- Col 1) Value (+ Total 1))
          Total
      )
   
)
(define (getRightUpDown Row Col Value Total)
  (if (eq? (getCell (cdr Game) (- Row 1) (+ Col 1)) Value)
      (getRightUpDown (- Row 1) (+ Col 1) Value (+ Total 1))
      Total
  )
)
(define (TestDiagDownUp Col Value)
    (if (>= (+ (getLeftDownUp (+ (getRow 7 Col) 1) Col Value 0) (getRightDownUp (+ (getRow 7 Col) 1) Col Value 0)) 3)
      #t
      #f
  )
)
(define (getLeftDownUp Row Col Value Total)
      (if (eq? (getCell (cdr Game) (- Row 1) (- Col 1)) Value)
          (getLeftDownUp (- Row 1) (- Col 1) Value (+ Total 1))
          Total
      )
   
)
(define (getRightDownUp Row Col Value Total)
  (if (eq? (getCell (cdr Game) (+ Row 1) (+ Col 1)) Value)
      (getRightDownUp (+ Row 1) (+ Col 1) Value (+ Total 1))
      Total
  )
)
; win testers

(define (WinP Col)
	(if (or (or (or (eq? (TestColumns Col (- (getRow 7 Col) 1) (- (getRow 7 Col) 4) (swapColor)) #t) (eq? (TestRowswintest Col (swapColor)) #t)) (eq? (TestDiagUpDownwintest Col (swapColor)) #t)) (eq? (TestDiagDownUpwintest Col (swapColor)) #t))
            #t
            #f
        )
)
(define (TestRowswintest Col Value)
  (if (>= (+ (getLeft (getRow 7 Col) Col Value 0) (getRight (getRow 7 Col) Col Value 0)) 3)
      #t
      #f
  )
)
(define (TestDiagUpDownwintest Col Value)
    (if (>= (+ (getLeftUpDown (getRow 7 Col) Col Value 0) (getRightUpDown (getRow 7 Col) Col Value 0)) 3)
      #t
      #f
  )
)
(define (TestDiagDownUpwintest Col Value)
    (if (>= (+ (getLeftDownUp (getRow 7 Col) Col Value 0) (getRightDownUp (getRow 7 Col) Col Value 0)) 3)
      #t
      #f
  )
)
; make move
; first the computer will check to see if they can make a winning move. Next it will check to see if they can block the winning move from its opponent.
; Finally, it will try to build on existing columns, diagonals or rows of two so that it can win next turn.
; if none of those are options, it will choose a random legal move.
(define (MakeMove)
  (MarkMove (CheckWin 7))
)

(define (legalRandom num)
  (if (eq? (LegalMoveP num) #t)
      num
      (legalRandom (+ (random 7) 1))
  )
)
(define (CheckWin Col)
  ( if ( = Col 0)
       (CheckBlock 7)
       (if (and (eq? (LegalMoveP Col) #t) (eq? (WillWinP Col) #t))
           Col
           (CheckWin (- Col 1))
       )
   )
)
(define (CheckBlock Col)
  ( if ( = Col 0)
       (Strategy 7)
       (if (and (eq? (LegalMoveP Col) #t) (eq? (WillBlockP Col) #t))
           Col
           (CheckBlock (- Col 1))
       )
   )
)
(define (Strategy Col)
  (if (= Col 0)
      (legalRandom (+ (random 7) 1))
      (if (and (eq? (LegalMoveP Col) #t) (eq? (TestColumns Col (getRow 7 Col) (- (getRow 7 Col) 2) (car Game)) #t))
          Col
          (if (and (eq? (LegalMoveP Col) #t) (>= (+ (getLeft (+ (getRow 7 Col) 1) Col (car Game) 0) (getRight (+ (getRow 7 Col) 1) Col (car Game) 0)) 2))
              Col
              (if (and (eq? (LegalMoveP Col) #t) (>= (+ (getLeftUpDown (+ (getRow 7 Col) 1) Col (car Game) 0) (getRightUpDown (+ (getRow 7 Col) 1) Col (car Game) 0)) 2))
                  Col
                  (if (and (eq? (LegalMoveP Col) #t) (>= (+ (getLeftDownUp (+ (getRow 7 Col) 1) Col (car Game) 0) (getRightDownUp (+ (getRow 7 Col) 1) Col (car Game) 0)) 2))
                      Col
                      (Strategy (- Col 1))
                  )
              )
         )
      )
  )
)