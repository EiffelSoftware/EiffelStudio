class
	TEST2

inherit
	TEST1
		redefine
			b, make
		end

feature

	b: B


	make is
		do
			Precursor
		end

end
