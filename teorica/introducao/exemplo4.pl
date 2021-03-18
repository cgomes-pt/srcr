feliz(bruno).
ouveMusica(miguel).
tocaGuitarra(bruno):-ouveMusica(bruno),feliz(bruno).
tocaGuitarra(miguel):-feliz(miguel).
tocaGuitarra(miguel):-ouveMusica(miguel).

