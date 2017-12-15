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

end