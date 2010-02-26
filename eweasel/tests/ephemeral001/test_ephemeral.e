ephemeral class
	TEST_EPHEMERAL

inherit
	TEST1
		redefine
			g
		end

feature

	g
		do
			io.put_string ("TEST_EPHEMERAL.g%N")
		end

	k
		do
			io.put_string ("TEST_EPHEMERAL.k%N")
			m
			n
		end

	m
		do
			io.put_string ("TEST_EPHEMERAL.m%N")
		end

	n
		do
			io.put_string ("TEST_EPHEMERAL.n%N")
		end

end
