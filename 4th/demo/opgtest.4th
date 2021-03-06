\ ==== Testing ====
include lib/opgftran.4th
include lib/anstools.4th 

   forth-math  ." --Forth-Math--" 
   s" 1.1e-21/(10*(1E1-0.5)^2)" 2dup cr type 
   cr ftran type  cr 
 
   s" z=(1.+x)/(1-y)^2" 2dup cr type 
   cr ftran type  cr 
 
   s" y=erf(x/sqrt(4*D*t))" 2dup cr type 
   cr ftran type  cr 
 
                  \ assume pi is a floating point constant 
  s" E = (u*b^2*l)/(|pi dup drop|*(1-v)) * exp(-2*|pi|*w/b)"  2dup cr type 
  cr ftran type cr 
 
                  \ assume some user defined function taking 3 arguments 
  s" answ=fmaxs(a,b,c)" 2dup cr type 
  cr ftran type cr
  
  standard-math  cr ." --Standard-Math--" 
  s" myvar=1000*x/25+123" 2dup cr type 
  cr ftran type cr
  .s
\ ===tesing finished === 
