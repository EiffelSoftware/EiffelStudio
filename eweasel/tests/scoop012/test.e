class TEST

create
	make, make_with_current, make_with_waiting_instance

feature {NONE} -- Creation

        make
        		-- Run test.
		local
			is_retried: BOOLEAN
        		t: separate TEST
		do
			if is_retried then
				waiting_instance := Current
				io.put_string ("Failed")
				io.put_new_line
			else
				create waiting_instance.make_with_current
					-- This processor or the one created next are going to change the state of `waiting_instance'
					-- so that `is_valid' becomes true and `f (waiting_instance)' can proceed.
				create t.make_with_waiting_instance (waiting_instance)
				make_valid (t)
				make_valid (Current)
			end
		rescue
			is_retried := True
			retry
		end

	make_with_current
			-- Initialize an object with `waiting_instance' pointing to `Current'.
		do
			waiting_instance := Current
		ensure
			waiting_instance = Current
		end

	make_with_waiting_instance (w: separate TEST)
			-- Initialize an object with `w'.
		do
			waiting_instance := w
		ensure
			waiting_instance = w
		end

feature -- Test

        make_valid (client: separate TEST)
        		-- Call `f' on `client' with `waiting_instance'.
		do
			client.f (waiting_instance)
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

	waiting_instance: separate TEST
			-- An instance to wait on until it becomes valid.

end
