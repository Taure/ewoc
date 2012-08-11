# Documentation #

## Types ##

Types supported now in model is binary and integer.

    -define(BOOK, [{key, binary},
                   {author, binary},
                   {amount, integer},
                   {title, binary}]).

## Actions ##

### words ###

Words will say to ewoc that it will create words, it will take a
proplist containing options. Options implemented is wsize that takes a
list. Where each element in list is size on word.

    [{author, [{words, [{wsize, [6, 20]}]}]

This will say that field author should have two words with the size of
6 chars and 20 chars.

### rand ###

Rand returns random number. Either in a interval or as a single random number.

    [{amount, [{rand, 40}]}]

Will randomize a number from 0 to 40 and return it to field amount.

    [{amount, [{rand, {6, 20}}]}]

Will randomize a number between 6 and 20 and return it to field amount.

Depending on type in the model it will be as a integer or binary.

### uuid ###

Uuid will use the uuid application to generate a uuid using uuid:get_v4().

    [{key, [{uuid, []}]}]

This will generate a uuid to the field key.

### mfa ###

Added a mfa functionality now, we can use other modules to generate
data if we want.

This is our module:

    -module(user).

    -export([start/0, return/1]).

    start() ->
        <<"awesome">>.

    return(N) ->
        N + 1.


    Erlang R15B01 (erts-5.9.1) [source] [64-bit] [smp:3:3] [async-threads:0] [kernel-poll:false]

    Eshell V5.9.1  (abort with ^G)
    (ewoc@127.0.0.1)1> ewoc_model_handler:create([{book, 2, [{author, [{mfa, {user, start, []}}]}, {title, [{mfa, {user, return, [4]}}]}]}]).
    [{book,[[{author,<<"awesome">>},{amount,[]},{title,<<"5">>}],
           [{author,<<"awesome">>},{amount,[]},{title,<<"5">>}]]}]



