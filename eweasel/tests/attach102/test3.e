class TEST

inherit
	A

create
	make,
	make_from,
	make_self_creation_expression,
	make_self_creation_instruction

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_self_creation_expression
			create t.make_self_creation_instruction
			create a
		end

	make_from (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
			create a
		end

feature {NONE} -- Initialization

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
