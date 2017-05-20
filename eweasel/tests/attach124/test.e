class TEST

create
	make,
	make_uninitialized

feature {NONE} -- Creation

	make
			-- Run test.
		do
			set_a
			io.put_string (f.a.out)
		end

	make_uninitialized
			-- Raise an exception after registering a new object in a once function
			-- and before it is completely initialized.
		do
				-- No qualified calls can be made, only reference comparison and boolean tests.
			check f = Void then end
			a := Current
		end

feature {NONE} -- Initialization

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

feature {TEST} -- Access

	a: TEST
			-- An attribute to be initialized at creation.

feature {NONE} -- Access

	f: TEST
			-- A once function returning an incompletely initialized object.
		once
			Result := Current
		end

end
