reverser([],A,A) .
reverser([Head | Tail],Z,X) :-
    reverser(Tail,[Head | Z],X).
rev(A,B) :- reverser(A,[],B).