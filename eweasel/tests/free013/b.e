class B

feature {TEST} -- Tests

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	e1
		require
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		end

	e2
		require
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		end

	f1
		require
			is_empty: ("").is_empty
		do
		ensure
			instance_free: class
		end

	f2
		require
			is_empty: ("").is_empty
		do
		ensure
			instance_free: class
		end

end