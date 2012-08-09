-module(ewoc).

-export([start/0]).

start() ->
    ewoc_app:start([], []).
