
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	THREAD_CONTROL
create
	make

feature

	make (args: ARRAY [STRING])
		local
			k, count: INTEGER
			worker: WORKER
		do
			from
				k := 1;
				count := args.item (1).to_integer
			until
				k > count
			loop
				create worker.make
				worker.launch
				k := k + 1;
			end
			join_all
		end;

end
