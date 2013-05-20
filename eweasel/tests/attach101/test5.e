class TEST

create
	make,
	make_agent_attribute

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_agent_attribute (agent do_nothing)
			create a
		end

feature {NONE} -- Initialization

	make_agent_attribute (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			a := x -- VEVI
			if a ~ Void then end
			make
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
