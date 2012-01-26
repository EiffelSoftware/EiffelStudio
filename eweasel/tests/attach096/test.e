class
	TEST

create
	make,
	make_unqualified,
	make_unqualified_safe,
	make_qualified,
	make_inline,
	make_inline_safe,
	make_target,
	make_unqualified_argument,
	make_qualified_argument,
	make_inline_argument

feature {NONE} -- Initialization

	make
			-- Root creation procedure.
		do
			foo := "test"
			bar := "test"
		end

	make_unqualified
			-- Use unqualified agent call.
		do
			bar := "test"
			execute (agent test_foo) -- VEVI
			foo := "test"
		end

	make_unqualified_safe
			-- Use unqualified agent call that does not access uninitialized attributes.
		do
			bar := "test"
			execute (agent test_bar) -- VEVI (Should be no error because test_safe does not use `foo'.)
			foo := "test"
		end

	make_qualified
			-- Use qualified agent call.
		do
			bar := "test"
			execute (agent {TEST}.test_foo) -- No error because `Current' is not stored in the agent.
			foo := "test"
		end

	make_inline
			-- Use inline agent call.
		do
			bar := "test"
			execute (agent do foo.to_lower end) -- VEVI
			foo := "test"
		end

	make_inline_safe
			-- Use inline agent call that does not access uninitialized attributes.
		do
			bar := "test"
			execute (agent do bar.to_lower end) -- VEVI (Should be no error because `foo' is not used.)
			foo := "test"
		end

	make_target
			-- Use qualified agent call on `Current'.
		do
			bar := "test"
			execute (agent (Current).test_foo) -- VEVI
			foo := "test"
		end

	make_unqualified_argument
			-- Use unqualified agent call with `Current' as an argument.
		do
			bar := "test"
			execute (agent test_foo (Current)) -- VEVI
			foo := "test"
		end

	make_qualified_argument
			-- Use qualified agent call with `Current' as an argument.
		do
			bar := "test"
			execute (agent {TEST}.test_foo (Current)) -- VEVI
			foo := "test"
		end

	make_inline_argument
			-- Use inline agent call with `Current' as an argument.
		do
			bar := "test"
			execute (agent (t: TEST) do foo.to_lower end (Current)) -- VEVI
			foo := "test"
		end

feature -- Test

	execute (agt: PROCEDURE [ANY, TUPLE])
		do
			agt.call ([create {TEST}.make, create {TEST}.make])
		end

	test_foo (t: TEST)
		do
			foo.to_lower
		end

	test_bar (t: TEST)
		do
			bar.to_lower
		end

	foo: STRING
	bar: STRING

end
