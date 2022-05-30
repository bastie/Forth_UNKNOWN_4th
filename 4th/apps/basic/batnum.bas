  10 PRINT "BATNUM"
     PRINT "CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
     PRINT
     PRINT
     PRINT
     PRINT "THIS PROGRAM IS A 'BATTLE OF NUMBERS' GAME, WHERE THE"
     PRINT "COMPUTER IS YOUR OPPONENT."
     PRINT 
     PRINT "THE GAME STARTS WITH AN ASSUMED PILE OF OBJECTS. YOU"
     PRINT "AND YOUR OPPONENT ALTERNATELY REMOVE OBJECTS FROM THE PILE."
     PRINT "WINNING IS DEFINED IN ADVANCE AS TAKING THE LAST OBJECT OR"
     PRINT "NOT. YOU CAN ALSO SPECIFY SOME OTHER BEGINNING CONDITIONS."
     PRINT "DON'T USE ZERO, HOWEVER, IN PLAYING THE GAME."
     PRINT "ENTER A NEGATIVE NUMBER FOR NEW PILE SIZE TO STOP PLAYING."
     PRINT
     GOTO 330
 220 FOR I=1 TO 10
     PRINT
     NEXT
 330 INPUT "ENTER PILE SIZE: ",N
     IF N<1 THEN END
 390 INPUT "ENTER WIN OPTION - 1 TO TAKE LAST, 2 TO AVOID LAST: ",M
     IF M=1 THEN GOTO 430
     IF M=2 THEN GOTO 430
     GOTO 390
 430 INPUT "ENTER MIN: ", A
     INPUT "ENTER MAX: ",B
     IF A>B THEN GOTO 430
     IF A<1 THEN GOTO 430
 490 INPUT "ENTER START OPTION - 1 COMPUTER FIRST, 2 YOU FIRST: ",S
     PRINT
     PRINT
     IF S=1 THEN GOTO 530
     IF S=2 THEN GOTO 530
     GOTO 490
 530 C=A+B
     IF S=2 THEN GOTO 570
 550 GOSUB 600
     IF W=1 THEN GOTO 220
 570 GOSUB 810
     IF W=1 THEN GOTO 220
     GOTO 550
 600 Q=N
     IF M=1 THEN GOTO 630
     Q=Q-1
 630 IF M=1 THEN GOTO 680
     IF N>A THEN GOTO 720
     W=1
     PRINT "COMPUTER TAKES ";N;" AND LOSES."
     RETURN
 680 IF N>B THEN GOTO 720
     W=1
     PRINT "COMPUTER TAKES ";N;" AND WINS."
     RETURN
 720 P=Q-C*(Q/C)
     IF P>A THEN GOTO 750
     IF P=A THEN GOTO 750
     P=A
 750 IF P=B THEN GOTO 770
     IF P<B THEN GOTO 770
     P=B
 770 N=N-P
     PRINT "COMPUTER TAKES ";P;" AND LEAVES ";N
     W=0
     RETURN
 810 PRINT
 820 INPUT "YOUR MOVE: ", P
     IF P=0 THEN GOTO 840
     GOTO 870
 840 PRINT "I TOLD YOU NOT TO USE ZERO! COMPUTER WINS BY FORFEIT."
     W=1
     RETURN
 870 IF P>A THEN GOTO 910
     IF P=A THEN GOTO 910
     IF P=N THEN GOTO 960
     GOTO 920
 910 IF P<B THEN GOTO 940
     IF P=B THEN GOTO 940
 920 PRINT "ILLEGAL MOVE, REENTER IT: ";
     GOTO 820
 940 N=N-P
     IF N=0 THEN GOTO 960
     GOTO 1030
 960 IF M=1 THEN GOTO 1000
     PRINT "TOUGH LUCK, YOU LOSE."
     W=1
     RETURN
1000 PRINT "CONGRATULATIONS, YOU WIN."
     W=1
     RETURN
1030 IF N>0 THEN GOTO 1060
     IF N=0 THEN GOTO 1060
     N=N+P
     GOTO 920
1060 W=0
     RETURN
     END
