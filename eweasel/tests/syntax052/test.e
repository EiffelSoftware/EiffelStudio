class
	TEST

create
	make

feature

	make
		do
		end
			
	detached_tuple_1: TUPLE [a: ?STRING; b: ?ANY]
	attached_tuple_1: !TUPLE [a: !STRING; a: !ANY]

	detached_tuple_2: TUPLE [?STRING, ?ANY] -- doesn't work
	attached_tuple_2: !TUPLE [!STRING, ANY] -- doesn't work

	l1: TUPLE [STRING, STRING]
	l2: TUPLE [STRING, !STRING]
	l3: TUPLE [!STRING]
	l4: TUPLE [!STRING, STRING] -- doesn't work
	l5: TUPLE [STRING, !STRING]
	l6: TUPLE [STRING, !STRING, STRING] -- doesn't work
	l7: TUPLE [a: STRING; b: !STRING]

	
end
