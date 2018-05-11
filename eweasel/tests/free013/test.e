class TEST

inherit
	A
		undefine
			c1, e1, f1
		redefine
			c2, e2, f2
		end
	B

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.c1.do_nothing
			{TEST}.c2.do_nothing
			{TEST}.e1
			{TEST}.e2
			{TEST}.f1
			{TEST}.f2
		end

end