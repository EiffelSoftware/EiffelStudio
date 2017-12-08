deferred class A

feature {NONE} -- Tests

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

	p3
		deferred
		ensure
			is_class: class
		end

end