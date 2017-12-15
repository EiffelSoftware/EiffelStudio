class B

feature {NONE} -- Tests

	a1: detachable TEST

	a2: detachable TEST
		attribute
		end

	a3: detachable TEST

	a4: detachable TEST
		attribute
		end

	c1: INTEGER_8 = 1

	c2: INTEGER_8 = 2

	e1
		external "C inline"
			alias "return"
		end

	e2
		external "C inline"
			alias "return"
		end

	i1
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	i2
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	o1
		once ("OBJECT")
		end

	o2
		once ("OBJECT")
		end

	p1
		do
		end

	p2
		do
		end

	q1
		do
		ensure
			is_class: class
		end

	q2
		do
		ensure
			is_class: class
		end

end