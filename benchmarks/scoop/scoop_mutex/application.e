note
	description: "Mutex application root class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	max_workers: INTEGER

	make
		local
			worker: separate MUTEX_WORKER
			workers: LINKED_LIST [separate MUTEX_WORKER]
			shared: separate VAR
			i: INTEGER
			max: INTEGER
		do
			max := argument (1).to_integer_32
			max_workers := argument (2).to_integer_32
			create shared
			create workers.make
			from
				i := 1
			until
				i > max_workers
			loop
				create worker.make (shared, max)
				workers.extend (worker)
				i := i + 1
			end
			run_workers (workers)
			wait_workers (workers)
			print_res (shared)
		end

	print_res (shared: separate VAR)
		do
			print (shared.i)
		end

	run_workers (workers: LIST [separate MUTEX_WORKER])
		do
			across
				workers as wc
			loop
				run (wc.item)
			end
		end

	run (worker: separate MUTEX_WORKER)
		do
			worker.live
		end

	wait_workers (workers: LIST [separate MUTEX_WORKER])
		do
			across
				workers as wc
			loop
				wait (wc.item)
			end
		end

	wait (worker: separate MUTEX_WORKER)
		require
			worker.is_done
		do
		end

end
