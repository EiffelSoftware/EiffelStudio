
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
			k, count, interval: INTEGER
			a: ARRAY [ANY];
		do
			from
				k := 1;
				count := args.item (1).to_integer;
				interval := args.item (2).to_integer;
			until
				k > count
			loop
				if k \\ interval = 0 then
					io.putint (k); io.new_line;
				end
				a := strip ();
				k := k + 1;
			end
		end
	
	w: INTEGER;
	x: INTEGER;
	y: INTEGER;
	z: INTEGER;
end
