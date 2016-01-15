class TEST

inherit
	A

create
	make

feature {NONE} -- Creation

	make
			-- Make sure features are called.
		do
			b
		end

feature {NONE} -- Test

	a4, c4: INTEGER

end
