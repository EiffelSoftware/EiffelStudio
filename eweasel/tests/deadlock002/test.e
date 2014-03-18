class
	TEST

inherit
	EXECUTION_ENVIRONMENT

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
			-- Make two calls on `x' so that the first one causes `x' to wait for current processor and the second one waits for `x'.
		do
				-- Make an asynchronous call on `x' that tries to access current processor.
			x.sync
				-- Ensure a call on `x' has a chance to start.
			sleep (1_000_000_000)
				-- Make a a synchronous call on `x'.
			x.out.do_nothing
		end

	sync
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
