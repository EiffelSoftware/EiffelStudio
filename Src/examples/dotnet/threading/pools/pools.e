indexing
	description: "	launch an asynchrone thread %
				%	keep performing its own operations while the thread is also performing operations %
				%	wait that the thread has finished its operations to finish the program execution."

class
	POOLS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point.	%
						% launch an asynchrone thread %
						% keep performing its own operations while the thread is also performing operations %
						% wait that the thread has finished its operations to finish the program execution."
		local
			l_async_operation_done: AUTO_RESET_EVENT
			dummy: BOOLEAN
		do
			io.put_string ("Main thread: Queuing an asynchronous operation.")
			io.put_new_line

			create l_async_operation_done.make (False)
			dummy := feature {THREAD_POOL}.queue_user_work_item_wait_callback_object (create {WAIT_CALLBACK}.make (Current, $my_async_operation), l_async_operation_done)
			
			io.put_string ("Main thread: Performing other operations.")
			io.put_new_line
			-- ...

			io.put_string ("Main thread: Waiting for asynchronous operation to complete.")
			io.put_new_line
			dummy := l_async_operation_done.wait_one
		end


feature -- Basic Operation

	my_async_operation (a_state: SYSTEM_OBJECT) is
			-- The callback method's signature MUST match that of a WAIT_CALLBACK 
			-- delegate (it takes an SYSTEM_OBJECT parameter and returns void)
		local
			l_state: AUTO_RESET_EVENT
			dummy: BOOLEAN
		do
			io.put_string ("WorkItem thread: Performing asynchronous operation.")
			io.put_new_line
			-- ...
			feature {THREAD}.sleep_integer_32 (5000)	-- Sleep for 5 seconds to simulate doing work

			-- Signal that the async operation is now complete.
			l_state ?= a_state
			if l_state /= Void then
				dummy := l_state.set
			end
		end

end -- class POOLS
