
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	THREAD_CONTROL
	MEMORY
create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count, iterations, size: INTEGER
			worker: WORKER
		do
			count := args.item (1).to_integer
			iterations := args.item (2).to_integer
			size := args.item (3).to_integer
			from
				k := 1
			until
				k > count
			loop
				create worker.make (iterations, size)
				worker.launch
				k := k + 1
			end
			join_all
		end

end
