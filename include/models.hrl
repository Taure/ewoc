-define(MODELS, [{book, ?BOOK},
                 {cars, ?CARS}]).

-define(BOOK, [{title, binary},
               {amount, integer},
               {author, string}]).
-define(CARS, [{engine, {binary, [{words, 5}]}}]).
