class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			a := b
			create c.make
			a := d
				-- VEVI for `e'
		end

feature {NONE} -- Tests

	a: TEST

	b: TEST
		attribute
			Result := c -- VEVI for `c'
		end

	c: TEST

	d: TEST
		attribute
			create e.make
			Result := e
		end

	e: TEST

end