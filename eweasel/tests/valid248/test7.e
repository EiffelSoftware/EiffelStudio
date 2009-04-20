class
	TEST7

inherit
	TEST3
		redefine
			infix "<"
		end

	TEST4
		redefine
			is_less
		end

feature

	is_less alias "<" (other: like Current): BOOLEAN
		do

		end

end
