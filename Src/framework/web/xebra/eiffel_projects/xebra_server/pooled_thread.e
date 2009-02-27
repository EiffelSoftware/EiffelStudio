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

feature {NONE} -- Access

	pool: THREAD_POOL_MANAGER [G]
	mutex: MUTEX
	already_launched: BOOLEAN
	target: ?G
	thread_procedure: ?PROCEDURE [G, TUPLE]
	stop: BOOLEAN

feature {NONE} -- Initialize

	make (thread_pool_manager: THREAD_POOL_MANAGER [G])
		do
			create mutex.make
			pool := thread_pool_manager
			stop := False
			already_launched := False
		end

feature -- Access

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
				mutex.lock
				l_work := thread_procedure
				if l_work /= Void then
					if {l_target: G} target then
						l_work.call ([l_target])
					else
						l_work.call (Void)
					end
				end
				mutex.unlock
				pool.internal_ready (Current)
			end
		end

	wait
			--Orders the thread to wait for a new launch
		do
			mutex.lock
		end

	stop_thread
			-- stops the thread
		do
			stop := True
		end

	launch_with_work (work: PROCEDURE [G, TUPLE])
			-- Launches the thread again and resets the argument to `arg'
		do
			thread_procedure := work
			if not already_launched then
				launch
			else
				mutex.unlock
			end
		end

	launch_work_with_data (work: PROCEDURE [G, TUPLE]; work_data: G)
			-- sets the data, on which the work should be executed
		do
			target := work_data
			launch_with_work (work)
		end

	fetch_data: ?G
			-- Returns the data that is currently being used.
		do
			Result := target
		end

end

