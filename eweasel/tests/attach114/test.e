class TEST

create
	make,
	make_with_other

feature {NONE} -- Creation

	make
			-- Call a creation procedure that makes an implicit qualified call using parenthesis alias.
		do
			create a.make_with_other (Current)
		end

	make_with_other (t: A)
			-- Call a parenthesis alias on `t'.
		do
			a := t
			t (False)
		end

feature -- Access

	a: A
			-- This attribute should not be accessed before it is initialized.

feature -- Basic operation

	f alias "()" (b: BOOLEAN)
			-- Call a feature on attribute `a'.
		do
			a.do_nothing
		end

end