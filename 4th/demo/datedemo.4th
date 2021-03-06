\ 4tH - String to date demo - Copyright 2012 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

include lib/str2date.4th

: .date
  10000 * swap 100 * + +
  <# # # [char] - hold # # [char] - hold # # # # #> type cr
;

s" 7-8-9"    s>date .date              \ E: d-m-y  A: m-d-y  ( 0)
s" 7-8-13"   s>date .date              \ E: d-m-y  A: m-d-y  ( 1)
s" 7-8-32"   s>date .date              \ E: d-m-y  A: m-d-y  ( 2)
s" 7-13-9"   s>date .date              \ E: m-d-y  A: m-d-y  ( 3)
s" 7-13-14"  s>date .date              \ E: m-d-y  A: m-d-y  ( 4)
s" 7-13-32"  s>date .date              \ E: m-d-y  A: m-d-y  ( 5)
s" 7-32-13"  s>date .date              \ invalid             ( 7)
s" 13-8-9"   s>date .date              \ E: d-m-y  A: d-m-y  ( 9)
s" 14-8-13"  s>date .date              \ E: d-m-y  A: d-m-y  (10)
s" 14-8-32"  s>date .date              \ E: d-m-y  A: d-m-y  (11)
s" 14-13-9"  s>date .date              \ E: y-d-m  A: y-d-m  (12)
s" 32-8-9"   s>date .date              \ E: y-m-d  A: y-m-d  (18)
s" 32-8-13"  s>date .date              \ E: y-m-d  A: y-m-d  (19)
s" 32-8-33"  s>date .date              \ invalid             (20)
s" 32-13-9"  s>date .date              \ E: y-d-m  A: y-d-m  (21)
s" 33-32-13" s>date .date              \ invalid             (25)
depth .