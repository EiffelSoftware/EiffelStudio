class TEST

create
	make, make_with_id

feature {NONE} -- Creation

	make
		local
			shared_counter: separate TEST
			other: separate TEST
		do
			create shared_counter.make_with_id (3)
			create other.make_with_id (2)
			thread_id.put (1)

				-- This processor or the one created next are going to change the state of `waiting_instance'
				-- so that `is_valid' becomes true and `f (waiting_instance)' can proceed.


				-- In SCOOP, these two calls need to be executed after
				-- incrementing the counter in the current processor!
			separate other as l_other do
				l_other.f (shared_counter)
				l_other.wait_increment (shared_counter)
			end

				-- This would deadlock immediately.
-- 			g (shared_counter)


				-- Increment shared counter such that `other' can proceed.
				-- A bug in wait condition evaluation can be seen if `f'
				-- is being executed before the increments (which contain sleep instructions).
			wait_increment (shared_counter)
			wait_increment (shared_counter)

				-- When `other' has finished executing f and do_increment, the value should be 3 and we can proceed.
			g (shared_counter)
		end

	make_with_id (a_id: INTEGER)
			-- Initialize object and set `thread_id' to `a_id'.
		do
			thread_id.put (2)
		end

feature

	f (t: separate TEST)
			-- Wait until `t.count >= 2', then print a message and increment the counter.
		require
			t.count >= 2
		do
				-- This should print "4" because `is_valid' becomes true
				-- when `t.count >= 4', and then "5" for the second call.
			io.put_integer (thread_id.item)
			io.put_string (": f -> ")
			io.put_integer (t.count)
			io.put_new_line
		end

	g (t: separate TEST)
			-- Wait until `t.count >= 3', then print a message.
		require
			t.count >= 3
		do
			io.put_integer (thread_id.item)
			io.put_string (": g -> ")
			io.put_integer (t.count)
			io.put_new_line
		end

	wait_increment (a_counter: separate TEST)
			-- Wait a second and increment `a_counter'.
		local
			env: EXECUTION_ENVIRONMENT
		do
			create env
			env.sleep (1_000_000_000)
			io.put_integer (thread_id.item)
			io.put_string (": wait -> ")
			a_counter.increment
			io.put_integer (a_counter.count)
			io.put_new_line
		end

	increment
		do
			count := count + 1
		end

	count: INTEGER
			-- Number of times `is_valid' is called.

	thread_id: CELL[INTEGER]
		once
			create Result.put (-1)
		end

end
