class TEST

create
	make,
	make_exception

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			t: separate TEST
			is_retried: BOOLEAN
		do
			if is_retried then
				io.put_string ("OK")
			else
					-- Raise an exception in a separate creation procedure.
				create t.make_exception
					-- Access the object that failed to complete its creation.
					-- This should trigger an exception in the caller as soon as the call is a query.
				separate t as s do
					io.put_integer (s.item)
				end
			end
			io.put_new_line
		rescue
			is_retried := True
			retry
		end

	make_exception
			-- Initialize object.
		do
			check False then end
		end

feature -- Access

	item: INTEGER
			-- Value.

end