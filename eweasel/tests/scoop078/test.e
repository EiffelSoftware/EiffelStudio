class TEST

create
	make,
	make_initialized

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			t: separate TEST
		do
				-- Initialize current object.
			make_initialized
				-- Create a new object where by default the class invariant is violated,
				-- but it should not be checked.
			create t.make_initialized
				-- Report result of initialization.
			separate t as s do
				io.put_boolean (s.is_initialized)
			end
			io.put_new_line
		end

	make_initialized
			-- Initialize object.
		do
			is_initialized := True
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Is current object initialized?

invariant

	is_initialized

end