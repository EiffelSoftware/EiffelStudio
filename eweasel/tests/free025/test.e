class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			io.put_boolean (f) -- VUCR
		ensure
			instance_free: class
		end

feature {NONE} -- Tests

	f: BOOLEAN
		do
		end

end