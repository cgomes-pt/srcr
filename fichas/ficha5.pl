:-set_prolog_flag(discontiguous_warnings,off).
:-set_prolog_flag(single_var_warnings,off).
:- op(900,xfy,'::').
:- dynamic filho/2.
:- dynamic pai/2.

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

% --- Invariantes ---

+filho(F,P) :: 
    (solucoes((F,P),(filho(F,P)),S),comprimento(S,N), N == 1).

+filho(F,_) :: 
    (solucoes(Ps, (filho(F,Ps), S)),comprimento(S,N), N=<2).

-filho(F,P) :: 
    (solucoes(F,(idade(F,I)),S),comprimento(S,N),N==0).


% --- Evolucao ---

evolucao(Termo) :- 
    solucoes(Invariante, +Termo::Invariante, Lista),insercao(Termo),teste(Lista).

% --- Involucao ---

involucao(Termo) :- 
    solucoes(Invariante, +Termo::Invariante, Lista),remocao(Termo),teste(Lista).

% --- Auxiliares ---
teste([]).
teste([R|Lr]) :- R, teste(Lr).

solucoes(X,P,S) :- findall(X,P,S).

comprimento(S,N) :- length(S,N).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo), !, fail.

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo), !, fail.