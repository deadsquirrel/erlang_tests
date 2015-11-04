%%% @author Yana P. Ribalchenko <yanki@hole.lake>
%%% @copyright (C) 2015, Yana P. Ribalchenko
%%% @doc
%%% 99 Haskell problems in Erlang
%%% questions 11-20:  Lists continued
%%% @end
%%% Created : 16 Oct 2015 by Yana P. Ribalchenko <yanki@hole.lake>

-module(q11_20).

-export ([encodemod/1,
          decodeModified/1,
          encodedirect/1,
          dupli/1,
          repli/2,
          split/2,
          slice/3,
          rotate/2,
          remove_at/2
         ]).


%%% Problem 11
%%% Modified run-length encoding. 
encodemod ([H|T]) ->
    enc (encoding (T, H, {1, H}, []), []). 
    
enc ([], List2) -> List2;
enc ([{1, U}|T], List2)  ->
    enc (T, [U|List2]);
enc ([H|T], List2) ->
    enc (T, [H|List2]).

encoding ([H1|[]], H, {N, H}, List2) when H1 == H ->
    [{N+1, H}|List2]; 
encoding ([H1|[]], _H, Tuple, List2) ->
    [H1|[Tuple|List2]];
encoding ([H1|T], H, {N, _H}, List2) when H1 == H ->
    encoding (T, H1, {N+1, _H}, List2); 
encoding ([H1|T], _H, {N, H}, List2) ->
    encoding (T, H1, {1, H1}, [{N, H}|List2]).




%%  Problem 12
%%  Decode a run-length encoded list. 
decodeModified (List) ->
    lists:reverse(cikle (List, [])).

cikle ([], ListOut) -> ListOut;
cikle ([{N, U}|T], ListOut) when N > 1 -> 
    cikle ([{N-1, U}|T], [U|ListOut]);

cikle ([{_N, U}|T], ListOut) -> 
    cikle (T, [U|ListOut]).
                               


%%  Problem 13
%%  Run-length encoding of a list (direct solution). 
encodedirect (List) ->
    lists:reverse(cil 
(List, [])).

cil ([], ListOut) -> ListOut;
cil ([H|T], ListOut)  when is_integer(H)-> 
    cil (T, [H|ListOut]);
cil ([{N, U}|T], ListOut) when N > 1 -> 
    cil ([{N-1, U}|T], [U|ListOut]);
cil ([{_N, U}|T], ListOut) -> 
    cil (T, [U|ListOut]).


%% Problem 14
%% Duplicate the elements of a list. 
dupli (ListIn) ->
    lists:reverse(dup (ListIn, [])).

dup ([], ListOut) ->ListOut;
dup ([H|T], ListOut) ->
    dup (T, [H|[H|ListOut]]).
    



%% Problem 15
%% Replicate the elements of a list a given number of times.

repli (ListIn, N) ->
    lists:reverse(rep (ListIn, N, [])).

rep ([], _N,  ListOut) -> ListOut;
rep ([H|T], N, List) ->
    rep (T, N, count (H, N, List)).
    
count (_U, 0, ListOut) -> ListOut;
count (U, N, ListOut) ->
    count (U, N-1, [U|ListOut]).

%%Problem 17
%% Split a list into two parts; the length of the first part is given.
split (List, K) when K > length (List) orelse K < 1 ->
    {error,length};
split (List, K) ->
    splitK (List, K, 1, []).

splitK ([H|T], N, I, ListOut) when I == N ->
    [lists:reverse([H|ListOut]),T];
splitK ([H|T], N, I, ListOut) ->
    splitK (T, N, I+1, [H|ListOut]).
    

%% Problem 18
%% Extract a slice from a list.
slice (_List, K, N) when K > N ->
    {error,largeK};
slice (_List, K, N) when K <1 orelse N<1 ->
    {error,small};
slice (List, _K, N) when N > length (List)->
    {error, largeN};
slice (List, K, N) -> 
    sli (List, K, N, 1, []).

sli([], _K, _N, _S, ListOut) -> lists:reverse(ListOut);
sli([H|T], K, N, S, ListOut)
  when S =< N andalso S >= K -> 
    sli (T,K,N,S+1,[H|ListOut]);
sli([_H|T], K, N, S, ListOut) -> 
    sli (T,K,N,S+1,ListOut).                          
                                  


%%Problem 19
%% Rotate a list N places to the left.
 rotate (List, N) ->
    rot (List, N, 1, []).

rot ([H|T], N, K, ListOut) when K=<N -> 
    rot (T, N, K+1, [H|ListOut]);
rot (List, _N, _K, ListOut) ->
    lists:flatten(List, lists:reverse(ListOut)).
    
    

%% Problem 20
%% Remove the Kth element from a list.
remove_at(List, K)  when K < 1 orelse K > length (List)->
    {error};
remove_at(List, K) ->
    lists:reverse(rem_at (List, K, 1, [])).

rem_at ([], _K, _N, ListOut) -> ListOut;
rem_at([_H|T], K, N, ListOut) when K == N ->
    rem_at (T, K, N+1, ListOut);
rem_at([H|T], K, N, ListOut) ->
    rem_at (T, K, N+1, [H|ListOut]).

