class
	TEST3 [G]

inherit
	TEST1 [G]
		redefine
			h
		end

feature

	h: ACTIVE [like Current]
		do
		end

end
