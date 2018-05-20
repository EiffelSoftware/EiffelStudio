class TEST

inherit
	A
		undefine
			c1, e1
		redefine
			c2, e2
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.c1.do_nothing
			{TEST}.c2.do_nothing
			{TEST}.c3.do_nothing
			{TEST}.e1
			{TEST}.e2
			{TEST}.e3
		end

feature {TEST} -- Tests

	a: BOOLEAN
		do
			Result := out /= "0"
		end

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	c3: INTEGER_8 = 3

	e1
		external "C inline"
			alias "return"
		end

	e2
		external "C inline"
			alias "return"
		end

	e3
		external "C inline"
			alias "return"
		end

end