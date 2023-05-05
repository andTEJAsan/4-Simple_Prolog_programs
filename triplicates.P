multiplicity(X,Y,0) :- not(member(X, Y)).
multiplicity(X,[X|Ys],N) :-
    multiplicity(X,Ys,A),
    N is A+1.
multiplicity(X,[Y|Ys],N) :-
    Y \= X,
    multiplicity(X,Ys,N).

has_no_triplicates([]).
has_no_triplicates([X|Xs]) :- multiplicity(X,[X|Xs],A), A<3, has_no_triplicates(Xs).