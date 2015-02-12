note
	description: "Test if a precondition whose target involves an already controlled object is correctly treated as a correctness condition."

class
	TEST

create
	make, default_create

feature

	make
			-- Run the test.
		local
			target: separate TEST
			retry_count: INTEGER
		do
			if retry_count = 0 then
					-- BUG: This branch deadlocks when code is molten,
					-- but works correct when frozen.
				create target
				invoke_with_controlled_separate (target, Current)
				print ("ERROR: No precondition violation occurred.%N")
			elseif retry_count = 1 then
					-- BUG: This branch deadlocks both when molten and frozen.
				create target
				invoke_with_local (target)
				print ("ERROR: No precondition violation occurred.%N")
			else
				print ("OK: Done.%N")
			end
		rescue
			print("OK: In Rescue of {A}.make.%N")
			retry_count := retry_count + 1
			retry
		end

	invoke_with_controlled_separate (target, arg: separate TEST)
			-- Call `wait_infinitely' with `arg' on `target'.
		do
				-- Pass locks for `arg'.
			target.wait_infinitely (arg)
		end

	invoke_with_local (target: separate TEST)
			-- Call `wait_infinitely' on `target' with a non-separate argument.
		do
				-- Pass locks for the Current object.
			target.wait_infinitely (Current)
		end

	wait_infinitely (arg: separate TEST)
			-- Wait infinitely.
			-- This should trigger a precondition violation if `arg' is already
			-- controlled before wait_infinitely is called (e.g. by lock passing).
		require
			arg.always_false
		do
			print ("ERROR: In wait_infinitely.%N")
		end

	always_false: BOOLEAN
			-- Return false.
		do
			Result := False
		end

end
