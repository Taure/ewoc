-module(ewoc_model_handler).

-include("models.hrl").

-spec create(Proplist) -> Value | [] when
      Proplist :: list(term()),
      Value :: list(term()).
-export([create/1]).

create(Proplist) ->
    create_aux(Proplist, []).

%%%
%%% Internal Functions
%%%

create_aux([], Acc) ->
    Acc;
create_aux([{Modelname, N, Options}|T], Acc) ->
    Listo = create_model_object(Modelname, N, Options, []),
    create_aux(T, [{Modelname, Listo} | Acc]).

create_model_object(_, 0, _, Acc) ->
    Acc;
create_model_object(Name, N, Options, Acc) ->
    Model = get_model_structure(Name),
    PopModel = populate_model(Model, Options),
    create_model_object(Name, N-1, Options, [PopModel|Acc]).

get_model_structure(Name) ->
    proplists:get_value(Name, ?MODELS).

populate_model(Model, Options) ->
    populate_model_aux(Model, Options, []).


populate_model_aux([], _, Acc) ->
    Acc;
populate_model_aux([{Field, Type}|T], Options, Acc) ->
    case proplists:get_value(Field, Options) of
        undefined ->
            populate_model_aux(T, Options, [{Field, put_data(Type, [])} | Acc]);
        FieldOption ->
            populate_model_aux(T, Options, [{Field, put_data(Type, FieldOption)} | Acc])
    end.

put_data(binary, List) ->
    ewoc_generate_data:binary(List);
put_data(integer, _) ->
    ewoc_generate_data:integer(8);
put_data(string, _) ->
    ewoc_generate_data:string("").
