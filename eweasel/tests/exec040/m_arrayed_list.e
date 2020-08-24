
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class M_ARRAYED_LIST [G]
inherit
	ARRAYED_LIST [G]
create
	make
feature

	process
		do 
			create list.make (count);
			process_range (lower, upper);
		end;

	list: ARRAYED_LIST [G];
	
	process_range (low, high: INTEGER)
		local
			mid: INTEGER;
		do
			if high > low then
				mid := (low + high) // 2;
				process_range (low, mid);
				process_range (mid + 1, high);
				build_list (high - low + 1);
			end
		end;

	build_list (item_count: INTEGER)
		local
			k: INTEGER;
			def: G;
		do
			from
				list.wipe_out;
				k := 1
			until
				k > item_count
			loop
				list.extend (def);
				k := k + 1;
			end
		end;

end
