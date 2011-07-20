class TEST


create
	make

feature -- Initialization

	make
			-- Run application.
		local
			thr1, thr2: WORKER_THREAD
		do
			create mutex.make
			create thr1.make (agent do from until False loop mutex.lock mutex.unlock end end)
			create thr2.make (agent do from until False loop mutex.lock mutex.unlock end end)

			thr1.launch
			thr2.launch

			;(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_0)
		end

	mutex: MUTEX


end
