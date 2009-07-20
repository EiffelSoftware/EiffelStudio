note
	description: "{POOLED_THREAD} is used in combination with {THREAD_POOL} to allow for pooled threads."
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	POOLED_THREAD [G]

inherit
	THREAD

create {THREAD_POOL}
	make

feature {NONE} -- Initialization

	make (a_thread_pool: THREAD_POOL [G]; a_semaphore: SEMAPHORE)
			-- `a_thread_pool', the pool in which this thread is managed
			-- `a_semaphore' is used for execution suspending
		do
			thread_pool := a_thread_pool
			semaphore := a_semaphore
		end

feature {NONE} -- Access

	thread_pool: THREAD_POOL [G]
			-- Pool manager in which this thread is pooled

	target: detachable G
			-- Target on which the `thread_procedure' should be applied
			-- Depending on which launch is used, target is not used

	thread_procedure: detachable PROCEDURE [G, TUPLE]
			-- Work that should be executed by the thread

	semaphore: SEMAPHORE
			-- Semaphore share with all threads in a thread pool
			-- to suspend execution until more work is available

feature -- Access

	set_target (a_target: G)
			-- Sets the target on which the work should be executed
		do
			target := a_target
		end

feature {NONE} -- Implementation

	execute
			-- <Precursor>
		local
			done: BOOLEAN
		do
			from
				semaphore.wait
				thread_procedure := thread_pool.get_work (Current)
			until
				done
			loop
				if attached thread_procedure as l_work then
					if attached {G} target as l_target then
						l_work.call ([l_target])
					else
						l_work.call (Void)
					end
				end
				if thread_pool.over then
					done := True
				else
					thread_procedure := thread_pool.get_work (Current)
					if thread_procedure = Void then
						semaphore.wait
						thread_procedure := thread_pool.get_work (Current)
					end
				end
			end
			thread_pool.thread_terminated
		end
end


