:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.


voa(X) :-
    ave(X), 
    nao(excecao(voa(X))).

-voa(tweety).

-voa(X) :- mamifero(X),nao(excecao(-voa(X))).

-voa(X) :- excecao(voa(X)).

voa(X) :- excecao(-voa(X)).

ave(tweety).

ave(X) :- canario(X).
ave(X) :- avestruz(X).
ave(X) :- pinguin(X).

canario(piupiu).
avestruz(trux).
pinguin(pingu).


mamifero(silvestre).

mamifero(X) :- cao(X).
mamifero(X) :- gato(X).
mamifero(X) :- morcego(X).

morcego(bate).
cao(boby).

si(Questao, verdadeiro) :- Questao.
si(Questao, falso) :- -Questao.
si(Questao, desconhecido) :- nao(Questao),
							 nao(-Questao).

siL([],[]).
siL([Questao|L],[Resposta|S]) :-
    si(Questao,Resposta),
    siL(L,S).

	

nao( Questao ) :-
    Questao, !, fail.
nao( _ ).
