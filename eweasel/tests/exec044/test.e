
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make (args: ARRAY [STRING])
		local
			k: INTEGER
			z: ARRAYED_LIST [TEST1];
			w: TEST1;
		do
			io.putstring ("Starting%N") ;
			create z.make (0);
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
