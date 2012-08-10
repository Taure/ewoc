-module(ewoc_generate_data).

-define(ALLOWED_CHAR, "ABCDEFGHIJKLMNOPQRSTUVWXYZ").

-export([binary/1, string/1, integer/1, list/1]).

-type proplist(K,V) :: [{K, V}].

binary(Actions) ->
    to_binary(do_actions(Actions, [])).

string(_) ->
    "".

integer(Actions) ->
    do_actions(Actions, []).

list(Actions) ->
    do_actions(Actions, []).

-spec do_actions(proplist(atom(), Option), Acc :: list) -> Answer when
      Option :: proplist(atom(), proplist(atom(), list())) |
                integer(),
      Answer :: integer() | list().
do_actions([], Answer) ->
    Answer;
do_actions([{Action, Option}|T], Acc) ->
    case Action of
        words ->
            Words = words(Option, []),
            do_actions(T, [Words|Acc]);
        rand ->
            {A1, A2, A3} = now(),
            random:seed(A1,A2,A3),
            random:uniform(Option);
        seq ->
            {Start, End} = Option,
            lists:seq(Start, End)
    end.

-spec words(list(), list()) -> list().
words([], Acc) ->
    string:join(Acc, " ");
words([H|T], Acc) ->
    Word = do_options(H),
    words(T, Word).

-spec random_chars(Length, AllowedChars) -> list() when
      Length :: integer(),
      AllowedChars :: integer().
random_chars(Length, AllowedChars) ->
    lists:foldl(fun(_, Acc) ->
			[lists:nth(random:uniform(length(AllowedChars)),
                                   AllowedChars) | Acc]
                end, [], lists:seq(1, Length)).

-spec create_word(N :: integer()) -> list().
create_word(N) ->
    random_chars(N, string:to_lower(?ALLOWED_CHAR) ++ ?ALLOWED_CHAR).

-spec do_options(tuple()) -> list().
do_options({Action, Option}) ->
    case Action of
        wsize ->
            [create_word(X) || X<-Option]
    end.

-spec to_binary(Value) -> binary() when
      Value :: integer(),
      Value :: list().
to_binary(Value) when is_integer(Value) ->
    list_to_binary(integer_to_list(Value));
to_binary(Value) when is_list(Value) ->
    list_to_binary(Value).
