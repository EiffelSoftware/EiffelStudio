class TEST

inherit
	A
		undefine
			f1
		redefine
			f2
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.f1
			{TEST}.f2
			{TEST}.f3
		end

feature {TEST} -- Tests

	a: BOOLEAN
		do
			Result := out /= "0"
		end

	f1
		do
		ensure then
			instance_free: class
		end

	f2
		do
		ensure then
			instance_free: class
		end

	f3
		do
		ensure then
			instance_free: class
		end

end