.PHONY: test

test: gameServer.beam lisp.beam
	echo "c(gameServer). gameServer:start(). halt()." | erl

gameServer.beam: gameServer.erl
	erlc gameServer.erl

lisp.beam: lisp.erl
	erlc lisp.erl

listTest.beam: listTest.erl
	erlc listTest.erl
