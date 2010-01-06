class
	TEST

create
	make

feature

	make
		do
		end
			
	detached_tuple_1: TUPLE [a: detachable STRING; b: detachable ANY]
	attached_tuple_1: attached TUPLE [a: attached STRING; b: attached ANY]

	detached_tuple_2: TUPLE [detachable STRING, detachable ANY] -- doesn't work
	attached_tuple_2: attached TUPLE [attached STRING, ANY] -- doesn't work

	l1: TUPLE [STRING, STRING]
	l2: TUPLE [STRING, attached STRING]
	l3: TUPLE [attached STRING]
	l4: TUPLE [attached STRING, STRING] -- doesn't work
	l5: TUPLE [STRING, attached STRING]
	l6: TUPLE [STRING, attached STRING, STRING] -- doesn't work
	l7: TUPLE [a: STRING; b: attached STRING]

	
end
