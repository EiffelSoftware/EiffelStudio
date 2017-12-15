class TEST

inherit
	A
		undefine
			e1, i1, j1, k1, p1, q1, r1, s1
		redefine
			e2, i2, j2, k2, p2, q2, r2, s2
		end

	B
		undefine
			i1, k1, q1, s1
		redefine
			i2, k2, q2, s2
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

	j1
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	j2
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	j3
		external "C inline"
			alias "return"
		ensure then
			is_class: class
		end

	k1
		external "C inline"
			alias "return"
		end

	k2
		external "C inline"
			alias "return"
		end

	k3
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

	r1
		do
		ensure then
			is_class: class
		end

	r2
		do
		ensure then
			is_class: class
		end

	r3
		do
		ensure then
			is_class: class
		end

	s1
		do
		end

	s2
		do
		end

	s3
		do
		end

end