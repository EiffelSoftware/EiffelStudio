class TEST

create
	make,
	make_agent_attribute,
	make_agent_local,
	make_self_attribute,
	make_self_local

feature {NONE}

	make
			-- Create expanded objects that need to initialize their attributes.
		local
			t: TEST
		do
			create a
			create t.make_self_local
			create t.make_self_attribute
			create t.make_agent_local (agent do_nothing)
			create t.make_agent_attribute (agent do_nothing)
		end

feature {NONE} -- Initialization

	make_self_local
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		local
			x: ANY
		do
			x := Current -- VEVI
			if Void ~ x then end
			make
		end

	make_self_attribute
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			a := Current -- VEVI
			if a /~ Void then end
			make
		end

	make_agent_local (x: PROCEDURE [ANY, TUPLE])
			-- Fulfil targeted conditions for agent `x' before initializing all the attributes of `Current'.
		local
			y: ANY
		do
			y := x -- VEVI
			if Void /~ y then end
			make
		end

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
