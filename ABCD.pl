% A - 1 , B - 2 , C - 3 , D - 4
name_printer(1) :- write("Alice").
name_printer(2) :- write("Bob").
name_printer(3) :- write("Carol").
name_printer(4) :- write("Davis").
name_printer(5) :- write("Ethan").
multiplicity(X,Y,0) :- not(member(X, Y)).
multiplicity(X,[X|Ys],N) :-
    multiplicity(X,Ys,A),
    N is A+1.
multiplicity(X,[Y|Ys],N) :-
    Y \= X,
    multiplicity(X,Ys,N).

two_member(A,B,X) :- 
    member(A,X),
    member(B,X),
    A =< B,
    A \= B.

generator([X,Y],RightBank,Forward,Backward,NewLeft,NewRight,NewFor,NewBack) :- 
NewLeft = [],
sort([X,Y| RightBank], NewRight)
,
(NewFor = [[Y,X] | Forward] ; NewFor = [[X,Y]|Forward]),
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
    delete(NewRight1,Mem3,NewRightX),
    Back1 = [Mem3 | Backward],
    sort(NewRightX,NewRight2),
    sort([Mem3|L2], NewLeft1),
    
    generator(NewLeft1,NewRight2,For1,Back1,NewLeft,NewRight,NewFor,NewBack).
check_paddleAlice([]).
check_paddleAlice([[X,Y]|Xs] ) :- X \=1, X \= Y, check_paddleAlice(Xs).
check_paddleBob([]).
check_paddleBob([[X,Y]| Xs]) :- X \= 2, check_paddleBob(Xs).
check_paddleBob([[X,Y]| Xs]) :- X=2,Y=3, check_paddleBob(Xs).
paddleNot(_,[]).
paddleNot(A,[[X,Y]| Xs]) :- X \= A, paddleNot(A,Xs).
checkera(A,Y,X) :- member(A,Y).
checkera(A,Y,X) :- not(member(A,Y)),not(paddleNot(A,X)).
check_paddleAll(X,Y) :- checkera(1,Y,X),checkera(2,Y,X),checkera(3,Y,X),checkera(4,Y,X).
creator([],[]).
creator([[A,B]|Xs],Y) :- creator(Xs,Z), Y = [A | Z].
concatenator([],L,L).
concatenator([X|Xs],A,B) :- concatenator(Xs,A,C), B = [X | C].
double_crosser(L,[Head|Tail],Head) :- multiplicity(Head,L,C) ,  C is 2, ! .
double_crosser(L,[Head|Tail],X) :- double_crosser(L,Tail,X).
double_crosseru(X,Y) :- double_crosser(X,X,Y).
final(X,A,B,C,D) :-
    generator(X,[],[],[],A,B,C,D),
    check_paddleAll(C,D),
    check_paddleAlice(C),
    check_paddleBob(C).

log_printer([[X,Y]],[]) :- 
    name_printer(X),write(" paddles, "),name_printer(Y),write(" comes along.\n").
log_printer([[X,Y] | Xs], [Head| Tail]) :- log_printer(Xs,Tail),
    name_printer(Head),write(" returns.\n"),
    name_printer(X),write(" paddles, "),name_printer(Y),write(" comes along.\n").
   

abcd() :-
    final([1,2,3,4],A,B,C,D),
    creator(C,E),
    concatenator(E,D,F),
    write("---------------------------------------------\n"),
    write("Starting Log\n"),
    log_printer(C,D),
    double_crosseru(F,Z),
    name_printer(Z),write(" is the person that Paddles Twice\n"),   
    write("End Log\n"),
    write("---------------------------------------------\n").

%check_paddle(X,Y,People_reached) :- X /= Y, X /= 1,