class TEST

inherit
	A
		undefine
			e1, i1, p1, q1
		redefine
			e2, i2, p2, q2
		end

	B
		undefine
			i1, q1
		redefine
			i2, q2
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
		end

feature {NONE} -- Tests

	e1
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	e2
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	e3
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	i1
		external "C inline"
			alias "return"
		end

	i2
		external "C inline"
			alias "return"
		end

	i3
		external "C inline"
			alias "return"
		end

	p1
		do
		ensure then
			is_class: class
		end

	p2
		do
		ensure then
			is_class: class
		end

	p3
		do
		ensure then
			is_class: class
		end

	q1
		do
		end

	q2
		do
		end

	q3
		do
		end

end