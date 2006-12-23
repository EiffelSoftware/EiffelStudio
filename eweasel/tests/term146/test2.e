class
	TEST2 [G, H]

inherit
	TEST1 [G]
		redefine
			make
		end

feature

	make is
		do
			Precursor
		end

end
