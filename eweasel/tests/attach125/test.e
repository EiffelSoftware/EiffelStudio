class TEST

create
	make,
	make_uninitialized

feature {NONE} -- Creation

	make
			-- Run test.
		do
			set_a
			if attached f.y.y as y then
				io.put_string (y.a.out)
			end
		end

	make_uninitialized
			-- Raise an exception after registering a new object in a once function
			-- and before it is completely initialized.
		do
			check not attached f then end
			a := Current
		end

feature -- Creation

	set_a
			-- Set attribute `a` with a side effect of initializing
			-- a once function `f` with an incompleetely initialized object.
		local
			is_retried: BOOLEAN
		do
			if is_retried then
				a := Current
			else
				create a.make_uninitialized
			end
		rescue
			is_retried := True
			retry
		end

feature -- Access

	a: TEST
			-- An attribute to be initialized at creation.

	f: A
			-- A once function returning an object referencing an incompletely initialized object.
		once
			create Result.make (Current)
		end

end
