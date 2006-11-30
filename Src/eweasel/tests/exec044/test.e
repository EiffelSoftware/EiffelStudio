
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
			k: INTEGER
			z: ARRAYED_LIST [TEST1];
			w: TEST1;
		do
			io.putstring ("Starting%N");
			!!z.make (0);
			from
				k := 1
			until
				k > args.item (1).to_integer
			loop
				z.extend (w);
				k := k + 1;
			end
			io.putstring ("Done%N");
		end

end
