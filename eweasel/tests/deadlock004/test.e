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
			-- Make a a synchronous call on `x', passing `Current' to a third separate object.
		do
			x.sync (Current, create {separate TEST}.make_with_peer (Current))
		end

	sync (x, y: separate TEST)
			-- Make a synchronous call on `y' that is going to wait for its `peer'.
		do
			y.query.do_nothing
		end

	query: INTEGER
			-- Make a synchronous call on `peer'.
		do
			if attached peer as z then
				wait (z)
			end
		end

	wait (other: separate TEST)
			-- Make a synchronous call on `other'.
		do
			other.out.do_nothing
		end

end
