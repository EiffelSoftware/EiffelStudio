class TEST
inherit
	EXECUTION_ENVIRONMENT
	MEMORY

create
	make

feature

	make
		local
			worker: WORKER_THREAD
		do
			create worker.make (agent do_something)
			worker.launch
				-- Wait 1s before exiting
			sleep (1_000_000_000)
		end

	do_something
		local
			mutex: MUTEX
			condition: CONDITION_VARIABLE
		do
			create mutex.make
			create condition.make
			mutex.lock
			condition.wait (mutex)
			mutex.unlock
		end

end
