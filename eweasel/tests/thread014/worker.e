class WORKER
inherit
	THREAD
create
	make

feature {NONE} -- Initialization

	make (a_cond_variable: CONDITION_VARIABLE; a_mutex: MUTEX; a_thread: THREAD; a_data: CELL [BOOLEAN])
		do
			condition_variable := a_cond_variable
			mutex := a_mutex
			thread := a_thread
			shared_data := a_data
		end

feature -- Execution

	execute is
		do
			mutex.lock
			from
			until
				shared_data.item
			loop
				condition_variable.wait (mutex)
			end
			mutex.unlock

			thread.launch
			if thread.is_last_launch_successful then
				print ("I'm here%N")
			end
		end

feature {NONE} -- Implementation

	condition_variable: CONDITION_VARIABLE
	mutex: MUTEX
	thread: THREAD
	shared_data: CELL [BOOLEAN]

end
