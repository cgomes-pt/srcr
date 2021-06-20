:- op( 900,xfy,'::').
:- dynamic jogo/3.


-jogo(Jogo,Arbitro,Ajudas) :-
    nao(jogo(Jogo,Arbitro,Ajudas)),
    nao(excecao(jogo(Jogo,Arbitro,Ajudas))).

jogo(1,aa,500).

jogo(2,bb,xpto0123).
excecao(jogo(Jogo,Arbitro,_ )) :- jogo(Jogo,Arbitro,xpto0123).

excecao(jogo(3,cc,500)).
excecao(jogo(3,cc,2500)).

excecao(jogo(4,dd,Ajudas)):- Ajudas >= 250,
                            Ajudas =< 750.

jogo(5,ee,xpto765).


excecao(jogo(Jogo,Arbitro,_)):- jogo(Jogo, Arbitro, xpto765).
nulo(xpto765).
+jogo(J,A,C) :: (solucoes(Ajudas,(jogo(5,ee,Ajudas),nao(nulo(Ajudas))), S),N == 0).

jogo(6,ff,250).
excecao(jogo(6,ff,Ajudas)) :- Ajudas>5000.

-jogo(7,gg,2500).
jogo(7,gg,xpto768).
excecao(jogo(Jogo,Arbitro,_)):- jogo(Jogo, Arbitro, xpto768).

cerca(Valor, Superior, Inferior):- Superior is Valor * 1.25,
                                   Inferior is Valor * 0.75.

excecao(jogo(8,hh,Valor)) :- cerca(1000, Superior, Inferior),
                             Valor >= Inferior,
                             Valor =< Superior.

proxima(Valor, Superior, Inferior) :- Superior is Valor * 1.10,
                                      Inferior is Valor * 0.90.

excecao(jogo(9,ii,Valor)) :- proxima(3000, Superior, Inferior),
                             Valor >= Inferior,
                             Valor =< Superior.


% --- Evolucao & Involucao ---
evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).


involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

% --- Auxiliares ---
insercao(Termo) :-
    assert(Termo).
insercao(Termo) :-
    retract(Termo),!,fail.

teste([]).
teste([R|LR]) :-
    R,
    teste(LR).

nao(Questao) :-
    Questao, !, fail.
nao(_).

remocao(Termo) :-
    retract(Termo).
remocao(Termo) :-
    assert(Termo),!,fail.

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).

demo(Questao,verdadeiro) :-
    Questao.
demo(Questao,falso) :-
    -Questao.
demo(Questao,desconhecido) :-
    nao(Questao),
    nao(-Questao).


