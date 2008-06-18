
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
			info: MEM_INFO
		do
			iterations := args.item (1).to_integer
			create info.make (Total_memory)
			from
				n := 1
			until
				n > iterations
			loop
				create worker.make
				worker.launch
				join_all
				full_collect
				info.update (Total_memory)
				n := n + 1
			end
		end;

end

