deferred class B

feature {NONE} -- Tests

	o1
		once ("OBJECT")
		end

	o2
		once ("OBJECT")
		end

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

	p1
		do
		end

	p2
		do
		end

	p3
		deferred
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

	q3
		deferred
		ensure
			is_class: class
		end

end