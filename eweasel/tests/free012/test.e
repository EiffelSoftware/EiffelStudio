class TEST

inherit
	A
		undefine
			c1, e1, f1
		redefine
			c2, e2, f2
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
			{TEST}.f1
			{TEST}.f2
			{TEST}.f3
		end

feature {TEST} -- Tests

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	c3: INTEGER_8 = 3

	e1
		require else
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		end

	e2
		require else
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		end

	e3
		require else
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		end

	f1
		require else
			is_empty: ("").is_empty
		do
		ensure then
			instance_free: class
		end

	f2
		require else
			is_empty: ("").is_empty
		do
		ensure then
			instance_free: class
		end

	f3
		require else
			is_empty: ("").is_empty
		do
		ensure then
			instance_free: class
		end

end