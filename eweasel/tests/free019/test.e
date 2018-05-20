class TEST

inherit
	A
		undefine
			f1
		end

	B

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.f1
			{TEST}.f2
		end

end