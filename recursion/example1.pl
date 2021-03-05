comeu(mosquito,sangue(joao)).
comeu(sapo,mosquito).
comeu(cobra,sapo).


digere(X,Y):- comeu(X,Y).
digere(X,Y):- comeu(X,Z), digere(Z,Y).

