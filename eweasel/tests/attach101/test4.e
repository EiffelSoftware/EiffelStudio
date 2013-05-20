class TEST

create
	make,
	make_agent_local

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_agent_local (agent do_nothing)
			create a
		end

feature {NONE} -- Initialization

	make_agent_local (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			y: ANY
		do
			y := x -- VEVI
			if Void /~ y then end
			make
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
