class TEST

create
	make,
	make_self_attribute

feature {NONE}

	make
			-- Create objects that need to initialize their attributes.
		local
			t: TEST
		do
			create t.make_self_attribute
			create a
			create b
		end

feature {NONE} -- Initialization

	make_self_attribute
			-- Fulfil targeted conditions for `Current' before initializing all the attributes.
		do
			a := Current -- VEVI
			if a /~ Void then end
			b := Current
			if a /~ Void then end
			make
		end

feature {NONE} -- Access

	a, b: ANY
			-- Storage.

end
