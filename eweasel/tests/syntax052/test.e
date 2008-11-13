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

	detached_tuple_2: TUPLE [?STRING; ?ANY]
	attached_tuple_2: !TUPLE [!STRING; ANY]
	
end
