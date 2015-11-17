class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			create a.make (Current)
		end

feature -- Access

	a: A
			-- This attribute should not be accessed before it is initialized.

feature

	f alias "()" (b: BOOLEAN)
			-- Call a feature on attribute `a'.
		do
			a.do_nothing
		end

end