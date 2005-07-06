indexing
	description: "Monitor example root class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	MONITOR_SYNCHRONIZATION

inherit
	SYSTEM_OBJECT

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			-- Main entry point.
		local
			 counter: INTEGER
			 return: BOOLEAN
			 l_res: RESOURCE
		do
				-- Initialize `res' before executing any thread, otherwise there might
				-- be a race condition.
			l_res := res
			num_operations := 5
			from
				counter := 1
			until
				counter > num_operations
			loop
				return := {THREAD_POOL}.queue_user_work_item (
					create {WAIT_CALLBACK}.make (Current, $update_resource), counter)
				counter := counter + 1
			end

			return := async_operations.wait_one
			io.put_new_line
			io.put_string ("All operations have completed.")
		end

feature -- Access

	res: RESOURCE is
			-- resource
		once
			create Result
		ensure
			non_void_result: Result /= Void
		end
		
	num_operations: INTEGER
			-- number of access to the resource.

	async_operations: AUTO_RESET_EVENT is
			-- Notifies a waiting thread that an event has occurred
		once
			create Result.make (False)
		ensure
			non_void_result: Result /= Void
		end

feature -- Basic Operation

	update_resource (a_state: SYSTEM_OBJECT) is
			-- The callback method's signature MUST match that of a TIMER_CALLBACK 
			-- delegate (it takes an SYSTEM_OBJECT parameter and returns void)
		local
			l_state: INTEGER
			return: BOOLEAN
		do
			l_state ?= a_state
			res.access_resource (l_state)
			if {INTERLOCKED}.decrement ($num_operations) <= 0 then
				return := async_operations.set
			end
		end

end -- class MONITOR_SYNCHRONIZATION
