%edd:dd("db:test()").
-module(db).

-export([new/0,write/3,delete/2,
         read/2,match/2,destroy/1]).

%
%Create a new database:
%
%db:new() -> DbRef

new() -> [].

%
%Insert a new element in the database:
%
%db:write(Key, Element, DbRef) -> NewDbRef

write(Key, Element, DbRef) ->
	[{Key,Element}|DbRef].
	
%
%Remove the first occurrence of an element from the database:
%
%db:delete(Key, DbRef) -> NewDbRef	
	
delete(Key, [{Key,_}|Tail]) ->
	Tail;
delete(Key, [Entry |Tail]) ->
	[Entry|delete(Key, Tail)];
delete(_, []) ->
	[].
	
%
%Retrieve the first element in the database with a matching key:
%
%db:read(Key, DbRef) -> {ok, Element} | {error, instance}

read(Key, [{Key,Element}|_]) ->
	{ok,Element};
read(Key, [_ |Tail]) ->
	read(Key, Tail);
read(_, []) ->
	{error, instance}.

%
%Return all the keys whose values match the given element:
%
%db:match(Element, DbRef) -> [Key1, ..., KeyN]

match(Element, [{Key,Element}|Tail]) ->
	%[Key|match(Element,Tail)]; %RIGHT
	[Key|match(Key,Tail)]; %WRONG
match(Element, [_ |Tail]) ->
	match(Element,Tail);
match(_, []) ->
	[].

%
%Delete the database:
%
%db:destroy(DbRef) -> ok

destroy(_) -> ok.
	
	
test() ->
	DB0 = new(),
	DB1 = write(0,hola,DB0),
	DB2 = write(0,adios,DB1),
	DB3 = write(1,hola,DB2),
	DB4 = write(2,adios,DB3),
	DB5 = write(3,hola,DB4),
	io:format("~p\n",[read(0,DB5)]),
	DB6 = delete(0,DB5),
	io:format("~p\n",[read(0,DB6)]),
	io:format("~p\n",[match(hola,DB6)]),
	io:format("~p\n",[match(adios,DB6)]),
	destroy(DB6).

