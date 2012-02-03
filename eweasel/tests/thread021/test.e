class TEST

inherit
	EXCEPTIONS

create
	make

feature
	make
		local
			l_crash_thread: WORKER_THREAD
			l_worker_thread: WORKER_THREAD
			i: INTEGER
		do
			create mutex.make
			create exec
			create l_crash_thread.make (agent crash)
			l_crash_thread.launch
			from
				i := 1
			until
				i = 50
			loop
				create l_worker_thread.make (agent execute)
				l_worker_thread.launch
				i := i + 1
			end
			l_crash_thread.join
		end

	exec: EXECUTION_ENVIRONMENT
	counter: INTEGER
	mutex: MUTEX

	execute
		local
			i: INTEGER
			l_mem: MEMORY
		do
			mutex.lock
			counter := counter + 1
			mutex.unlock
			create l_mem
			from
				i := 1
			until
				i = 10_000
			loop
				l_mem.collect
				i := i + 1
			end
		end

	crash
		local
			l_counter: INTEGER
		do
			from
			until
				l_counter >= 10
			loop
				exec.sleep (1_000_000_000)
				mutex.lock
				l_counter := counter
				mutex.unlock
			end
			die (1)
		end

end
