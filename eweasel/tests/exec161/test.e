
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
create
	make
feature
	make (args: ARRAY [STRING])
		local
			list: ARRAYED_LIST [STRING];
			k, limit: INTEGER;
			s: STRING
			gc: GC_INFO
		do
			enable_time_accounting
			s := "weasels and ermines and stoats"
			limit := args.item (1).to_integer
			from 
				create list.make_filled (limit)
				k := 1
			until
				k > limit
			loop
				list.put_i_th ("weasels and ermines and stoats", k);
				k := k + 1;
			end;
			gc := gc_statistics (Incremental_collector)
			print (gc.collected < 0); io.new_line
			print (gc.collected_average < 0); io.new_line
		end

end
