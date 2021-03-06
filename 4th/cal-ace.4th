( CALENDAR for the Jupiter Ace)
( Author: Ricardo F. Lopes - 2007)
( 4tH version: Hans Bezemer - 2010)
( License: Public Domain)

( Usage: <year> <Month>   )
( Example: 2007 January   )

( Weekday calculation)
( [[month*26-54]/10 + day + [year-1900] + [year-1900]/4 - 34] MOD 7)
( SUN=0, MON=1,.. SAT=6 )  

: WEEKDAY ( year month day -- weekday )
 SWAP DUP 3 <     ( Jan & Feb considered as..)
 IF               ( ..months 13 and 14 of last year)
  12 + ROT
  1- ROT ROT
 THEN             ( year day month )
 26 * 54 - 10 / + ( year days)
 SWAP 1900 -      ( days year)
 DUP 4 / + + 34 - ( days)
 7 MOD            ( weekday)
;

( Print calendar )
: CAL ( weekday days -- )
 CR ." SUN MON TUE WED THU FRI SAT" CR
 OVER 4 * SPACES   ( Position of the first day )
 1+ 1
 DO                ( Stack: weekday )
  I 10 < 1+ SPACES ( Print tab )
  I .              ( Print day )
  1+               ( Increment day )
  DUP 6 >          ( Last column? )
  IF
   CR DROP 0       ( Next line )
  THEN 
 LOOP
 DROP
;

( Check if leap year )
: LEAPYEAR? ( year -- flag )
 DUP 100 MOD 0= 0=
 OVER 400 MOD 0= OR
 SWAP 4 MOD 0= AND
;

( Month definer)
: (MONTH)        ( year -- )
 OVER LEAPYEAR?  ( Stack: year pfa leapyear? )
 OVER CELL+ @C   ( Stack: year pfa leapyear? month )
 SWAP OVER       ( Stack: year pfa month leapyear? month )
 2 = AND         ( Stack: year pfa month +1? )
 ROT @C +        ( Stack: year month days )
 ROT ROT 1       ( Stack: days year month 1 )
 WEEKDAY         ( Stack: days weekday )
 SWAP            ( Stack: weekday days )
 CAL CR
;

( Months)
CREATE JANUARY   31 ,  1 , DOES> (MONTH) ;
CREATE FEBRUARY  28 ,  2 , DOES> (MONTH) ;
CREATE MARCH     31 ,  3 , DOES> (MONTH) ;
CREATE APRIL     30 ,  4 , DOES> (MONTH) ;
CREATE MAY       31 ,  5 , DOES> (MONTH) ;
CREATE JUNE      30 ,  6 , DOES> (MONTH) ;
CREATE JULY      31 ,  7 , DOES> (MONTH) ;
CREATE AUGUST    31 ,  8 , DOES> (MONTH) ;
CREATE SEPTEMBER 30 ,  9 , DOES> (MONTH) ;
CREATE OCTOBER   31 , 10 , DOES> (MONTH) ;
CREATE NOVEMBER  30 , 11 , DOES> (MONTH) ;
CREATE DECEMBER  31 , 12 , DOES> (MONTH) ;

\ =============
\ 4tH interface
\ =============

include lib/interprt.4th

: bye quit ;

create wordlist                        \ dictionary
 ," january" ' january , ," february" ' february , ," march"     ' march     ,
 ," april"   ' april   , ," may"      ' may      , ," june"      ' june      ,
 ," july"    ' july    , ," august"   ' august   , ," september" ' september ,
 ," october" ' october , ," november" ' november , ," december"  ' december  ,
 ," quit"    ' bye     , ," exit"     ' bye      , ," bye"       ' bye       ,
 ," q"       ' bye     , NULL ,

wordlist to dictionary

begin ." OK" cr refill drop ' interpret catch if ." Error" cr then again
