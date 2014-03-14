class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
			-- Try to get a deadlock.
		local
			a, b: separate TEST
		do
			create a
			create b
			run (a, b)
			run (b, a)
		end

feature -- Access

	peer: detachable separate TEST
			-- An object used to create a cyclic structure.

feature -- Modification

	set (other: separate TEST)
			-- Set `peer' to `other'.
		do
			peer := other
		ensure
			peer = other
		end

feature -- Test

	run (x, y: separate TEST)
			-- Use `y' as a peer of `x' and run `x.execute'.
		do
			x.set (y)
			x.execute
		end

	execute
			-- Try to get deadlock between `Current' and `peer'.
		do
			if attached peer as z then
				use (z)
			end
		end

	use (other: separate TEST)
			-- Try to get deadlock between `Current' and `other' by waiting before makeing a separate call on `other'.
		do
				-- Wait 1 second before trying to make a separate call on `other'.
			sleep (1_000_000_000)
				-- This should be a query to make sure the current processor waits for `other'.
			other.out.do_nothing
		end

end
