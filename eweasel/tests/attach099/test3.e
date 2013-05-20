class TEST

create
	make,
	make_agent

feature {NONE}

	make
			-- Use an agent before initializing all attributes.
		local
			t: TEST
		do
			create t.make_agent (agent do_nothing)
			create a
		end

feature {NONE} -- Initialization

	make_agent (x: PROCEDURE [ANY, TUPLE])
			-- Call agent `x' before initializing all the attributes of `Current'.
		do
			x.call (Void) -- VEVI
			make
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
