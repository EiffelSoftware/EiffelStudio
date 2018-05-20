class B

feature {TEST} -- Tests

	a: BOOLEAN
		do
			Result := out /= "0"
		end

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	e1
		external "C inline"
			alias "return"
		end

	e2
		external "C inline"
			alias "return"
		end

end