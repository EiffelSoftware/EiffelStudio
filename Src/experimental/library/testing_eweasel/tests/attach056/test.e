class
	TEST

inherit
	A
		redefine
			a, b, c, d
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
		end

feature {NONE} -- Tests

	a: detachable A
		note
			option: stable
		attribute
		end

	b: detachable A
		note
			option: stable
		attribute
		end

	c: detachable A
		attribute
		end

	d: detachable A
		attribute
		end

end