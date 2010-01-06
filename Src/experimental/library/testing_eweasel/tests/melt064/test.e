
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
creation
	make
feature
	make is
		local
			list: ARRAYED_LIST [STRING];
			k, max: INTEGER;
			s: STRING
			a: SPECIAL [ANY]
		do
			s := "weasels and ermines and stoats"
			max := 3
			from
				!!list.make_filled (max)
				k := 1
			until
				k > max
			loop
				list.put_i_th (s, k);
				k := k + 1;
			end;
			a := referers (s)
			print (a.count); io.new_line
		end

end
