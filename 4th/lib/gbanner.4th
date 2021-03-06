\ banner.seq - compliments of f83x
\ mod to sequential by Tom Zimmer, 4tH version Hans Bezemer
\ hacked here for use with ppm graphics files - D Johnson

[UNDEFINED] gbanner [IF]
[UNDEFINED] set_pixel [IF]  [ABORT]  [THEN]

[UNDEFINED] char>upper [IF]
[NEEDS lib/ulcase.4th]
[THEN]

[HEX]
create char-matrix                      \ build the character generator
    (  ) 00000000 , 00000000 ,
    ( !) 10101010 , 10001000 ,
    ( ") 28282800 , 00000000 ,
    ( #) 28287C28 , 7C282800 ,
    ( $) 103C5038 , 14781000 ,
    ( %) 60640810 , 204C0C00 ,
    ( &) 20505020 , 54483400 ,
    ( ') 18180810 , 00000000 ,
    ( () 10204040 , 40201000 ,
    (  ) 10080404 , 04081000 ,
    ( *) 10543810 , 38541000 ,
    ( +) 00101038 , 10100000 ,
    ( ,) 00000018 , 18081000 ,
    ( -) 00000038 , 00000000 ,
    ( .) 00000000 , 00181800 ,
    ( /) 00040810 , 20400000 ,
    ( 0) 38444C54 , 64443800 ,
    ( 1) 10301010 , 10103800 ,
    ( 2) 38440418 , 20407C00 ,
    ( 3) 7C081018 , 04443800 ,
    ( 4) 08182848 , 7C080800 ,
    ( 5) 7C407804 , 04443800 ,
    ( 6) 1C204078 , 44443800 ,
    ( 7) 7C040810 , 20202000 ,
    ( 8) 38444438 , 44443800 ,
    ( 9) 3844443C , 04087000 ,
    ( :) 00303000 , 30300000 ,
    ( ;) 00303000 , 30302000 ,
    ( <) 08102040 , 20100800 ,
    ( =) 00007C00 , 7C000000 ,
    ( >) 20100804 , 08102000 ,
    ( ?) 38440810 , 10001000 ,
    ( @) 3844545C , 58403C00 ,
    ( a) 10384444 , 7C444400 ,
    ( b) 78444478 , 44447800 ,
    ( c) 38444040 , 40443800 ,
    ( d) 78242424 , 24247800 ,
    ( e) 7C404078 , 40407C00 ,
    ( f) 7C404078 , 40404000 ,
    ( g) 3C404040 , 4C443C00 ,
    ( h) 4444447C , 44444400 ,
    ( i) 38101010 , 10103800 ,
    ( j) 04040404 , 04443C00 ,
    ( k) 44485060 , 50484400 ,
    ( l) 40404040 , 40407C00 ,
    ( m) 446C5454 , 44444400 ,
    ( n) 44446454 , 4C444400 ,
    ( o) 38444444 , 44443800 ,
    ( p) 78444478 , 40404000 ,
    ( q) 38444444 , 54483400 ,
    ( r) 78444478 , 50484400 ,
    ( s) 38444038 , 04443800 ,
    ( t) 7C101010 , 10101000 ,
    ( u) 44444444 , 44443800 ,
    ( v) 44444444 , 44281000 ,
    ( w) 44444454 , 546C4400 ,
    ( x) 44442810 , 28444400 ,
    ( y) 44442810 , 10101000 ,
    ( z) 7C040810 , 20407C00 ,
    ( [) 3C202020 , 20203C00 ,
    ( \) 00402010 , 08040000 ,
    ( ]) 78080808 , 08087800 ,
    ( ^) 00001028 , 44000000 ,
    ( _) 00000000 , 0000007C ,
[DECIMAL]

variable textrot    \ Either 0 = "vertical"  or 1 = "horizontal"   )
variable textdir    \ Either 1 or -1: draw text up/downwards

variable rx_text    \ Keep track of placement on screen
variable cy_text


variable rx0        \ Variables to handle the vector
variable cy0        \ execution of text orientation
2 array dobit
2 array dowrt

1 textrot !         \ Set some defaults
1 textdir !

: bitpos1  (  -- )  textdir @   rx_text +! ;
: bitpos2  ( -- )   textdir @   cy_text +! ;

' bitpos1 dobit 0 th !
' bitpos2 dobit 1 th !

: bit?                                 ( n ---)
  7 - 1 swap rshift and
  if rx_text @  cy_text @  set_pixel then
  dobit textrot @ th  @ execute ;

: wrt1 ( -- )  textdir @  negate  cy_text +!  rx0 @  rx_text ! ;
: wrt2 ( -- )  textdir @          rx_text +!  cy0 @  cy_text ! ;

' wrt1 dowrt 0 th !
' wrt2 dowrt 1 th !

: gbanner  ( rx cy  a n -- )
  2swap   dup cy_text !  cy0 !   dup rx_text !  rx0 !
  bounds 8 0 do
    dowrt textrot @ th   @ execute
    over over ?do
      i c@ 127 and char>upper
      32 - 2 cells * char-matrix + j
      4 /mod swap >r + @c r> 3 - 8 * lshift
      8 1 do dup i bit? loop drop
    loop
  loop drop drop
;

: horizontal ( -- )  1 textrot ! ;
: vertical  ( -- )   0 textrot ! ;
: text_up ( -- )     1 textdir ! ;
: text_down ( -- )  -1 textdir ! ;

[DEFINED] 4TH# [IF]
  hide bit?
  hide char-matrix
  hide rx0
  hide cy0
  hide dobit
  hide dowrt
  hide textrot
  hide textdir
  hide bitpos1
  hide bitpos2
  hide wrt1
  hide wrt2
[THEN]
[THEN]


