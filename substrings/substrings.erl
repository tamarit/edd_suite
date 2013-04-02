%edd:dd("substrings:test()").
%% Count non-overlapping substrings in Erlang for the rosetta code wiki.
%% Implemented by J.W. Luiten
 
-module(substrings).
-export([main/2,test/0]).
 
%% String exhausted, present result
match([], _Sub, _OrigSub, Acc) ->
  Acc;
 
%% Sub exhausted, count a match
match(String, [], Sub, Acc) ->
  match(String, Sub, Sub, Acc+1);
 
%% First character matches, advance
match([X|MainTail], [X|SubTail], Sub, Acc) ->
  %match(MainTail, SubTail, Sub, Acc); %RIGHT
  match(MainTail, Sub, Sub, Acc); %WRONG
 
%% First characters do not match. Keep scanning for sub in remainder of string
match([_X|MainTail], [_Y|_SubTail], Sub, Acc)->
  match(MainTail, Sub, Sub, Acc).
 
main(String, Sub) ->
   match(String, Sub, Sub, 0).
   
test() ->
   substrings:main("ababababab","abab").