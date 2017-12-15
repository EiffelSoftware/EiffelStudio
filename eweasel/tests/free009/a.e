deferred class A

feature {NONE} -- Tests

	a1: detachable TEST
		do
		ensure
			is_class: class
		end

	a2: detachable TEST
		do
		ensure
			is_class: class
		end

	a3: detachable TEST
		deferred
		ensure
			is_class: class
		end

	a4: detachable TEST
		deferred
		ensure
			is_class: class
		end

	c1: INTEGER_8
		do
		ensure
			is_class: class
		end

	c2: INTEGER_8
		deferred
		ensure
			is_class: class
		end

	e1
		do
		ensure
			is_class: class
		end

	e2
		deferred
		ensure
			is_class: class
		end

	i1
		do
		ensure
			is_class: class
		end

	i2
		deferred
		ensure
			is_class: class
		end

	o1
		do
		ensure
			is_class: class
		end

	o2
		deferred
		ensure
			is_class: class
		end

	p1
		do
		ensure
			is_class: class
		end

	p2
		deferred
		ensure
			is_class: class
		end

	q1
		do
		ensure
			is_class: class
		end

	q2
		deferred
		ensure
			is_class: class
		end

end