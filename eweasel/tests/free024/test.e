class TEST

inherit
	C

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.f1
			{TEST}.f2
		end

feature {TEST} -- Tests

	a: BOOLEAN
		do
			Result := out /= "0"
		end

feature {TEST} -- Tests

	f1
		do
		end

	f2
		do
		end

end