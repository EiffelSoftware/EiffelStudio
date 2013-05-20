class TEST

inherit
	A
		redefine
			make_self_precursor
		end

create
	make,
	make_agent_agent,
	make_from,
	make_self_agent,
	make_self_precursor

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_agent_agent (agent do_nothing)
			create t.make_self_agent
			create t.make_self_precursor (t)
			create a
		end

	make_from (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
		end

feature {NONE} -- Initialization

	make_self_precursor (x: ANY)
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			Precursor (Current) -- VEVI
			make
		end

	make_self_agent
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		local
			y: PROCEDURE [ANY, TUPLE]
		do
			y := agent (z: ANY) do z.do_nothing end (Current) -- VEVI
			y.call ([])
			make
		end

	make_agent_agent (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			y: PROCEDURE [ANY, TUPLE]
		do
			y := agent (z: ANY) do z.do_nothing end (x) -- VEVI
			y.call ([])
			make
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
