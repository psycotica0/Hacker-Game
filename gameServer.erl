-module(gameServer).
-export([start/0, readLoop/2, outputEngine/0, spitOutTheData/1, charGetter/1]).

start()-> register('server', self()), register('output', spawn_link(?MODULE, outputEngine, [])),
	case gen_tcp:listen(1337, [list, {packet, 0}, {active, false}]) of
		{ok, LSock}-> acceptLoop(LSock);
		{error, eaddrinuse}-> halt()
	end.

acceptLoop(LSock)-> {ok, Sock} = gen_tcp:accept(LSock), spawn(?MODULE, readLoop, [Sock, []]), acceptLoop(LSock).

readLoop(_, [stop])-> ok;
readLoop(Sock, _)-> ParsedList = lisp:parse(charGetter(Sock)), 'output' ! ParsedList, readLoop(Sock, ParsedList).

charGetter(Sock)->
	fun()->
			case gen_tcp:recv(Sock, 1) of
				{ok, Data}-> Data;
				{error, closed}-> ok;
				{error, Reason}-> {error, Reason}
			end
	end.

outputEngine()->
	receive
		[stop]-> exit(whereis('server'), 'stop');
		Data when is_list(Data)->
			spitOutTheData(Data)
	end,
	outputEngine().

spitOutTheData([])-> ok;
spitOutTheData([Char | Rest]) when is_list(Char)-> io:put_chars("("), spitOutTheData(Char), io:put_chars(") "), spitOutTheData(Rest);
spitOutTheData([Char | Rest])-> io:put_chars(atom_to_list(Char)), io:put_chars(" "), spitOutTheData(Rest).

