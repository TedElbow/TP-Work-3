:- dynamic conceito/2, individuo/1, relacao/1, triplo/4, triplo/3.

ontologia(X):- format('digraph ~w {',[X]), nl.

conceito(name(X), atribs([(name,Y)])):-
	assert(-conceito(name(X), atribs([(name,Y)]))),
	format('"~w" [shape=ellipse, style=filled, color=turquoise4];',[X]),
	nl,
	format('"~w" [shape=rectangle, color=turquoise4];', [name]),
	nl,
	format('"~w"->"~w" [label="properties", style=dotted, color=red];', [X, name]),
	nl.

individuo(X):- 
	assert(-individuo(X)),
	format('"~w" [shape=rectangle, style=filled, color=goldenrod];', [X]),
	nl.

relacao(X):-
	assert(-relacao(X)).

triplo(X,iof,Y,atribs([(name,Z)])):-
	-individuo(X),
	-conceito(name(Y), _),
	assert(-triplo(X,iof,Y,atribs([(name,Z)]))),
	format('"~w"->"~w" [label="~w", style=dashed];',[X,Y,iof]),
	nl,
	format('"~w="~w"" [shape=rectangle, color=goldenrod];',[name,Z]),
	nl,
	format('"~w"->"~w="~w"" [label="properties", style=dotted, color=red];',[X,name,Z]),
	nl.

triplo(X,Y,Z):-
	-individuo(X),
	-relacao(Y),
	-individuo(Z),
	assert(-triplo(X,Y,Z)),
	format('"~w"->"~w" [label="~w"];',[X,Z,Y]), nl.

making_digraph:-

	ontologia(map),
	conceito(name(city), atribs([(name,string)])),
	conceito(name(traveler),atribs([(name,string)])),
	nl,
	individuo(pl),
	individuo(ine),
	individuo(pt),
	individuo(lx),
	nl,
	relacao(alreadyVisited),
	relacao(lives),
	triplo(pl,iof,traveler,atribs([(name,"Paulo")])),
	triplo(ine,iof,traveler,atribs([(name,"Ines")])),
	triplo(pt,iof,city,atribs([(name,"Porto")])),
	triplo(lx,iof,city,atribs([(name,"Lisboa")])),
	triplo(pl,alreadyVisited,pt),
	triplo(ine,alreadyVisited,lx),
	triplo(pl,lives,lx),
	triplo(ine,lives,pt),
	write('}').
