
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
		do
			count := args.item (1).to_integer
			create x.make (count)
			from
				k := 1
			until
				k > count
			loop
				x.extend (create {TEST2})
				x.finish
				k := k + 1
			end
			from
				k := 1
			until
				k > count
			loop
				io.put_double (x.i_th (k).value); io.new_line
				k := k + 1
			end
		end;

	x: ARRAYED_LIST [TEST2]
	
end
