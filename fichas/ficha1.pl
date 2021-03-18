
filho(joao,jose).
filho(jose,manuel).
filho(carlos, jose).

pai(paulo,maria).
pai(paulo, filipe).

avo(antonio,nadia).

neto(nuno,ana).

masc(joao).
masc(jose).

fem(maria).
fem(joana).


pai(P,F) :- filho(F,P).

avo(N,A) :- filho(A,X),pai(N,X).

neto(N,A) :- avo(A,N).


%descendente(X,Y) :- filho(X,Y).

descendente(X,Y,1) :- filho(X,Y).
descendente(X,Y,N) :- filho(X,Z), descendente(Z,Y,G).

avoGrau(A,N) :- descendente(N,A,2).



bisavo(X,Y) :- filho(Y,Z),filho(Z,A),filho(A,X).

bisavo2(X,Y) :- avo(X,Z),pai(Z,Y).

trisavo(X,Y) :- bisavo(X,Z),pai(Z,Y).

