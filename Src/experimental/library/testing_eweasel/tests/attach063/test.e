class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			x: attached TEST
		do
			a := Current
			a := Void
			g (a)
			a.g (a)
			x := a
		end

feature {TEST} -- Tests

	a: detachable TEST
		note
			option: stable
		attribute
		end

	g (x: attached TEST)
		do
		end

end