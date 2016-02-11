-module(test).

-export ([iinp/1,
          input/2]).


iinp(A) ->
    io:format("A = ~p~n", [A]),
%%    B = string:to_integer(A),
    input (A, []).

input ([], Acc) -> 
    io:format("Acc = ~p~n", [Acc]),
    lists:reverse(Acc);
input ([H|Tail], Acc) ->
    if H >= 65 andalso H =< 90 ->
            io:format("H1 = ~p~n", [H]),
            Acc = [98|Acc];
       H >= 97 andalso H =< 122 -> 
            io:format("H2 = ~p, Accc ~p~n", [H, Acc]),
            Acc = [97|Acc];
       H == 32 -> 
            io:format("H3 = ~p~n", [H]),
            Acc
    end,
    io:format("Acc1 = ~p~n", [Acc]),
    input (Tail, Acc).
