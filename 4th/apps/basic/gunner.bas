10 REM PRINT TAB(30);"GUNNER"
20 REM PRINT TAB(15);"CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
30 REM PRINT:PRINT:PRINT
130 PRINT "YOU ARE THE OFFICER-IN-CHARGE, GIVING ORDERS TO A GUN"
140 PRINT "CREW, TELLING THEM THE DEGREES OF ELEVATION YOU ESTIMATE"
150 PRINT "WILL PLACE A PROJECTILE ON TARGET.  A HIT WITHIN 100 YARDS"
160 PRINT "OF THE TARGET WILL DESTROY IT." : PRINT
170 R=(RND(40000)+20000)
180 PRINT "MAXIMUM RANGE OF YOUR GUN IS ";R;" YARDS."
185 Z=0
190 PRINT
195 A=0
200 T=R/10 : T=T*(RND(9)+1)
210 S=0
220 GOTO 370
230 PRINT "MINIMUM ELEVATION IS ONE DEGREE."
240 GOTO 390
250 PRINT "MAXIMUM ELEVATION IS 89 DEGREES."
260 GOTO 390
270 PRINT "OVER TARGET BY ";-X;" YARDS."
280 GOTO 390
290 PRINT "SHORT OF TARGET BY ";X;" YARDS."
300 GOTO 390
320 PRINT "*** TARGET DESTROYED ***  ";S;" ROUNDS OF AMMUNITION EXPENDED."
325 A=A+S
330 IF Z=4 THEN GOTO 490
340 Z=Z+1
345 PRINT
350 PRINT "THE FORWARD OBSERVER HAS SIGHTED MORE ENEMY ACTIVITY..."
360 GOTO 200
370 PRINT "DISTANCE TO THE TARGET IS ";T;" YARDS."
380 PRINT
390 PRINT
400 INPUT "ELEVATION (0.1 degrees): ";B
420 IF B>890 THEN GOTO 250
430 IF B<10 THEN GOTO 230
440 S=S+1
442 IF S<6 THEN GOTO 450
444 PRINT:PRINT "BOOM !!!!   YOU HAVE JUST BEEN DESTROYED ";
446 PRINT "BY THE ENEMY." : PRINT : PRINT : PRINT : GOTO 495
450 @(250)=B*20000/573 : GOSUB 9000 : I=(R*@(250))/10000 : X=T-I
460 IF (X>-100)*(X<100) THEN GOTO 320
470 IF X>100 THEN GOTO 290
480 GOTO 270
490 PRINT : PRINT : PRINT "TOTAL ROUNDS EXPENDED WERE: ";A
492 IF A>18 THEN GOTO 495
493 PRINT "NICE SHOOTING !!" : GOTO 500
495 PRINT "BETTER GO BACK TO FORT SILL FOR REFRESHER TRAINING!"
500 PRINT : INPUT "TRY AGAIN (Y=1 OR N=0): ";Z
510 IF Z=1 THEN GOTO 170
520 PRINT:PRINT "OK.  RETURN TO BASE CAMP."
999 END
9000 LET @(251)=0 : LET @(251)=@(250)<0 : IF @(251) THEN LET @(250)=-@(250)
     LET @(250)=@(250)%62832 : IF @(250)>31416 THEN LET @(251)=@(251)=0 : LET @(250)=@(250)-31416
     IF @(250)>15708 THEN LET @(250)=31416-@(250)
     LET @(252)=(@(250)*@(250))/10000 : LET @(253)=10000+((10000*-(@(252)/72))/10000)
     LET @(253)=10000+((@(253)*-(@(252)/42))/10000) : LET @(253)=10000+((@(253)*-(@(252)/20))/10000)
     LET @(253)=10000+((@(253)*-(@(252)/6))/10000) : LET @(250)=(@(250)*@(253))/10000
     IF @(251) THEN LET @(250)=-@(250)
     RETURN
     REM ** This is an integer SIN subroutine. Input and output are scaled by 10K.
