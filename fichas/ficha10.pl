inicial(jarros(0, 0)).

final(jarros(4, _)).
final(jarros(_, 4)).

transicao(jarros(V1, V2), encher(1), jarros(8, V2)):- V1 < 8.
transicao(jarros(V1, V2), encher(2), jarros(V1, 5)):- V2 < 5.

transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
    V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.

transicao(jarros(V1, V2), encher(2, 1), jarros(NV1, NV2)):- 
	V2 > 0,
	NV2 is max(V1 + V2 - 8, 0), 
	NV2 < V2, 
	NV1 is V1 + V2 - NV2.

transicao(jarros(V1, V2), esvaziar(1), jarros(0, V2)) :-
	V1 > 0.

transicao(jarros(V1, V2), esvaziar(2), jarros(V1, 0)) :-
	V2 > 0.

% --- Depth First --- 

resolveDF(Solucao) :- 
	inicial(InicialEstado),
	resolveDF(InicialEstado, [InicialEstado], Solucao).

resolveDF(Estado, _, []) :-
	final(Estado), !.

resolveDF(Estado, Historico, [Move|Solucao]) :-
	transicao(Estado, Move, Estado1),
	nao(membro(Estado1, Historico)),
	resolveDF(Estado1, [Estado1|Historico], Solucao).


% --- Breadth First ---

resolveBF(Solucao) :-
	inicial(InicialEstado),
	resolveBF([(InicialEstado, []) | Xs] - Xs, [], Solucao).

resolveBF(([Estado, Vs)|_]-_,_,Rs) :-
	final(Estado), !, inverso(Vs, Rs).

resolveBF([Estado, _) | Xs]-Ys, Historico, Solucao) :-
	membro(Estado, Historico), !,
	resolveBF(Xs-Ys, Historico, Solucao).

resolveBF([(Estado, Vs) | Xs]-Ys, Historico, Solucao) :-
	setof((Move, Estado1), transicao(Estado, Move, Estado1), Ls),
	atualizar(Ls, Vs, [Estado|Historico], Ys-Zs),
	resolveBF(Xs-Zs, [Estado|Historico], Solucao).

atualizar([], _, _, X-X).
atualizar([(_,Estado)|Ls], Vs, Historico, Xs-Ys) :-
	membro(Estado, Historico), !,
	atualizar(Ls, Vs, Historico, Xs-Ys).

atualizar([(Move, Estado)|Ls], Vs, Historico, [(Estado,[Move|Vs])|Xs]-Ys):-
	atualizar(Ls, Vs, Historico, Xs-Ys).


nao( Questao ) :-
    Questao, !, fail.
nao( _ ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

escrever([]).
escrever([H|T]) :-
	write(H), write("\n"), 
	escrever(T).

todos(L) :- findall((S,C), (resolveDF(S), length(S, C)), L).

melhor(S, Custo) :- todos(L), 
	menor(L, (S, Custo)).

menor([(P,X)],(P,X)).
menor([(Px,X)|L],(Py,Y)) :- menor(L,(Py,Y)), X>Y.
menor([(Px,X)|L],(Px,X)) :- menor(L,(Py,Y)), X=<Y.