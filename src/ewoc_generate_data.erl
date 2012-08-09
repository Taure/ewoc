-module(ewoc_generate_data).

-define(ALLOWED_CHAR, "ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ").

-export([binary/1, string/1, integer/1, list/1]).


binary(Actions) ->
    list_to_binary(do_actions(Actions, [])).

string(_) ->
    "".

integer(_) ->
    0.

list(_) ->
    [].

do_actions([], Acc) ->
    Acc;
do_actions([{Action, Option}|T], Acc) ->
    case Action of
        words ->
            Words = words(Option, []),
            do_actions(T, [Words|Acc])
    end.

words([], Acc) ->
    io:format("~s~n", [Acc]),
    string:join(lists:reverse(Acc), " ");
words([H|T], Acc) ->
    Word = do_options(H),
    words(T, [Word | Acc]).

random_chars(Length, AllowedChars) ->
    lists:foldl(fun(_, Acc) ->
			[lists:nth(random:uniform(length(AllowedChars)),
                                   AllowedChars) | Acc]
                end, [], lists:seq(1, Length)).

create_word(N) ->
    random_chars(N, string:to_lower(?ALLOWED_CHAR) ++ ?ALLOWED_CHAR).

do_options({Action, Option}) ->
    case Action of
        ws ->
            [create_word(X) || X<-Option]
    end.
