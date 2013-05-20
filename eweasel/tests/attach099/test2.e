class TEST

create
	make,
	make_self

feature {NONE}

	make
			-- Use `Current' before initializing all attributes.
		local
			t: TEST
		do
			create t.make_self
			create a
		end

feature {NONE} -- Initialization

	make_self
			-- Call Current before initializing all the attributes.
		do
			access_current
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
