class
	TEST2

inherit
	TEST1
		rename
			infix "+" as infix "-"
		redefine
			f
		end

feature

	f is
		do
		end

end
