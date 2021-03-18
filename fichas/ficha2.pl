soma2(X,Y,Soma) :- Soma is X+Y.

soma3(X,Y,Z,Soma) :- Soma is X+Y+Z.


somaC([],0).
somaC([H|T],Soma) :- somaC(T,S), Soma is H+S.

op(X,Y,+,Z) :- Z is X+Y.
op(X,Y,-,Z) :- Z is X-Y.
op(X,Y,*,Z) :- Z is X*Y.
op(X,Y,/,Z) :- Z is X/Y.


 opC([],+,0).
 opC([H|T],+,Z) :- opC(T,+,R), Z is H+R.
 opC([H|T],-,Z) :- opC(T,-,R), Z is H-R.
 opC([H|T],*,Z) :- opC(T,*,R), Z is H*R.
 opC([H|T],/,Z) :- opC(T,/,R), Z is H/R.


maior(X,Y,X) :- X>Y.
maior(X,Y,Y) :- Y>X.


maiorC([],0).
maiorC([X],X).
maiorC([X|T],R) :- maiorC(T,R2),maior(X,R2,R).


mdc(X,Y,R) :- X>Y, X1 is Y, mdc(X1,Y,R).
mdc(X,Y,R) :- Y,X, Y1 is Y-X, mdc(X,Y1,R).
mdc(X,X,X).
