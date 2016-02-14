%%% @author Yana P. Ribalchenko <yanki@hole.lake>
%%% @copyright (C) 2016, Yana P. Ribalchenko
%%% @doc
%%% Decrypt message with Bacon's cipher
%%% @end
%%% Created : 16 Oct 2015 by Yana P. Ribalchenko <yanki@hole.lake>

-module(bacon).

-export([input/2,
         create_proplist/6,
         main/0
        ]).

main () ->
    Key = "aaaaabbbbbabbbaabbababbaaababaab",
    Alphabet = "abcdefghijklmnopqrstuvwxyz",
    KA = create_proplist(Key, Key, Alphabet, [], [], 0),
    io:format("KA = ~p ~n", [KA]).

create_proplist(_, _, [], Res, _List, _Count) -> lists:reverse(Res);
create_proplist([H1|_TKey], [_H|TailKey], [Ha|TAlphabet], Res, List1, 4) ->
    io:format("Alphabet = ~p,~p~n", [Ha,TAlphabet]),
    List2 = [H1|List1],
    Result = [{lists:reverse(List2), Ha}|Res],
    io:format("Result = ~p~n", [Result]),
    create_proplist(TailKey, TailKey, TAlphabet, Result, [], 0);
create_proplist([H1|TKey], Key, Alphabet, Res, List1, Count) ->
    io:format("H1 = ~p, List1 = ~p~n", [H1,List1]),
    List2 = [H1|List1],
    create_proplist(TKey, Key, Alphabet, Res, List2, Count+1).



    

input ([], Acc) -> 
    lists:reverse(Acc);
input ([H|Tail], Acc) ->
    Asdf=
        if H >= 65 andalso H =< 90 ->
                [98|Acc];
           H >= 97 andalso H =< 122 -> 
                [97|Acc];
           H == 32 -> 
                [Acc]
        end,
    input (Tail, Asdf).



