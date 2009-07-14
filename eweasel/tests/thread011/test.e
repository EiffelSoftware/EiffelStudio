
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXECUTION_ENVIRONMENT
	MEMORY

create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count, iterations: INTEGER
			main_sleep, worker_sleep: INTEGER_64
			worker: WORKER
		do
			count := args.item (1).to_integer
			iterations := args.item (2).to_integer
			main_sleep := args.item (3).to_integer_64
			worker_sleep := args.item (4).to_integer_64
			from
				k := 1
			until
				k > count
			loop
				create worker.make (iterations, worker_sleep)
				worker.launch
				k := k + 1
			end
			sleep (main_sleep)
		end

end
