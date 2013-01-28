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
			-- Call Current before initializing all the attributes.
		do
			access_current
			make
		end

	make_agent (x: PROCEDURE [ANY, TUPLE])
			-- Call agent `x' before initializing all the attributes of `Current'.
		do
			x.call (Void) -- VEVI
			make
		end

feature -- Access

	access_current
			-- Make a call on `Current'.
		do
			Current.do_nothing -- VEVI
		end

feature {NONE} -- Access

	a: ANY
			-- Storage.

end
