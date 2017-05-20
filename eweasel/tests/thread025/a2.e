class A

inherit

	THREAD
		rename
			terminated as thread_terminated
		end

create

	make

feature {NONE} -- Execution

	terminated: INTEGER
			-- Test attribute.

	execute
			-- <Precursor>
		do
			print ("Execute thread (start)%N")
			terminated := 0xFFFFFFFF
				-- Wait 10 seconds to let main thread run.
			;(create {EXECUTION_ENVIRONMENT}).sleep (10_000_000_000)
			print ("Execute thread (done)%N")
		end

end
