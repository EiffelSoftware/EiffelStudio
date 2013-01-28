class TEST

create
	make,
	make_agent,
	make_self

feature {NONE}

	make
			-- Create expanded objects that need to initialize their attributes.
		local
			t: TEST
		do
			create a
			create t.make_self
			create t.make_agent (agent do_nothing)
		end

feature {NONE} -- Initialization

	make_self
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			make
			if Current ~ Void then end -- VEVI
		end

	make_agent (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		do
			make
			if Void /~ x then end -- VEVI
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
