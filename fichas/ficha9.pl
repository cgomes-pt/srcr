 g( grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, corboda, a4, 400),
   aresta(braga, guimaraes,a11, 25),
   aresta(braga, vilareal, a11, 107),
   aresta(guimaraes, viseu, a24, 174),
   aresta(vilareal, lamego, a24, 37),
   aresta(viseu, lamego,a24, 61),
   aresta(viseu, coimbra, a25, 119),
   aresta(viseu,guarda, a25, 75)]
 )).


adjacente(X,Y,E,K, grafo(_,Es)) :- member(aresta(X,Y,E,K),Es).
adjacente(X,Y,E,K, grafo(_,Es)) :- member(aresta(Y,X,E,K),Es).


caminho(G,A,B,P) :- caminho1(G,A,[B],P).

caminho1(_,A,[A|P1],[A|P1]).
caminho1(G,A,[Y|P1],P) :- adjacente(X,Y,_,_,G),
						  nao(membro(X,[Y|P1])),
						  caminho1(G,A,[X,Y|P1],P).
	

ciclo(G,A,P) :- adjacente(B,A,_,_,G),
				    caminho(G,A,B,P1),
					length(P1, L),
					Len > 2,
                    append(P1,[A],P).

%caminhoK(G,A,B,P, K, E) :- caminhoK1(G,B,[A],P,K,E).
%caminhoK1(_,A,[A|P1],[A|P1],0,[]).
%caminhoK1(G,A,[Y|P1],P, K1, [E|Es]) :- adjacente(X,Y,E,Ki,G),
%								   	nao(membro(X,[Y|P1])),
%								   	caminhoK1(G,A,[X,Y|P1],P, K, Es),
%								   	K1 is K + Ki.


%cicloK(G,A,[A|P1], Km, [E|E1]) :- adjacente(B,A,E,K,G),
%				    		  caminhoK(G,B,A,P1, K1, E1),
%							  length(P1, Len),
%						 	  Len >= 3,
%						 	  Km is K1 + K.


nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).