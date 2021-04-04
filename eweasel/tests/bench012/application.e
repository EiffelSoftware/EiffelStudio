class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	num_passes: INTEGER

	make
		local
			worker: separate THREADRING_WORKER
			last_worker: separate THREADRING_WORKER
			first_worker: separate THREADRING_WORKER
			workers: ARRAYED_LIST [separate THREADRING_WORKER]
			i: INTEGER
			n: INTEGER
		do
			num_passes := argument (1).to_integer
			n := argument (2).to_integer
			create workers.make (n-1)

			create first_worker.make (0, Void)
			last_worker := first_worker
			worker := first_worker

			from i := 1
			until i >= n
			loop
				create worker.make (i, last_worker)
				workers.extend (worker)
				last_worker := worker
				i := i + 1
			end

			pass_to_first_worker (first_worker, worker)


			from i := 1
			until i >= n
			loop
				run_worker (workers[i])
				i := i + 1
			end
		end


	run_worker (worker: separate THREADRING_WORKER)
		do
			worker.run
		end

	pass_to_first_worker (first_worker: separate THREADRING_WORKER; worker: detachable separate THREADRING_WORKER)
		do
			print ("running - first%N")
			first_worker.set_next (worker)
			print ("set next - first%N")
			first_worker.pass (num_passes)
			print ("passed - first%N")
		end
end
