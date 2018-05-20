deferred class A

feature {NONE} -- Tests

	a: BOOLEAN
		deferred
		end

	c1: INTEGER_8
		do
			Result := 1
		ensure
			a
		end

	c2: INTEGER_8
		deferred
		ensure
			a
		end

	e1
		do
		ensure
			a
		end

	e2
		deferred
		ensure
			a
		end

end