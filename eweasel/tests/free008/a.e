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
		do
		ensure
			is_class: class
		end

	a4: detachable TEST
		do
		ensure
			is_class: class
		end

	a5: detachable TEST
		deferred
		ensure
			is_class: class
		end

	a6: detachable TEST
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
		do
		ensure
			is_class: class
		end

	c3: INTEGER_8
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
		do
		ensure
			is_class: class
		end

	e3
		deferred
		ensure
			is_class: class
		end

	f1
		do
		ensure
			is_class: class
		end

	f2
		do
		ensure
			is_class: class
		end

	f3
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
		do
		ensure
			is_class: class
		end

	o3
		deferred
		ensure
			is_class: class
		end

end