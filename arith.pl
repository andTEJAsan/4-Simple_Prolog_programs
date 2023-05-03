list_size([], 0).
list_size([_ | Tail], Size) :-
    list_size(Tail, PrevSize),
    Size is PrevSize + 1.

power(_, 0, 1).
power(Base, Exp, Result) :-
    Exp>0,
    PrevExp is Exp - 1,
    power(Base, PrevExp, PrevResult),
    Result is Base * PrevResult.

iffer(0,X,Y):- Y is X.
iffer(1,X,Y) :-  Y is -X.
niffer(1,X):- write("+"),write(X).
niffer(0,X) :- write("-"),write(X). 
biffer(0,X):- write("+"),write(X).
biffer(1,X) :- write("-"),write(X). 
verify([],_,0).
verify([X|Xs],N,Acc) :-
    verify(Xs,N div 2,NewAcc),
    B is N mod 2,
    iffer(B,X,A),
    Acc is A + NewAcc.
loop_verifier(List,N,X) :- N>=0,verify(List,N,Acc), Acc is 0,X is N.
loop_verifier(List,N,X) :- N>0,loop_verifier(List,N-1,X).
loop_writer([],_).
loop_writer([X|Xs],B) :- Y is B mod 2, biffer(Y,X), loop_writer(Xs,B div 2).
arith([X1|Xs]) :-
    list_size([X1|Xs],N),
    power(2,N,Z),
    G is Z - 1,
    loop_verifier([X1|Xs],G,B),
    C is B mod 2,
    niffer(C, X1),
    write("="),
    loop_writer(Xs,B div 2).
