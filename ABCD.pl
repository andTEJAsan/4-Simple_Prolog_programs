% A - 1 , B - 2 , C - 3 , D - 4
two_member(A,B,X) :- 
    member(A,X),
    member(B,X),
    A \= B.

generator([X,Y],RightBank,Forward,Backward,NewLeft,NewRight,NewFor,NewBack) :- 
NewLeft = [],
NewRight = [X,Y|RightBank],
(NewFor = [[Y,X] | Backward] ; NewFor = [[X,Y]|Forward]),
NewBack = Backward.
generator(LeftBank,RightBank,Forward,Backward,NewLeft,NewRight,NewFor,NewBack) :-
    two_member(Mem1,Mem2,LeftBank),
    delete(LeftBank,Mem1,L1),
    delete(L1,Mem2,L2),
    NewRight1 = [Mem1,Mem2| RightBank],
    (For1 = [[Mem1,Mem2] | Forward] ;
    For1 = [[Mem2,Mem1] | Forward]
    ),
    member(Mem3,NewRight1),
    delete(NewRight1,Mem3,NewRight2),
    Back1 = [Mem3 | Backward],
    NewLeft1 = [Mem3 | L2],
    generator(NewLeft1,NewRight2,For1,Back1,NewLeft,NewRight,NewFor,NewBack).
check_paddleAlice([]).
check_paddleAlice([[X,Y]|Xs] ) :- X \=1, X \= Y, check_paddleAlice(Xs).
check_paddleBob([]).
check_paddleBob([[X,Y]| Xs]) :- X \= 2, check_paddleBob(Xs).
check_paddleBob([[X,Y]| Xs]) :- X=2,Y=3, check_paddleBob(Xs).
PaddleNot(_,[]).
PaddleNot(A,[[X,Y]| Xs]) :- X \= A, PaddleNot(A,Xs).

check_paddleAll(X) :- not(PaddleNot(1,X)),not(PaddleNot(2,X)),not(PaddleNot(3,X)),not(PaddleNot(4,X)).
final(X,A,B,C,D) :-
    generator(X,[],[],[],A,B,C,D)
    ,check_paddleAlice(C)
    ,check_paddleBob(C)
    ,check_paddleAll(C).


%check_paddle(X,Y,People_reached) :- X /= Y, X /= 1,