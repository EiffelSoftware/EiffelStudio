indexing
	description: "[
					Launch an asynchrone thread %
					keep performing its own operations while the thread is also performing operations
					wait that the thread has finished its operations to finish the program execution.
					]"
	date: "$Date$"
	revision: "$Revision: "

class
	POOLS

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point
		local
			l_async_operation_done: AUTO_RESET_EVENT
			return: BOOLEAN
		do
			io.put_string ("Main thread: Queuing an asynchronous operation.%N")

			create l_async_operation_done.make (False)
			return := feature {THREAD_POOL}.queue_user_work_item (create {WAIT_CALLBACK}.make (Current, $async_operation), l_async_operation_done)
			
			io.put_string ("Main thread: Performing other operations.%N")
			-- ...

			io.put_string ("Main thread: Waiting for asynchronous operation to complete.%N")

			return := l_async_operation_done.wait_one

			io.put_string ("Done.")
			io.read_line
		end


feature -- Basic Operation

	async_operation (a_state: SYSTEM_OBJECT) is
			-- The callback method's signature MUST match that of a WAIT_CALLBACK 
			-- delegate (it takes an SYSTEM_OBJECT parameter and returns void)
		local
			l_state: AUTO_RESET_EVENT
			return: BOOLEAN
		do
			io.put_string ("WorkItem thread: Performing asynchronous operation.%N")
			-- ...

			feature {SYSTEM_THREAD}.sleep_integer (5000) -- Sleep for 5 seconds to simulate doing work

			-- Signal that the async operation is now complete.
			l_state ?= a_state
			if l_state /= Void then
				return := l_state.set
			end
		end

end -- class POOLS
