class TEST

create
	make,
	make_uninitialized

feature {NONE} -- Creation

	make
			-- Run test.
		do
			create t.make_uninitialized (create {A}.make (Current))
		end

	make_uninitialized (a: A)
			-- Raise an exception after registering a new object in a once function
			-- and before it is completely initialized.
		do
			if attached a.item as x then
				t := x.t
			else
				create t.make
			end
			io.put_string (t.out)
		end

feature -- Access

	t: TEST
			-- An attribute to be initialized at creation.

end
