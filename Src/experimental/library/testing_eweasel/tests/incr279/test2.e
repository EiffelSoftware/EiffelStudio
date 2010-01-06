class
	TEST2 [$FORMAL]

inherit
	TEST1 [$FORMAL_2]
		redefine
			make
		end

feature

	make is
		do
			Precursor
		end


end
