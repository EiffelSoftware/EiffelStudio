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
			print ({l_exp: EXPANDED_OBJ} expanded_any)
			print ("%N")
		end

feature -- Access

	expanded_any: ?ANY
		do
			create {EXPANDED_OBJ} Result
		end

invariant
	test: {l_exp: EXPANDED_OBJ} expanded_any

end