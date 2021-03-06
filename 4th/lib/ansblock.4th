\ 4tH library - BLOCK - Copyright 2006,2012 J.L. Bezemer
\ You can redistribute this file and/or modify it under
\ the terms of the GNU General Public License

\ Load definitions when needed
[UNDEFINED] e.ioerr [IF]
[NEEDS lib/throw.4th]
[THEN]

[UNDEFINED] BLOCK [IF]
    (error) constant empty             \ unassigned buffers
         64 constant c/l               \ characters per line
         16 constant l/scr             \ lines per editing screen
c/l l/scr * constant b/buf             \ size of an editing screen

     256 string block-file             \ name of block file
b/buf 1+ string block-buffer           \ block buffer and termination byte

variable scr                           \ 7.6.2.2190
variable blk                           \ holding current block nr.
variable ichan                         \ saving input device in use
variable ochan                         \ saving output device in use
variable dirty                         \ buffer dirty?

: chans> cin ichan ! cout ochan ! ;    ( --)
: >chans ichan @ use ochan @ use ;     ( --)
: ?throw if >chans e.ioerr throw then ;
                                       \ performs i/o and returns buffer
: open-block                           ( n1 -- n1 h2 a1 n2)
  chans> block-file count output input + open dup error? ?throw use
  over b/buf * dup 0< ?throw over seek ?throw block-buffer b/buf
;

: close-block close >chans blk ! ;     ( n h --)
: read-block open-block accept b/buf < ?throw close-block ;
: write-block open-block type close-block ;
: save-buffers dirty @ if blk @ write-block false dirty ! then ;
: empty-buffers false dirty ! empty blk ! ;
: open-blockfile block-file place 0 block-buffer b/buf + c! empty-buffers ;
: flush save-buffers empty-buffers ;   ( --)
: flush? blk @ over <> dup if flush then ;
: block flush? if read-block else drop then block-buffer ;
: buffer flush? drop blk ! block-buffer ;
: update true dirty ! ;                ( --)
: clear buffer b/buf blank update ;    ( n --)

: create-blockfile                     ( n1 a2 n2 --)
  output open error?                   \ open file and write spaces
  if drop drop else tuck use b/buf * 0 ?do bl emit loop close then
;

: list                                 ( n --)
  base @ swap dup dup scr ! cr ." Scr # " . block decimal
  l/scr 0 do cr i 3 .r space i c/l * over + c/l type loop cr drop base !
;

aka flush close-blockfile

[DEFINED] 4TH# [IF]
  hide write-block
  hide read-block
  hide close-block
  hide open-block
  hide flush?
  hide ?throw
  hide >chans
  hide chans>
  hide dirty
  hide ochan
  hide ichan
  hide block-buffer
  hide block-file
  hide empty
[THEN]
[THEN]
