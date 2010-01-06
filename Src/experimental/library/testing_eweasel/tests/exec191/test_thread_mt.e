deferred class TEST_THREAD

feature

	execute is
		deferred
		end

	join_all is
		local
			control: THREAD_CONTROL
		do
			create control
			control.join_all
		end

	launch is
		local
			worker_thread: WORKER_THREAD
		do
			create worker_thread.make (agent execute)
			worker_thread.launch
		end

end
