\ Extension to graphics.4th 
\ Color palette: 6-level-RGB.  Color range from 0-5
\ and the palette number is given by 36*red + 6*green + blue
\ with a maximum value of 215.  Conversion is saved in a .pgm
\ format grayscale image  which can be viewed as a funky
\ grayscale image. Ref: "List of Software Palettes," Wikipedia

[UNDEFINED] color>palette [IF]
[UNDEFINED] set_pixel     [IF] [ABORT] [THEN]

5 constant rgb_level
: (xscale)  ( -- n )
      pic_intensity @ rgb_level /  ;

: color>palette ( r g b -- n )   \ conversion to use.
   (xscale) / >r  (xscale) / >r  (xscale) / r>  r>
   swap 6 *  +  swap 36 * + ;

: palette>color ( n -- r g b )
    dup 36 / >r
    dup r@ 36 * -  6 / >r
    r'@  36 * -  r@ 6 * -
    r> r>  swap rot ;

ppm_nmax rgb_level / constant (pscale)
: scale_pixel ( r g b -- r2 g2 b2 )
    rot (pscale) *  rot (pscale) *  rot (pscale) * ;

: to_palette ( -- )  1 to c/pixel
        ' color>palette  to (color>n)
        ' palette>color  to (n>color) ;

: palette_image ( -- )   to_palette
        s" #  3-Level RGB palette (215 colors)"
        image_comment$ place 
        215 pic_intensity ! ;

[DEFINED] 4TH# [IF]
  hide (xscale)
  hide rgb_level
  hide (pscale)
[THEN]
[THEN]







