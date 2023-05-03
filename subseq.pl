sizeof([],0).
sizeof([_X|Xs],N) :-
    sizeof(Xs,A),
    N is A + 1.
% subseq([],A).
% subseq([X|Xs],A) :- 
% I have used 1 based indexing
splitter(X,0,Y) :- X=Y .
splitter([_Hd|Tl],N,Y) :-
    A is N-1,
    splitter(Tl,A,Y).
mymember(X,[X|_Tl],1).
mymember(X,[_Y|Tl],N) :- 
    mymember(X,Tl,A),
    N is A+1.
% Will calculate the first index of any element X in a list
subsequence([],_A).
subsequence([X|Xs],[X|Ys]) :-
    subsequence(Xs,Ys).

subsequence(A,[_Y|Ys]) :- 
    subsequence(A,Ys).
