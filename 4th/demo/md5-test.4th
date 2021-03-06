\ ==============================================================================

\          md5_test - the test words for the md5 module in the ffl

\               Copyright (C) 2006  Dick van Oudheusden

\ This library is free software; you can redistribute it and/or
\ modify it under the terms of the GNU General Public
\ License as published by the Free Software Foundation; either
\ version 2 of the License, or (at your option) any later version.

\ This library is distributed in the hope that it will be useful,
\ but WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
\ General Public License for more details.

\ You should have received a copy of the GNU General Public
\ License along with this library; if not, write to the Free
\ Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

\ ==============================================================================

\  $Date: 2007-12-24 19:32:12 $ $Revision: 1.3 $

\ ==============================================================================

include lib/md5.4th
include lib/tst.4th
include lib/memchar.4th

[DEFINED] md5-init [IF]

.( Testing: md5) cr
                                       ( -- md5 = Create a new MD5 variable on the heap )
: md5-new /md5 allocate throw dup md5-init ;
: md5-free free throw ;                ( md5 -- = Free the MD5 variable from the heap )

/md5 buffer: m1 latest md5-init

[hex]

t{ s" 0123456789012345678901234567890123456789012345678901234567890123" m1 md5-update }t

t{ m1 md5-finish 548C5F53 ?u 3F9EE1AC ?u 6ADE0987 +UL ?u 34FD7B7F ?u }t

t{ m1 md5-reset }t

t{ s" 01234567890123456789012345678901234567890123456789012345678901234567890" m1 md5-update }t

t{ m1 md5-finish md5+to-string s" 8CA2DC1109EC719046F23D92EFE819F7" ?str }t

t{ m1 md5-reset }t

t{ s" 01234567890123456789012345678" m1 md5-update }t

t{ s" 90123456789012345678901234567" m1 md5-update }t

t{ s" 8901234567890" m1 md5-update }t

t{ m1 md5-finish md5+to-string s" 8CA2DC1109EC719046F23D92EFE819F7" ?str }t

t{ md5-new value m2 }t

t{ s" Hello" m2 md5-update }t

t{ m2 md5-finish 570478C4 +UL ?u 78AB27A8 +UL ?u 161261C4 +UL ?u 53991A8B ?u }t

t{ m2 md5-reset }t

t{ s" 01234567890123456789012345678901234567890123456789012345" m2 md5-update }t

t{ m2 md5-finish 98C6453 ?u 1B79B042 ?u 67107684 +UL ?u 3270F28A +UL ?u }t

t{ m2 md5-free }t

[decimal]

[THEN]

\ ==============================================================================