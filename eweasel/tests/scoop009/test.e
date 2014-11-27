class TEST

create
	make, make_with_current, make_with_waiting_instance

feature {NONE} -- Creation

        make
        	local
        		t: separate TEST
		do
			create waiting_instance.make_with_current
				-- This processor or the one created next are going to change the state of `waiting_instance'
				-- so that `is_valid' becomes true and `f (waiting_instance)' can proceed.
			create t.make_with_waiting_instance (waiting_instance)
			make_valid (t)
			make_valid (Current)
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

	f (t: separate TEST)
			-- Wait until `t' becomes valid and print `t.count'.
		require
			t.is_valid
		do
				-- This should print "4" because `is_valid' becomes true
				-- when `t.count >= 4', and then "5" for the second call.
			io.put_integer (t.count)
			io.put_string (" OK")
			io.put_new_line
		end

	is_valid: BOOLEAN
			-- Is this feature called more than 1 time?
		do
			count := count + 1
			io.put_integer (count)
			io.put_new_line
			Result := count >= 4
		end

	count: INTEGER
			-- Number of times `is_valid' is called.

	waiting_instance: separate TEST
			-- An instance to wait on until it becomes valid.

end
