class
	TEST3 [G]

feature

	set_value (t: TEST4 [G]) is
		do
			value1 := t
			value2.set_value (t)
		end

	value1: TEST4 [G]
	value2: TEST3 [G]

end
