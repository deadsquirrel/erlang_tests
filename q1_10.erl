%%% @author Yana P. Ribalchenko <yanki@hole.lake>
%%% @copyright (C) 2015, Yana P. Ribalchenko
%%% @doc
%%% 99 Haskell problems in Erlang
%%% questions 1-10:  Lists 
%%% @end
%%% Created : 16 Oct 2015 by Yana P. Ribalchenko <yanki@hole.lake>

-module(q1_10).

-export ([myLast/1,
          myButLast/1,
          elementAt/2 ,
          myLength/1,
          myReverse/1,
          isPalindrome/1,
          myFlatten/1,
          compress/1,
          pack/1,
          encode/1
]).


%%% Problem 1
%%% Find the last element of a list. 

myLast ([]) -> 
    {error, emptylist};
myLast ([H|[]]) -> 
    H;
myLast ([_|T]) ->
    myLast (T).

%%% Problem 2
%%% Find the last but one element of a list. 

myButLast ([H|[_H|[]]]) -> H;
myButLast ([_H|T]) -> 
    myButLast (T).

%%% Problem 3
%%% Find the K'th element of a list. The first element in the list is number 1.
elementAt ([], _K) -> 
    {error,emptylist};
elementAt ([H|T], K) when K > length ([H|T]) ->
    {error,lengthlist};
elementAt ([H|T], K) ->
    elementAtK ([H|T], K, 1).

elementAtK ([H|T], K, N) -> 
    if
        N == K -> H;
        true ->
            elementAtK (T, K, N+1)
    end.

%%% Problem 4
%%% Find the number of elements of a list. 

myLength ([H|T]) ->
    elementcount ([H|T], 1). 

elementcount ([_|[]], K) -> K;
elementcount ([_|T], K) -> 
    elementcount (T, K+1).



%%% Problem 5
%%% Reverse a list. 
myReverse ([]) -> 
    {error,emptylist};
myReverse (List) -> 
    myReverses (List, []).

myReverses ([H|[]], Acc) -> 
    [H|Acc];
myReverses ([H|T], Acc) -> 
    myReverses (T, [H|Acc]).
    

    

%% Problem 6
%%  Find out whether a list is a palindrome. A palindrome can be read 
%% forward or backward; e.g. (x a m a x). 

isPalindrome (List) ->
        List == lists:reverse(List).


%% Problem 7
%%  Flatten a nested list structure.

%% Transform a list, possibly holding lists as elements into a `flat'
%% list by replacing each list with its elements (recursively). 



myFlatten (List) ->
    my_is_list (List, List).


my_is_list ([], List)  ->
    io:format ("1. ~p~n",[List]),
    myFlat(List, []);
my_is_list ([H|_T], List) when is_list (H) -> 
    io:format ("2. H~p~n",[H]),
    io:format ("2. ~p~n",[List]),
    B= myFlat (List, []),
    my_is_list(B, B);

my_is_list ([_H|T], List)  -> 
    io:format ("3. T:~p~n",[T]),
    io:format ("3. ~p~n",[List]),
    my_is_list (T, List).



myFlat ([], ListOut) -> lists:reverse(ListOut);
myFlat ([H|T], ListOut) when is_list (H) ->
    myFlat(T, raskrut (H, ListOut));

myFlat ([H|T], ListOut) ->
    myFlat (T, [H|ListOut]).

raskrut ([], List2) -> List2;
raskrut ([H|T], List2) ->
    raskrut (T, [H|List2]).

    

%% Problem 8
%% Eliminate consecutive duplicates of list elements. 
compress ([H|T]) ->
    lists:reverse(compressed (T, [H])).

compressed ([H1|[]], [H2|List2]) when H1 == H2 ->
    [H2|List2]; 
compressed ([H1|[]], List2) ->
    [H1|List2];
compressed ([H1|T], [H2|List2]) when H1 == H2 ->
    compressed (T, [H2|List2]); 
compressed ([H1|T], List2) ->
    compressed (T, [H1|List2]).

    
%%Problem 9
%% Pack consecutive duplicates of list elements into sublists. If a list contains
%% repeated elements they should be placed in separate sublists.

pack ([H|T]) ->
      lists:reverse(packing (T, H, [H], [])).

packing ([H1|[]], H, List3, List2) when H1 == H ->
    [[H1|List3]|List2]; 
packing ([H1|[]], _H, List3, List2) ->
    [[H1]|[List3|List2]];

packing ([H1|T], H, List3, List2) when H1 == H ->
    packing (T, H1, [H1|List3], List2); 

packing ([H1|T], _H, List3, List2) ->
    packing (T, H1, [H1], [List3|List2]).




%% Problem 10
%% Run-length encoding of a list. Use the result of problem P09 to implement 
%% the so-called run-length encoding data compression method. Consecutive 
%% duplicates of elements are encoded as lists (N E) where N is the number
%% of duplicates of the element E. 

encode ([H|T]) ->
          lists:reverse(encoding (T, H, {1, H}, [])).

encoding ([H1|[]], H, {N, H}, List2) when H1 == H ->
    [{N+1, H}|List2]; 
encoding ([H1|[]], _H, Tuple, List2) ->
    [{1, H1}|[Tuple|List2]];
encoding ([H1|T], H, {N, _H}, List2) when H1 == H ->
    encoding (T, H1, {N+1, _H}, List2); 
encoding ([H1|T], _H, {N, H}, List2) ->
    encoding (T, H1, {1, H1}, [{N, H}|List2]).
