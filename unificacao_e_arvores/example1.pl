vertical(line(point(X,Y),point(X,Z))).

horizontal(line(point(X,Y),point(Z,Y))).

/*
vertical(line(point(1,1),point(1,3))) = true 
vertical(line(point(1,1),point(2,3))) = false 
vertical(line(point(1,1),point(1,dsadsadsa))) = true 
vertical(line(point(1,1),point(dsadsa,dadasda))) = false 
*/

