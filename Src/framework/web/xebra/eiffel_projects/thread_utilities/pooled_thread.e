note
	description: "{POOLED_THREAD} is used in combination with {THREAD_POOL} to allow for pooled threads."
	date: "$Date$"
	revision: "$Revision$"

class
	POOLED_THREAD [G]

inherit
	THREAD

create
	make

feature {NONE} -- Initialization

	make (thread_pool_manager: THREAD_POOL_MANAGER [G])
		do
			create execution_mutex.make
			pool := thread_pool_manager
			stop := False
			already_launched := False
		end

feature {NONE} -- Access

	pool: THREAD_POOL_MANAGER [G]
			-- Pool manager in which this thread is pooled

	execution_mutex: MUTEX
			-- Execution locking for reuse

	target: detachable G
			-- Target on which the `thread_procedure' should be applied
			-- Depending on which launch is used, target is not used

	thread_procedure: detachable PROCEDURE [G, TUPLE]
			-- Work that should be executed by the thread

	stop: BOOLEAN
			-- True: stop thread after next execution

feature -- Access

	already_launched: BOOLEAN
			-- True, as soon as this thread has been launched for the first time

	fetch_data: detachable G
			-- Returns the data that is currently being used.
		do
			Result := target
		end

feature {NONE} -- Implementation

	execute
			-- <Precursor>
		local
			l_work: like thread_procedure
		do
			already_launched := True
			from
			until
				stop
			loop
					-- Wait until the pool launches again (see {POOLED_THREAD}.launch_with_argument)
				execution_mutex.lock
				if not stop then
					l_work := thread_procedure
					if l_work /= Void then
						if attached {G} target as l_target then
							l_work.call ([l_target])
						else
							l_work.call (Void)
						end
					end
					execution_mutex.unlock
					pool.ready (Current)
				end
			end
		end

feature -- Basic operations

	wait
			--Orders the thread to wait for a new launch.
		do
			execution_mutex.lock
		end

	stop_thread
			-- stops the thread
		do
			stop := True
			execution_mutex.unlock
		end

	launch_with_work (work: PROCEDURE [G, TUPLE])
			-- Launches the thread again and resets the argument to `arg'
		do
			thread_procedure := work
			if not already_launched then
				launch
			else
				execution_mutex.unlock
			end
		end

	launch_work_with_data (work: PROCEDURE [G, TUPLE]; work_data: G)
			-- sets the data, on which the work should be executed
		do
			target := work_data
			launch_with_work (work)
		end

end

