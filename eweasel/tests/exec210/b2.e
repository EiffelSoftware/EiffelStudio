class B

inherit

	A
		redefine
			f, g
		end

create
	make

feature

	make is
		do
				-- Initialize `g' to fullfill the precondition of `f'.
			g := 5
		end

	f is
			-- Make sure the parent precondition is checked.
		require else
			false
		do
		end

	g: INTEGER

end