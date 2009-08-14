-module(lisp).
-export([parse/1]).

% Originally I was calling getTerm here.
% The problem was, though, that I'm expecting the input to start with '(', so it just ended up being getTerm->readTerm->getTerm
% The data then ended up as a list inside a list.
% This also made it posible for "+ 3 6)" to be valid, which I didn't want.
% Now I'm happy, but the flow is a little weird.
parse(CharGen)-> readTerm(CharGen, [], CharGen()).

% This will ignore WhiteSpace.
% On first non-whitesepace char it will start putting chars it gets into a list
% On first whitespace again it will list_to_atom that and return the atom

% When it hits a "(" it will decend
% When it hits a ")" it will ascend, returning a list
% At the end of a list it will return a tuple {close, DATA}
% The data field could be blank, but it could also be '6' in the case of "(+ 5 6)"
% The reason is that I won't be done parsing the term until I hit the ")".
getTerm(CharGen, List)-> case readTerm(CharGen, [], CharGen()) of
		{close, nothing}-> lists:reverse(List);
		{close, Term}-> lists:reverse([Term | List]);
		Term-> getTerm(CharGen, [Term | List])
	end.

% This will start reading a term as a list
readTerm(CharGen, [], "(")-> getTerm(CharGen, []);
% This one closes the list when there's no data ex: "(+ 6 5 )"
readTerm(_, [], ")")-> {close, nothing};
% This closes list when there is data ex. "(+ 6 5)"
readTerm(_, List, ")")-> {close, list_to_atom(lists:reverse(List))};
% This one is leading spaces ex. " 4"
readTerm(CharGen, [], " ")-> readTerm(CharGen, [], CharGen());
% These consume leading newlines
readTerm(CharGen, [], "\r")-> readTerm(CharGen, [], CharGen());
readTerm(CharGen, [], "\n")-> readTerm(CharGen, [], CharGen());
% This one is a term separator
readTerm(_, List, " ")-> list_to_atom(lists:reverse(List));
% This is another char
readTerm(CharGen, List, Else)-> [Char | _] = Else, readTerm(CharGen, [Char | List], CharGen()).
