pertence(X,[X|T]).
pertence(X,[H|T]) :- not(X=H), pertence(X,T).


comprimento([],0).
comprimento([H|T],N) :- comprimento(T,N1), N is N1+1.


diferentes([],0).
diferentes([X|T],N) :- pertence(X,T), diferentes(T,N).
diferentes([X|T],N) :- diferentes(T,N1), N is N1 + 1.


apagaT(X,[],[]).
apagaT(X,[X|T],R) :- apagaT(X,T,R).
apagaT(X,[H|T],[H|L]) :- apagaT(X,T,L).



apaga1(X,[X|T],T).
apaga1(X,[H|T],[H|L]) :- X\=H, apaga1(X,T,L).



delMember(_, [], []).
delMember(X, [X|Xs], Y) :- delMember(X, Xs, Y).
delMember(X, [T|Xs], Y) :-  delMember(X, Xs, Y).


adicionar(X,L,R) :- pertence(X,L).
adicionar(X,L,[X|L]) :- not(pertence(X,L)).


concatenar([],L2,L2).
concatenar([X|R],L2,[X|L]) :- concatenar(R,L2,L).


reverse([],L,L).
reverse([H|T],L,X) :- reverse(T,L,[H|X]).
