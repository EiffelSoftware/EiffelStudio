class
	TEST2

inherit
	TEST_EPHEMERAL
		redefine
			g, m
		end

feature

	g
		do
			io.put_string ("TEST2.g%N")
		end

	m
		do
			io.put_string ("TEST2.m%N")
		end

end
