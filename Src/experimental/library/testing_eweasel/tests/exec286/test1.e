class
	TEST1 [G]

inherit
	TEST2 [G]
		redefine
			f
		end

feature

	g1, g2, g3, g4, g5, g7
		do
			f
			g1
		end

	f
		do
			io.put_string ("TEST1.f")
			io.put_new_line
		end

end
