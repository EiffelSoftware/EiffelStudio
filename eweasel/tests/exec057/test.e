
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
			k, count: INTEGER
		do
			count := args.item (1).to_integer ;
			create weasel.make_filled (wimp, 1, count);
			from
				k := weasel.lower;
			until
				k > weasel.upper
			loop
				-- io.putint (k); io.new_line;
				weasel.put (wimp, k);
				k := k + 1;
			end
		end;

	weasel: ARRAY [TEST1];

	wimp: TEST1;

end
