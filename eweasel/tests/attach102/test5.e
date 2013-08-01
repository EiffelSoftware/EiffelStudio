class TEST

inherit
	A
		redefine
			make_agent_precursor
		end

create
	make,
	make_agent_creation_expression,
	make_agent_creation_instruction,
	make_agent_precursor,
	make_agent_qualified,
	make_agent_unqualified,
	make_from

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_agent_creation_expression (agent do_nothing)
			create t.make_agent_creation_instruction (agent do_nothing)
			create t.make_agent_precursor (agent do_nothing)
			create t.make_agent_qualified (agent do_nothing)
			create t.make_agent_unqualified (agent do_nothing)
			create a
		end

	make_from (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
			create a
		end

feature {NONE} -- Initialization

	make_agent_unqualified (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			access (x) -- VEVI
			make
		end

	make_agent_qualified (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			t: TEST
		do
			create t.make
			t.access (x) -- VEVI
			make
		end

	make_agent_precursor (x: ANY)
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			Precursor (x) -- VEVI
			make
		end

	make_agent_creation_instruction (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			t: TEST
		do
			create t.make_from (x) -- VEVI
			make
		end

	make_agent_creation_expression (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			if create {TEST}.make_from (x) = Void then end -- VEVI
			make
		end

feature -- Access

	access (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
