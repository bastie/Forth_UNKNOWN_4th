( *     K E I R S E Y   T E M P E R A M E N T   S O R T E R

In the 1950's Isabel Myers and her mother Kathryn Briggs developed a tool for
personality analysis, the Myers-Briggs Type Indicator, based on Carl Jung's
1924 "Psychological Types."  This became so widely used that it created an
international interest in Jung's theory.  David Keirsey and Marilyn Bates,
"Please Understand Me," is an excellent exposition, with a version of the test,
the Keirsey Temperament Sorter.

This file contains a program to administer Keirsey's test.

* )

[needs lib/pickroll.4th]
[needs lib/random.4th]
[needs lib/row.4th]

70 CONSTANT #Questions

#Questions array Quiz
4          array Temperament

80 string Question-A
80 string Question-B
80 string buffer

VARIABLE Toss
VARIABLE Question-Number

: Get-Random random * max-rand 1+ / ;

table Questions
," At a party do you:"
 ," interact with many, including strangers"
 ," interact with a few, known to you"
," Are you more:"
 ," realistic than speculative"
 ," speculative than realistic"
," Is it worse to:"
 ," have your 'head in a the clouds'"
 ," be 'in a rut'"
," Are you more impressed by:"
 ," principles"
 ," emotions"
," Are you more drawn to:"
 ," convincing"
 ," touching"
," Do you prefer to work:"
 ," to deadlines"
 ," just 'whenever'"
," Do you tend to choose:"
 ," rather carefully"
 ," somewhat impulsively"
," At parties do you:"
 ," stay late, with increasing energy"
 ," leave early, with decreased energy"
," Are you more attracted to:"
 ," sensible people"
 ," imaginative people"
," Are you more interested in:"
 ," what is actual"
 ," what is possible"
," In judging others are you more swayed by:"
 ," laws than circumstances"
 ," circumstances than laws"
," In approaching others is your inclination to be somewhat:"
 ," objective"
 ," personal"
," Are you more:"
 ," punctual"
 ," leisurely"
," Does it bother you more having things:"
 ," incomplete"
 ," completed"
," In your social groups do you:"
 ," keep abreast of other's happenings"
 ," get behind on the news"
," In doing ordinary things are you more likely to:"
 ," do it the usual way"
 ," do it your own way"
," Writers should:"
 ," 'say what they mean and mean what they say'"
 ," express things more by the use of analogy"
," Which appeals to you more?"
 ," consistency of thought"
 ," harmonious human relationships"
," Are you more comfortable with:"
 ," logical judgments"
 ," value judgements"
," Do you want things:"
 ," settled and decided"
 ," unsettled and undecided"
," Would you say you are more:"
 ," serious and determined"
 ," easy-going"
," In phoning do you:"
 ," rarely question that it will all be said"
 ," rehearse what you'll say"
," Facts:"
 ," speak for themselves"
 ," illustrate principles"
," Are visionaries:"
 ," somewhat annoying"
 ," rather fascinating"
," Are you more often:"
 ," a cool-headed person"
 ," a warm-hearted person"
," Is it worse to be:"
 ," unjust"
 ," merciless"
," Should one usually let events occur:"
 ," by careful selection and choice"
 ," randomly and by chance"
," Do you feel better about:"
 ," having purchased"
 ," having the option to buy"
," In company do you:"
 ," initiate conversation"
 ," wait to be approached"
," Common sense is:"
 ," rarely questionable"
 ," frequently questionable"
," Children often do not:"
 ," make themselves useful enough"
 ," exercise their fantasy enough"
," In making decisions do you feel more comfortable with:"
 ," standards"
 ," feelings"
," Are you more:"
 ," firm than gentle"
 ," gentle than firm"
," Which is more admirable?"
 ," the ability to organize and be methodical"
 ," the ability to adapt and make do"
," Do you put more value on the:"
 ," definite"
 ," open-ended"
," Does new and non-routine interaction with others:"
 ," stimulate and energize you"
 ," tax your reserves"
," Are you more frequently:"
 ," a practical sort of person"
 ," a fanciful sort of person"
," Are you more likely to:"
 ," see how others are useful"
 ," see how others see"
," Which is more satisfying?"
 ," to discuss an issue thoroughly"
 ," to arrive at agreement on an issue"
," Which rules you more?"
 ," your head"
 ," your heart"
," Are you more comfortable with work that is:"
 ," contracted"
 ," done on a casual basis"
," Do you tend to look for:"
 ," the orderly"
 ," whatever turns up"
," Do you prefer:"
 ," many friends with brief contact"
 ," a few friends with more lengthy contact"
," Do you go more by:"
 ," facts"
 ," principles"
," Are you more interested in:"
 ," production and distribution"
 ," design and research"
," Which is more of a compliment?"
 ," 'There is a very logical person.'"
 ," 'There is a very sentimental person.'"
," Do you value in yourself that you are more:"
 ," unwavering"
 ," devoted"
," Do you more often prefer the:"
 ," final and unalterable statement"
 ," tentative and preliminary statement"
," Are you more comfortable:"
 ," after a decision"
 ," before a decision"
," Do you:"
 ," speak easily and at length with strangers"
 ," find little to say to strangers"
," Are you more likely to trust your:"
 ," experience"
 ," hunch"
," Do you feel:"
 ," more practical than ingenious"
 ," more ingenious than practical"
," Which person is to be more complimented: one of"
 ," clear reason"
 ," strong feeling"
," Are you more inclined to be:"
 ," fair-minded"
 ," sympathetic"
," Is it preferable mostly to:"
 ," make sure things are arranged"
 ," just let things happen"
," In relationships should most things be:"
 ," renegotiable"
 ," random and circumstantial"
," When the phone rings do you:"
 ," hasten to get to it first"
 ," hope someone else will answer"
," Do you prize more in yourself:"
 ," a strong sense of reality"
 ," a vivid imagination"
," Are you drawn more to:"
 ," fundamentals"
 ," overtones"
," Which seems the greater error?"
 ," to be too passionate"
 ," to be too objective"
," Do you see yourself basically:"
 ," hard-hearted"
 ," soft-hearted"
," Which situation appeals to you more?"
 ," the structured and scheduled"
 ," the unstructured and unscheduled"
," Are you a person that is more:"
 ," routinized than whimsical"
 ," whimsical than routinized"
," Are you more inclined to be:"
 ," easy to approach"
 ," somewhat reserved"
," In writings do you prefer:"
 ," the more literal"
 ," the more figurative"
," Is it harder for you to:"
 ," identify with others"
 ," utilize others"
," Which do you wish more for yourself?"
 ," clarity of reason"
 ," strength of compassion"
," Which is the greater fault?"
 ," being indiscriminate"
 ," being critical"
," Do you prefer the:"
 ," planned event"
 ," unplanned event"
," Do you tend to be more:"
 ," deliberate than spontaneous"
 ," spontaneous than deliberate"

: ENFJ  ." The archetype of ENFJ  5%  is Pedagogue."
    CR  ." God help me to do only what I can and trust you for "
    CR  ." the rest.  Do you mind putting that in writing? "  SPACE
;

: INFJ  ." The archetype of INFJ  1%  is Author."
    CR  ." Lord, help me not be a perfectionist.  Did I spell that "
    CR  ." correctly? "  SPACE
;

: ENFP  ." The archetype of ENFP  5%  is Journalist."
    CR  ." God, help me to keep my mind on one th-Look a bird!-ing "
    CR  ." at a time. "  SPACE
;

: INFP  ." The archetype of INFP  1%  is Questor."
    CR  ." God, help me to finish everything I sta" CR
;

: ENTJ  ." The archetype of ENTJ  5%  is Fieldmarshal."
    CR  ." Lord, help me slow downandnotrushthroughwhatIdo"
;

: INTJ  ." The archetype of INTJ  1%  is Scientist."
    CR  ." Lord keep me open to others' ideas, WRONG though they "
    CR  ." may be. "  SPACE
;

: ENTP  ." The archetype of ENTP  5%  is Inventor."
    CR  ." Lord help me follow established procedures today.  On "
    CR  ." second thought, I'll settle for a few minutes. "  SPACE
;

: INTP  ." The archetype of INTP  1%  is Architect."
    CR  ." Lord help me be less independent, but let me do it "
    CR  ." my way. "  SPACE
;

: ESTJ  ." The archetype of ESTJ  13% is Administrator."
    CR  ." God, help me to not try to RUN everything. But, if You "
    CR  ." need some help, just ask. "  SPACE
;

: ISTJ  ." The archetype of ISTJ  6%  is Trustee."
    CR  ." Lord help me to relax about insignificant details "
    CR  ." beginning tomorrow at 11:41.23 AM E.S.T. "  SPACE
;

: ESFJ  ." The archetype of ESFJ  13% is Seller."
    CR  ." God give me patience, and I mean right NOW! "  SPACE
;

: ISFJ  ." The archetype of ISFJ  6%  is Conservative."
    CR  ." Lord, help me to be more laid back and help me to "
    CR  ." do it EXACTLY right. "  SPACE
;

: ESTP  ." The archetype of ESTP  13% is Promoter."
    CR  ." God help me to take responsibility for my own actions, "
    CR  ." even though they're usually NOT my fault. "  SPACE
;

: ESFP  ." The archetype of ESFP  13% is Entertainer."
    CR  ." God help me to take things more seriously, especially "
    CR  ." parties and dancing. "  SPACE
;

: ISTP  ." The archetype of ISTP  6%  is Artisan."
    CR  ." God help me to consider people's feelings, even if most "
    CR  ." of them ARE hypersensitive. "  SPACE
;

: ISFP  ." The archetype of ISFP  6%  is Artist."
    CR  ." Lord, help me to stand up for my rights -- if you don't "
    CR  ." mind my asking. "  SPACE
;

create dictionary                      \ dummy dictionary
  ," ENFJ" ' ENFJ ,
  ," INFJ" ' INFJ ,
  ," ENFP" ' ENFP ,
  ," INFP" ' INFP ,
  ," ENTJ" ' ENTJ ,
  ," INTJ" ' INTJ ,
  ," ENTP" ' ENTP ,
  ," INTP" ' INTP ,
  ," ESTJ" ' ESTJ ,
  ," ISTJ" ' ISTJ ,
  ," ESTP" ' ESTP ,
  ," ISTP" ' ISTP ,
  ," ESFJ" ' ESFJ ,
  ," ISFJ" ' ISFJ ,
  ," ESFP" ' ESFP ,
  ," ISFP" ' ISFP ,
  NULL ,

: exchange  DUP @ >R    OVER @ SWAP !   R> SWAP ! ;

: Shuffle-Quiz
        #questions 0 DO
                I 1+ quiz i th !
        LOOP
        #questions 0 DO
                quiz #questions Get-Random th
                        quiz I th
                exchange
        LOOP
;

: Print-Question                     ( question-addr -- )
        dup @c cr count type cr
        cell+ dup Question-A >r @c count r@ place r> swap
        cell+     Question-B >r @c count r@ place r> swap
        2 Get-Random DUP toss ! IF SWAP THEN
        ."   a. " COUNT TYPE CR
        ."   b. " COUNT TYPE CR
;

: Ask-Question                         ( -- )
        Question-Number @              ( n)
        Quiz swap 1- th @
        Questions swap 1- 3 * th
        Print-Question                 ( -- )
;

: Reset-Tallies
        4 0 DO    0 Temperament i th !    LOOP
;

: Temperament-Num ( i -- t ) 1- 7 MOD 1+ 2/ ;

: Score-Question                         ( 1|-1 -- )
        Toss @ IF NEGATE THEN
        Question-Number @                ( n)
        1- Quiz swap th @
        Temperament-Num Temperament swap th +!  ( -- )
;

: E-or-I                        ( -- char )
        Temperament 0 th @ ?DUP 0= IF
                [CHAR] X
        ELSE    0> IF
                ." Extraverted "
                [CHAR] E
        ELSE
                ." Introverted "
                [CHAR] I
        THEN THEN
;

: S-or-N                        ( -- char )
        Temperament 1 th @ ?DUP 0= IF
                [CHAR] X
        ELSE    0> IF
                ." Sensative "
                [CHAR] S
        ELSE
                ." iNtuitive "
                [CHAR] N
        THEN THEN
;

: T-or-F                        ( -- char )
        Temperament 2 th @ ?DUP 0= IF
                [CHAR] X
        ELSE    0> IF
                ." Thinking "
                [CHAR] T
        ELSE
                ." Feeling "
                [CHAR] F
        THEN THEN
;

: J-or-P                        ( -- char )
        Temperament 3 th @ ?DUP 0= IF
                [CHAR] X
        ELSE    0> IF
                ." Judging "
                [CHAR] J
        ELSE
                ." Perceiving "
                [CHAR] P
        THEN THEN
;

: Analyze-Answers
\       4 0 DO   Temperament I th ?   LOOP   CR
        buffer 4 over                 ( a n a)
        E-or-I over C! 1+             ( a n a+1)
        S-or-N over C! 1+             ( a n a+2)
        T-or-F over C! 1+             ( a n a+3)
        J-or-P swap C!                ( a n)

        CR  over over TYPE  CR        ( a n)
        CR  dictionary 2 string-key row
        if nip nip cell+ @c execute else drop drop drop then
        CR ." Amen" CR
;

: Drop-Question        ( t n -- )
  SWAP OVER  0 DO                   ( n t)
               Quiz I th @ Temperament-Num OVER = IF DROP ( n)
                    Quiz swap 1- th Quiz I th exchange  ( --)
                    LEAVE
               THEN                         ( n t)
            LOOP                            ( --)
;

: Drop-4Questions              ( -- )
  4 0 DO  I #Questions OVER -  ( t n)
          Drop-Question        ( --)
  LOOP
;

: Next-Question                         ( 1|-1 -- f)
        Score-Question                  ( -- )
        Question-Number @ #Questions 4 - < IF
                1 Question-Number +!
                Ask-Question
                false
        ELSE
                Analyze-Answers
                CR
                true
        THEN
;

: Test                              ( -- )
    Reset-Tallies  Shuffle-Quiz  Drop-4Questions
    1 Question-Number !  Ask-Question
;

: a     1 Next-Question ;
: b    -1 Next-Question ;
: x     0 Next-Question ;

: keirsey
  randomize
  Test max-n
  begin
    drop
    refill drop
    bl parse-word drop c@
    dup [char] x = if x else
    dup [char] a = if a else
    dup [char] b = if b else
    false then then then
  until
;

keirsey

