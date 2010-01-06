class B

inherit

	A
		redefine
			f
		end

create
	make

feature

	make is
		do
		end

	f is
			-- Make sure the parent precondition is checked.
		require else
			false
		do
		end

end