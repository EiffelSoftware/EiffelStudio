class
	TEST4

inherit
	TEST1 [INTEGER]
		redefine
			h
		end

feature

	h: ACTIVE [like Current]
		do
		end

end
