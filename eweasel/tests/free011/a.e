deferred class A

feature {NONE} -- Tests

	e1
		external "C inline"
			alias "return"
		end

	e2
		external "C inline"
			alias "return"
		end

	e3
		deferred
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
		deferred
		end

	j1
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	j2
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	j3
		deferred
		ensure
			is_class: class
		end

	k1
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	k2
		external "C inline"
			alias "return"
		ensure
			is_class: class
		end

	k3
		deferred
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
		end

	q2
		do
		end

	q3
		deferred
		end

	r1
		do
		ensure
			is_class: class
		end

	r2
		do
		ensure
			is_class: class
		end

	r3
		deferred
		ensure
			is_class: class
		end

	s1
		do
		ensure
			is_class: class
		end

	s2
		do
		ensure
			is_class: class
		end

	s3
		deferred
		ensure
			is_class: class
		end

end