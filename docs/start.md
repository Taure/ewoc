# Documentation #

## Types ##

Types supported now in model is binary and integer.

    -define(BOOK, [{author, binary},
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