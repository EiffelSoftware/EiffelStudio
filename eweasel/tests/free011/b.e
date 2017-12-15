deferred class B

feature {NONE} -- Tests

	i1
		do
		ensure
			is_class: class
		end

	i2
		do
		ensure
			is_class: class
		end

	i3
		deferred
		ensure
			is_class: class
		end

	k1
		do
		ensure
			is_class: class
		end

	k2
		do
		ensure
			is_class: class
		end

	k3
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
		do
		ensure
			is_class: class
		end

	q3
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