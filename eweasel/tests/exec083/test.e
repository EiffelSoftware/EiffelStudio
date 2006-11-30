
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
	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER;
		do
			collection_off;
			a := 11111111111111111111111111111111B;
			count := args.item (1).to_integer;
			from
				k := 1;
			until
				k > count
			loop
				b := a.deep_twin
				k := k + 1;
			end
		end;

	a: BIT 32;
	
	b: BIT 32;
end
