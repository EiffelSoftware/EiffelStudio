class
	TEST6

inherit
	TEST3
		redefine
			infix "<"
		end

	TEST4
		redefine
			infix "<"
		end

feature

	is_less alias "<" (other: like Current): BOOLEAN
		do

		end

end
