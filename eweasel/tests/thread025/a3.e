class A

inherit

	THREAD
		rename
			terminated as thread_terminated
		end

create

	make

feature

	terminated: INTEGER
			-- Test attribute.

	execute
			-- <Precursor>
		do
			print ("Execute thread (start)%N")
				-- Wait 5 seconds to let main thread run.
			;(create {EXECUTION_ENVIRONMENT}).sleep (5_000_000_000)
			print ("Execute thread (done)%N")
		end

end
