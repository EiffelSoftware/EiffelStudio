class
	ROOT_CLASS

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		local
			l_worker: separate PROCESS_WORKER
		do
			create {TEST2 [ANY]} t_any.make ("content")
			create {TEST2 [INTEGER]} t_integer.make ({INTEGER_32}.min_value)
			create l_worker.make (Current)
			run_process (l_worker)
		end

	run_process (a_worker: separate PROCESS_WORKER)
			-- Run process
		do
			a_worker.run
		end

feature -- Access

	t_any: TEST1 [ANY]
	t_integer: TEST1 [INTEGER]

end
