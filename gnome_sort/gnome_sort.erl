-module(gnome_sort).
-export([gnome/1]).
 
gnome(L, []) -> L;
gnome([Prev|P], [Next|N]) when Next > Prev ->
	gnome(P, [Next|[Prev|N]]);
gnome(P, [Next|N]) ->
	%gnome([Next|N], P). %WRONG
	gnome([Next|P], N). %RIGHT
gnome([H|T]) -> gnome([H], T).