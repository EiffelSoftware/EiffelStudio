class
	TEST2 [$FORMAL]

inherit
	TEST1 [$FORMAL]
		redefine
			make
		end

feature

	make is
		do
			Precursor
		end


end
