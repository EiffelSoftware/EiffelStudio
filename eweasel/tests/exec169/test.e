
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	THREAD_CONTROL
	MEMORY
creation
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
			worker: WORKER
		do
			create mem.make (Eiffel_memory)
			from
				k := 1;
				count := args.item (1).to_integer
			until
				k > count
			loop
				create worker
				worker.launch
				join_all
				mem.update (Total_memory);
				check_memory (mem);
				k := k + 1;
			end
		end;

	mem: MEM_INFO;
	already_displayed: BOOLEAN

	check_memory (m: MEM_INFO) is
		do
			if m.total > 50_000_000 and not already_displayed then
				already_displayed := True
				display_memory (m);
			end
		end
	
	display_memory (m: MEM_INFO) is
		do
			io.putint (m.type);
			io.putchar ('%T');
			io.putint (m.used);
			io.putchar ('%T');
			io.putint (m.free);
			io.putchar ('%T');
			io.putint (m.overhead);
			io.putchar ('%T');
			io.putint (m.total);
			io.new_line;
		end
end

