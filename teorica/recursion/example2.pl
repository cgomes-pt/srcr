filho(ana,bruna).
filho(bruna,carolina).
filho(carolina,diana).
filho(diana,emilia).

descendente(X,Y):- filho(X,Y).
descendente(X,Y):- filho(X,Z), filho(Z,Y).
