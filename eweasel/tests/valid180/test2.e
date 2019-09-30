class
	TEST2

inherit
	TEST1
		rename
			g as g alias "-"
		redefine
			f
		end

feature

	f is
		do
		end

end
