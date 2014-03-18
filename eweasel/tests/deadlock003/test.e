class
	TEST

create
	make,
	make_with_peer

feature {NONE} -- Creation

	make
			-- Run test.
			-- Try to get a deadlock.
		do
			run (create {separate TEST}.make_with_peer (Current))
		end

	make_with_peer (other: separate TEST)
			-- Set `peer' to `other'.
		do
			peer := other
		ensure
			peer = other
		end

feature -- Access

	peer: detachable separate TEST
			-- An object used to create a cyclic structure.

feature -- Test

	run (x: separate TEST)
			-- Make a a synchronous call on `x'.
		do
				-- Make a a synchronous call on `x'.
			x.query.do_nothing
		end

	query: INTEGER
			-- Make a call on `peer' passing `Current' as an argument.
		do
			if attached peer as z then
				sync (z)
			end
		end

	sync (other: separate TEST)
			-- Make a call on `other' passing `Current' as an argument.
		do
			other.wait (Current)
		end

	wait (other: separate TEST)
			-- Make a synchronous call on `other'.
		do
			other.out.do_nothing
		end

end
