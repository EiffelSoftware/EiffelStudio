note
	description: "Condition application root class."
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
			i: INTEGER
			var: separate VAR
			worker: separate COND_WORKER
			prod_workers, cons_workers: LINKED_LIST [separate COND_WORKER]
			max: INTEGER
		do
			create var
			create prod_workers.make
			create cons_workers.make
			max := argument (1).to_integer_32
			max_workers := argument (2).to_integer_32

				-- Make equal numbers of "producers" and "consumers, storing each
				-- in a separate list. Depending on what they are intended for,
				-- they are asynchronously run using different procedure calls.
			from
				i := 1
			until
				i > max_workers
			loop
				print ("Creating producer " + i.out + "%N")
				create worker.make (var, max)
				prod_workers.extend (worker)
					-- run_prod (worker)

				print ("Creating consumer " + i.out + "%N")
				create worker.make (var, max)
				cons_workers.extend (worker)
					-- run_cons (worker)

				i := i + 1
			end
			from
				i := 1
			until
				i > max_workers
			loop
				run_prod (prod_workers [i])
				run_cons (cons_workers [i])
				i := i + 1
			end

				-- Wait for them all to finish.
			from
				i := 1
			until
				i > max_workers
			loop
				wait (prod_workers [i])
				wait (cons_workers [i])
				i := i + 1
			end
			prod_workers := Void
		end

	run_prod (worker: separate COND_WORKER)
		do
			worker.produce
		end

	run_cons (worker: separate COND_WORKER)
		do
			worker.consume
		end

	wait (worker: separate COND_WORKER)
		require
			worker.is_done
		do
		end

end
