class TEST

inherit
	C

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			{TEST}.e1
			{TEST}.e2
			{TEST}.o1
			{TEST}.o2
			{TEST}.p1
			{TEST}.p2
			{TEST}.p3
		end

feature {TEST} -- Tests

	e1
		do
		end

	e2
		do
		end

	o1
		do
		end

	o2
		do
		end

	p1
		do
		end

	p2
		do
		end

	p3
		do
		end

end