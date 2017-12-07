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

end