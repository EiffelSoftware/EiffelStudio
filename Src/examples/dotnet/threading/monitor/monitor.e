indexing
	description: ""
	
class
	MONITOR_SYNCHRONIZATION

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			 counter: INTEGER
			 dummy : BOOLEAN
		do
			num_operations := 5
			from
				counter := 1
			until
				counter > num_operations
			loop
				dummy := feature {THREAD_POOL}.queue_user_work_item_wait_callback_object (create {WAIT_CALLBACK}.make (Current, $update_resource), counter)
				counter := counter + 1
			end

			dummy := l_async_operations.wait_one
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

	l_async_operations: AUTO_RESET_EVENT is
			-- 
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
			dummy: BOOLEAN
		do
			l_state ?= a_state
			res.access_resource (l_state)
--			num_operations := num_operations - 1
--			if num_operations <= 0 then
--				dummy := l_async_operations.set
--			end
			if feature {INTERLOCKED}.decrement_integer (num_operations) = 0 then
				dummy := l_async_operations.set
			end
		end

end -- class MONITOR_SYNCHRONIZATION
