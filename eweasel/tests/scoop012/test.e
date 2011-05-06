class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
        		-- Run test.
		local
			is_retried: BOOLEAN
		do
			if is_retried then
				io.put_string ("Failed")
				io.put_new_line
			else
				f (create {separate TEST})
			end
		rescue
			is_retried := True
			retry
		end

feature -- Access

	is_ok: BOOLEAN
			-- False on the first call, True afterwards.
		do
			Result := is_ok_called
			is_ok_called := True
		end

	is_ok_called: BOOLEAN
			-- Has `is_ok' been called?

	is_ready: BOOLEAN = True
			-- Is object ready for a call?

	f (a: separate TEST)
			-- Wait until `a.is_ready'.
		require
			is_ok and a.is_ready
		do
			io.put_string ("OK")
			io.put_new_line
		end

end
