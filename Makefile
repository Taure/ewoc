ERL ?= erl
APP := ewoc

.PHONY: deps test

all: deps compile

compile:
		@./rebar compile

debug:
		@./rebar debug_info=1 compile

deps:
		@./rebar get-deps

app:
		@./rebar compile skip_deps=true

start: app
		exec erl \
                -pa $(PWD)/ebin \
                -name $(APP)@127.0.0.1 \
                -s $(APP)