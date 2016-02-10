%%% @author Yana P. Ribalchenko <yanki@hole.lake>
%%% @copyright (C) 2016, Yana P. Ribalchenko
%%% @doc
%%% Decrypt message with Bacon's cipher
%%% @end
%%% Created : 16 Oct 2015 by Yana P. Ribalchenko <yanki@hole.lake>

-module(bacon).

-export([input/2

        ]).

%%% Key = 'aaaaabbbbbabbbaabbababbaaababaab'.
%%% Alphabet = 'abcdefghijklmnopqrstuvwxyz'.


input ([], Acc) -> 
    lists:reverse(Acc);
input ([H|Tail], Acc) ->
    if H >= 65 andalso H =< 90 ->
            [98|Acc];
       H >= 97 andalso H =< 122 -> 
            [97|Acc];
       H == 32 -> 
            [Acc]
    end,
    input (Tail, Acc).




