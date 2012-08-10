# Erlang World Creator #

This application is created to create objects following certain
models. The models is put in header file that will be read into ewoc.

Then users can create objects for test by stating what kind of objects
should be created. Still under developing.

# Start #

Download the repo from Git.

## Examples ##

The system will need a model.hrl file as a comfiguration file, later
it maybe will be a config file. But at start it is a .hrl file.

            -define(MODELS, [{book, ?BOOK},
                             {car, ?CAR}]).

            -define(BOOK, [{author, binary},
                           {title, string}]).

            -define(CAR, [{engine, binary},
                          {tires, binary},
                          {doors, integer}]).

This will give ewoc information on how it should build the different
models and get information on how to populate them. What types fields
should have. To create model objects you can use this code:

            ewoc_model_handler:create([{book, 3, []},
                                       {car, 5, []}]).

This will create three book models that are empty and five car models
that are empty. Later it will be available to put default models in
your model.

But for now we must tell ewoc to populate data to the model.

            ewoc_model_handler:create([{book, 3,
                                      [{author, [{words, [{wsize, [6, 20]}]}]}]
                                      }]).

This will create three books with field author populated with words,
and the size on the two words will be 6 and 20 chars.


## Example ##

Start application with start.sh


 ewoc_model_handler:create([{book, 3,
                                      [{author, [{words, [{wsize, [6, 20]}]}]}]
                                      }]).

This will create three books with field author populated with words,
and the size on the two words will be 6 and 20 chars.


## Example ##

Start application with start.sh

    Eshell V5.9.1  (abort with ^G)
    1> ewoc_model_handler:create([{book, 3, [{title, [{words, [{wsize, [6, 20]}]}]}]}]).
    [{book,[[{author,[]},
             {amount,[]},
             {title,<<"HJFudP ENqnSWYmWFbxvHQWaFod">>}],
            [{author,[]},
             {amount,[]},
             {title,<<"RUbkjr uLpEPUTIuFDZccbaQnrR">>}],
            [{author,[]},
             {amount,[]},
             {title,<<"FqAXLx ZEdquyDavxlDiKkhFyIV">>}]]}]