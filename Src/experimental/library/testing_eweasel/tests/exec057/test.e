
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
			count := args.item (1).to_integer;
			!!weasel.make (1, count);
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
