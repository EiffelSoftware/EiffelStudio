class TEST

create
	make,
	make_uninitialized

feature {NONE} -- Creation

	make
			-- Run test.
		do
			create a
			register_uninitialized
			io.put_string (a.f (Current).a.out)
		end

	make_uninitialized
			-- Raise an exception after registering a new object in a once function
			-- and before it is completely initialized.
		do
				-- Pass an incompletely initialized object and
				-- raise an exception after registering it in a once function.
			create a.make (Current)
		end

feature -- Creation

	register_uninitialized
			-- Register an incompletely initialized object in a once function of `{A}`.
		local
			is_retried: BOOLEAN
		do
			if not is_retried then
				;(create {TEST}.make_uninitialized).do_nothing
			end
		rescue
			is_retried := True
			retry
		end

feature -- Access

	a: A
			-- An attribute to be initialized at creation.

end
