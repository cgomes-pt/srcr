elfo(diogo).
bruxa(herminia).
bruxa('Maria').
bruxa(rita).

magico(X):-elfo(X).
magico(X):-feiticeiro(X).
magico(X):-bruxa(X).
