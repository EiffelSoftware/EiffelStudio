class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			execute (agent test)
			foo := "test"
		end

	execute (agt: PROCEDURE [ANY, TUPLE])
		do
			agt.call (Void)
		end

	test
		do
			foo.to_lower
		end

	foo: STRING

end

