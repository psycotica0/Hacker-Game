-module(listTest).
-export([getChar0/0, getChar1/0]).

getChar0()-> case erlang:get(getChar) of
		undefined-> erlang:put(getChar, 1), "(";
		1-> erlang:put(getChar, erlang:get(getChar)+1), "+";
		2-> erlang:put(getChar, erlang:get(getChar)+1), " ";
		3-> erlang:put(getChar, erlang:get(getChar)+1), "4";
		4-> erlang:put(getChar, erlang:get(getChar)+1), " ";
		5-> erlang:put(getChar, erlang:get(getChar)+1), "(";
		6-> erlang:put(getChar, erlang:get(getChar)+1), "-";
		7-> erlang:put(getChar, erlang:get(getChar)+1), " ";
		8-> erlang:put(getChar, erlang:get(getChar)+1), "6";
		9-> erlang:put(getChar, erlang:get(getChar)+1), " ";
		10-> erlang:put(getChar, erlang:get(getChar)+1), "2";
		11-> erlang:put(getChar, erlang:get(getChar)+1), ")";
		12-> erlang:put(getChar, erlang:get(getChar)+1), ")";
		_-> erlang:erase(getChar), getChar0()
	end.

getChar1()-> case erlang:get(getChar) of
		undefined-> erlang:put(getChar, 1), "(";
		1-> erlang:put(getChar, erlang:get(getChar)+1), "s";
		2-> erlang:put(getChar, erlang:get(getChar)+1), "t";
		3-> erlang:put(getChar, erlang:get(getChar)+1), "o";
		4-> erlang:put(getChar, erlang:get(getChar)+1), "p";
		5-> erlang:put(getChar, erlang:get(getChar)+1), ")";
		_-> erlang:erase(getChar), getChar1()
	end.
