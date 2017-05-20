class TEST

create
	make,
	make_uninitialized

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Call `make_uninitialized` with an expanded object that references current one that is not completely initialized yet.
			create t.make_uninitialized (create {A}.make (Current))
		end

	make_uninitialized (a: A)
			-- Make a call on `{TEST}.t` retrieved from `a`.
		require
			attached a.item
		do
				
			check
				from_precondition: attached a.item as x
			then
					-- `x` is attached, but is not completely initialized.
				t := x.t
			end
			io.put_string (t.out)
		end

feature -- Access

	t: TEST
			-- An attribute to be initialized at creation.

end
