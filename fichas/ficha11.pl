estimativa(a,5).
estimativa(b,4).
estimativa(c,4).
estimativa(d,3).
estimativa(e,7).
estimativa(f,4).
estimativa(g,2).
estimativa(s,10).
estimativa(t,0).

move(s,a,2).
move(a,b,2).
move(b,c,2).
move(c,d,3).
move(d,t,3).

move(s,e,2).
move(e,f,5).
move(f,g,2).
move(g,t,2).
 

move(Nodo, NodoProx):-
    move(Nodo,NodoProx,_).

inicio(s).
fim(t).

 
 adjacente(Nodo, NodoProx):-
    move(Nodo, NodoProx, _).

adjacente(Nodo, NodoProx):-
    move(NodoProx, Nodo, _).

resolvePP(Nodo, [Nodo|Caminho]):-
    primeiroprofundidade(Nodo,[Nodo],Caminho).

primeiroprofundidade(Nodo,_, []):-
    fim(Nodo).

primeiroprofundidade(Nodo, Historico, [NodoProx|Caminho]):-
    adjacente(Nodo, NodoProx),
    nao(membro(NodoProx, Historico)),
    primeiroprofundidade(NodoProx, [NodoProx|Historico], Caminho).

todasSolucoes(L):- findall((S,C), (resolvePP(s,S), length(S,C)),L).
 
resolvePPMulti(NodoIni, NodoFim, [Nodo|Caminho]):-
    profundidade(NodoIni, NodoFim, [NodoIni], Caminho).

profundidade(Destino, Destino, H, D):- inverso(H,D).

profundidade(Origem, Destino, His, C):-
    adjacente(Origem, Prox),
    nao(membro(Prox, His)),
    profundidade(Prox,Destino,[Prox|His],C).

resolvePPCusto(Nodo,[Nodo|Caminho],Custo):-
    primeiroprofundidadeCusto(Nodo,[Nodo],Caminho,Custo).

primeiroprofundidadeCusto(Nodo, _, [], 0):-
    fim(Nodo).

primeiroprofundidadeCusto(Nodo,Historico,[NodoProx|Caminho],Custo):-
    adjacenteCusto(Nodo,NodoProx,CustoMovimento),
    nao(membro(NodoProx, Historico)),
    primeiroprofundidadeCusto(NodoProx,[NodoProx|Historico],Caminho,Custo2),
    Custo is CustoMovimento + Custo2.


adjacenteCusto(Nodo, NodoProx, Custo):-
    move(Nodo,NodoProx,Custo).

adjacenteCusto(Nodo, NodoProx, Custo):-
    move(NodoProx,Nodo,Custo).

ppCustoTodasSolucoes(L):- findall((S,C),(resolvePPCusto(s,S,C)),L).

melhor(Nodo,Cam,Custo):- findall((Ca,Cus), resolvePPCusto(Nodo,Ca,Cus), L),minimo(L,(Cam,Custo)).


resolveGulosa(Nodo, Caminho/Custo) :-
    estimativa(Nodo, Estimativa),
    agulosa([[Nodo]/0/Estimativa], CaminhoInverso/Custo/_),
    inverso(CaminhoInverso, Caminho).

agulosa(Caminhos, Caminho) :-
    obtem_melhor_g(Caminhos, Caminho),
    Caminho = [Nodo|_]/_/_,fim(Nodo).

agulosa(Caminhos, SolucaoCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeGulosa(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    agulosa(NovoCaminhos, SolucaoCaminho).

obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_g(Caminhos, MelhorCaminho).

expandeGulosa(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos).

adjacenteG([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	move(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estimativa(ProxNodo, Est).

resolveAEstrela(Nodo, Caminho/Custo) :-
    estimativa(Nodo, Estimativa),
    aestrela([[Nodo]/0/Estima], CaminhoInverso/Custo/_),
    inverso(CaminhoInverso, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,fim(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
    obtem_melhor(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expandeAEstrela(MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela(NovoCaminhos, SolucaoCaminho).

obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).
    
expandeAEstrela(Caminho, ExpCaminhos) :-
findall(NovoCaminho, adjacenteG(Caminho,NovoCaminho), ExpCaminhos). %adjacenteG/2 da Alínea anterior


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

minimo([(P,X)],(P,X)).
minimo([(P,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y.
minimo([(Px,X)|L],(Px,X)):- minimo(L,(Py,Y)), X=<Y.

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).