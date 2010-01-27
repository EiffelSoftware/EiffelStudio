
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	THREAD_CONTROL
	MEMORY
	MEM_CONST
create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			n, iterations: INTEGER
			worker: WORKER
			cv: CONDITION_VARIABLE
			mu: MUTEX
			d: CELL [BOOLEAN]
			thread: WORKER_THREAD
		do
			iterations := args.item (1).to_integer
			create thread.make (agent (create {EXECUTION_ENVIRONMENT}).sleep (5_000_000_000))
			create cv.make
			create mu.make
			create d.put (False)
			from
				n := 1
			until
				n > iterations
			loop
				create worker.make (cv, mu, thread, d)
				worker.launch
				n := n + 1
			end
			mu.lock
			d.put (True)
			mu.unlock
			cv.broadcast
			join_all
		end;

end

