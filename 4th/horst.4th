(  The van der Horst Algorithm in Forth --- with minor modifications
    for kForth and 4tH.                               

    The "van der Horst" algorithm is a small example program that      
    finds a factorization of numbers with reasonable "small"            
    factors. For a 32 bit FORTH this means any factors < 2,000,000,000  
    The input number can be very large indeed, large enough that the    
    algorithm becomes totally impractical. [State of the art factoring  
    uses elliptic curves or quadratic polynomial sieves]                

    It is based on a very well known base conversion routine and the    
    observation that if you have given a number in base ``b'', its      
    divisibility by ``b'' can be established by inspecting the last     
    digit of the number.                                                
    Example : is 97321087 divisible by 10? Answer : no.                 
    The base conversion rewrites the number from one base to the next   
    and so on with only a small number of additions.                    
    Some lack of modesty is needed to call this combination a new       
    algorithm and put your name on it.                                  

    Author : Albert van der Horst/Adrie Bos/Marcel Hendrix              
    Rewritten as a pure ANSI forth example by Albert van der Horst )

DECIMAL

include lib/dbldot.4th

\ ( The auxiliary word to forget this application is ``-horst'' )


\ S" TFORTH" ENVIRONMENT? 
\  [IF] DROP
\       REVISION -horst " HORST version 4.5 --- ANSI version [LC index bug in HORST]"
\ [ELSE] MARKER -horst
       CR .( loading HORST version 4.5 --- 4tH version [LC index bug in HORST]) CR
\ [THEN]

\ S" TFORTH" ENVIRONMENT? 0= [IF] 
  CHAR 0  CONSTANT &0              \ Ascii value of '0'

\ : <=    > 0= ;
: C@+ dup char+ swap c@ ;

\ [ELSE]  DROP
\ [THEN]

( PART 2 : DATA STRUCTURES 
  ********************************************************************* )

1000 CONSTANT MAX.DIGITS       \ Maximum number of bits handled

\ The number to be factored is represented as follows :
\ num = sum(i from 0 to length-1 : num[i]*current.base^(len-1-i) )
( or in more mundane parlance :
  the lowest `length' cells of `num' represent digits in base 
  `current.base', lowest are the most significant digits )
VARIABLE current.base
VARIABLE length
MAX.DIGITS ARRAY num does> swap th ;

( PART 3 : ALGORITHM
  ********************************************************************* )

( Before and after HORST the number represented by `num' is the same.   
  Only `current.base' is one higher than before.                        
  At point one `num' is in a "mixed base" representation with the       
  I left most digits in the new base and the remainder still in the     
  old base, throughout representing the same number.                    
  See also Knuth: The art of computer programming page 306 :            
  a "Hand calculation" for going from octal to decimal.                 
  Only ours is even simpler because our bases differ by 1 not by 2 )
: HORST ( --- )
     1 current.base +!                  \ Next number base
     current.base @ 0< ABORT" Remaining factors too large to handle"
     length @ 1 ?DO
          ( point one )
          0 I DO
             I num @
             I 1- num @ -               \ subtract more significant digit
             DUP 0< IF                  \ Negative?
                -1 I 1- num +!          \ Borrow
                current.base @ +        \  a "ten"
             THEN
             I num !
          -1 +LOOP
     LOOP
;


( Simplifies the number by eliminating leading zero digits              
  Note the nasty conditioning about length,                            
  needs very careful treatment in Forth. )
: SIMPLIFY ( --- )
     BEGIN
           2  length @  <= 	\ Prevent wrap around loop for length 1
           0 num @ 0=
           AND
     WHILE
           length @ 1- 0 DO     \ Shift to the right
              I 1+ num @ I num !
           LOOP
           -1 length +!         \ One shorter now
     REPEAT
;


( Convert the number to the next higher base )
: NEXT.FACTOR ( --- )
     HORST
     SIMPLIFY
;


( Store the 4 bits of <word> at 4 successive lower addresses beneath    
  <adr1>. The last address used is returned.                            
  Least significant bit is stored highest. )
: SPLIT4 ( adr1 word --- adr2 )
     SWAP
     4 0 DO                     \ For all 4 bits:
          1- >R                 \ Decrement and store index
          2 /MOD SWAP           \ Split off right most bit
          R@ num !              \ Store it
          R>                    \ Get index back
     LOOP
     SWAP DROP                  \ Drop the remainder
;


( Convert the decimal number as given to binary.
  Apply HORST 6 times for base 16. 
  Then each digit contain 4 bits of the number, 
  split them over 4 cells. )
: DEC.TO.BIN ( --- )
     6 0 DO NEXT.FACTOR LOOP    \ Now in HEX
     length @ 4 *               \ Point after last cell of binary representation
     -1 length @ 1- DO          \ From the end to prevent overwrites
          I num @               \ Hex digit I
          SPLIT4                \ distribute the bits
     -1 +LOOP  ( index) DROP

     length @ 4 *
     length !                   \ 4 times as much digits
     2 current.base !           \  `num' is binary now

     SIMPLIFY                   \ Rid of leading zero's

     length @ 1 =               \ But not of the last one,
     0 num @ 0=                 \  because of looping finesses
     AND ABORT" Zero cannot be factored"
;

( Convert a character digit to a binary representation ) 
: ASCII->BINARY ( char --- double )
     &0 -
     DUP 0< OVER 9 > OR ABORT" Not a decimal number"
;

( Get a decimal number from the input stream and store it in a
  base 10 representation in ``num'' )
: READ.NUMBER           \ ( --- ) accepts  "number.string"
     refill drop 0 parse
     DUP 0= ABORT" Please input a number"
     DUP length !               \ Remember!
     0 DO                       \  Convert each digit
          C@+ ASCII->BINARY
          I num !               \  to binary in number.
     LOOP DROP                  \  Drop string address.
     10 current.base !          \ Start with decimal
;

( Print the remaining factor.
  Depending on the circumstances the number may have 1 or 2
  digits. It is always prime, because smaller numbers have been
  factored out. If it is 1 it is not printed, of course. )
: LAST.FACTOR ( --- )
     length @ 1 = IF
        0 num @ DUP 1 <> IF
           CR ." Factor: " current.base @ U.
        ELSE
           DROP                 \ Factor 1 not interesting 
        THEN
     ELSE
        ( Calculate the number represented by `num' )
        ( Double precision is sufficient )
        0 num @   current.base @   UM*
        1 num @   U>D   D+
        CR ." Factor: " D.
     THEN
;

( It is well known that we need not look for factors in a number
  that are larger than its square root.
  In the representation choosen this means that it need less than 2 
  digits to be represented. The flag indicated there may be factors to
  be found. )
: NOT.PAST.SQRT ( --- flag )
          2 length @ <
;


( The number `num' is divisable by base if the last digit is zero
( The flag indicates whether `num' is divisable by `current.base' )
: ?DIVISABLE ( --- flag )
               length @ 1- num @ 0=
;

( And finally ......

 `FACTORIZE' accepts a string in the input stream with decimal digits
 and factorizes it. )
: FACTORIZE
     ." Factorize: " READ.NUMBER
     DEC.TO.BIN
     BEGIN
        NOT.PAST.SQRT WHILE
          BEGIN
             ?DIVISABLE WHILE
                CR ." Factor: " current.base @ U.
                -1 length +!    \ This divides by factor, scrap the last 0
          REPEAT
          NEXT.FACTOR           \ Base conversion
     REPEAT
     LAST.FACTOR		\ Print the last factor
;

factorize
