
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
			p: ARRAY [POINTER];
			k, count: INTEGER;
		do
			count := args.item (1).to_integer ;
			create p.make_filled (default_pointer, 1, count);
			from
				k := 1;
			until
				k > count
			loop
				p.put ($make, k)
				k := k + 1;
			end
		end;

end
