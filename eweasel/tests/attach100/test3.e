class TEST

create
	make,
	make_agent

feature {NONE}

	make
			-- Create expanded objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_agent (agent do_nothing)
			create a
		end

feature {NONE} -- Initialization

	make_agent (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			if Void /~ x then end -- VEVI
			make
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
