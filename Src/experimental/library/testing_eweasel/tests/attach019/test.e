class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			test;
			(agent test).call (Void)
		end

	test
		do
			print (attached {EXPANDED_OBJ} expanded_any as l_exp)
			print ("%N")
		end

feature -- Access

	expanded_any: detachable ANY
		do
			create {EXPANDED_OBJ} Result
		end

invariant
	test: attached {EXPANDED_OBJ} expanded_any as l_exp

end
