class
	TEST

create
	make,
	make_unqualified,
	make_qualified,
	make_inline,
	make_target,
	make_unqualified_argument,
	make_qualified_argument,
	make_inline_argument

feature {NONE} -- Initialization

	make
			-- Root creation procedure.
		do
			foo := "test"
		end

	make_unqualified
			-- Use unqualified agent call.
		do
			execute (agent test) -- VEVI
			foo := "test"
		end

	make_qualified
			-- Use qualified agent call.
		do
			execute (agent {TEST}.test) -- No error because `Current' is not stored in the agent.
			foo := "test"
		end

	make_inline
			-- Use inline agent call.
		do
			execute (agent do foo.to_lower end) -- VEVI
			foo := "test"
		end

	make_target
			-- Use qualified agent call on `Current'.
		do
			execute (agent (Current).test) -- VEVI
			foo := "test"
		end

	make_unqualified_argument
			-- Use unqualified agent call with `Current' as an argument.
		do
			execute (agent test (Current)) -- VEVI
			foo := "test"
		end

	make_qualified_argument
			-- Use qualified agent call with `Current' as an argument.
		do
			execute (agent {TEST}.test (Current)) -- VEVI
			foo := "test"
		end

	make_inline_argument
			-- Use inline agent call with `Current' as an argument.
		do
			execute (agent (t: TEST) do foo.to_lower end (Current)) -- VEVI
			foo := "test"
		end

feature -- Test

	execute (agt: PROCEDURE [ANY, TUPLE])
		do
			agt.call ([create {TEST}.make, create {TEST}.make])
		end

	test (t: TEST)
		do
			foo.to_lower
		end

	foo: STRING

end

