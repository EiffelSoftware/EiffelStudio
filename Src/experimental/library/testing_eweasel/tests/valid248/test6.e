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

	infix "<" (other: like Current): BOOLEAN
		do

		end

end
