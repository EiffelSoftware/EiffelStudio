class TEST

inherit
	A
		redefine
			make_agent_precursor,
			make_self_precursor
		end

create
	make,
	make_agent_agent,
	make_agent_creation_expression,
	make_agent_creation_instruction,
	make_agent_precursor,
	make_agent_qualified,
	make_agent_unqualified,
	make_from,
	make_self_agent,
	make_self_creation_expression,
	make_self_creation_instruction,
	make_self_precursor,
	make_self_qualified,
	make_self_unqualified

feature {NONE}

	make
			-- Create expanded objects that need to initialize their attributes.
		local
			t: TEST
		do
			create a
			create t.make_self_agent
			create t.make_self_creation_expression
			create t.make_self_creation_instruction
			create t.make_self_precursor (t)
			create t.make_self_qualified
			create t.make_self_unqualified
			create t.make_agent_agent (agent do_nothing)
			create t.make_agent_creation_expression (agent do_nothing)
			create t.make_agent_creation_instruction (agent do_nothing)
			create t.make_agent_precursor (agent do_nothing)
			create t.make_agent_qualified (agent do_nothing)
			create t.make_agent_unqualified (agent do_nothing)
		end

	make_from (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
		end

feature {NONE} -- Initialization

	make_self_unqualified
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			access (Current) -- VEVI
			make
		end

	make_self_qualified
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		local
			t: TEST
		do
			create t.make
			t.access (Current) -- VEVI
			make
		end

	make_self_precursor (x: ANY)
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			Precursor (Current) -- VEVI
			make
		end

	make_self_creation_instruction
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		local
			t: TEST
		do
			create t.make_from (Current) -- VEVI
			make
		end

	make_self_creation_expression
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			if create {TEST}.make_from (Current) = Void then end -- VEVI
			make
		end

	make_self_agent
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		local
			y: PROCEDURE [ANY, TUPLE]
		do
			y := agent (z: ANY) do z.do_nothing end (Current) -- VEVI
			make
		end

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

	make_agent_agent (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			y: PROCEDURE [ANY, TUPLE]
		do
			y := agent (z: ANY) do z.do_nothing end (x) -- VEVI
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
