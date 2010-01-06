class TEST2
inherit
	TEST1 [INTEGER]
		undefine
			h
		end

	TEST3 [INTEGER]
		redefine
			h
		end

feature
	
	h: LIST [like Current]

end
