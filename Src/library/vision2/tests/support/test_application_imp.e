note
	description: "Summary description for {TEST_APPLICATION_IMP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_APPLICATION_IMP

inherit
	EV_APPLICATION_IMP
		redefine
			process_event_queue,
			call_post_launch_actions
		end

create
	make

feature -- Access

	call_post_launch_actions
			-- Call the post launch actions.
			-- (from EV_APPLICATION_I)
		do
			post_launch_actions.call (Void)
		end

	process_event_queue (a_relinquish_cpu: BOOLEAN)
			-- Process all posted events on the event queue.
			-- CPU will be relinquished if `a_relinquish_cpu' and idle actions are successfully executed.
		local
			l_locked: BOOLEAN
		do
			process_underlying_toolkit_event_queue
				-- There are no more events left so call idle actions if read lock can be attained.
			if user_events_processed_from_underlying_toolkit then
					-- If any user events have been processed then we reset the `idle_iteration_count'
				idle_iteration_count := 1
			elseif a_relinquish_cpu then
					-- We only want to increase the count if the event loop is not forced.
				idle_iteration_count := idle_iteration_count + 1
				if idle_iteration_count = idle_iteration_boundary then
						-- We have reached a fully idle/inactive state.
					if invoke_garbage_collection_when_inactive then
						full_collect
						full_coalesce
					end
					idle_iteration_count := 1
				end
			else
				idle_iteration_count := 1
					-- Reset idle iteration counter if CPU is not relinquished.
			end
			if try_lock then
				l_locked := True
				idle_actions.call (Void)
				unlock
				l_locked := False
				if a_relinquish_cpu then
						-- We only relinquish CPU if requested and a lock for the idle actions has been attained.
					wait_for_input (cpu_relinquishment_time)
				end
			end
		rescue
			io.put_boolean (True)
		end

end
