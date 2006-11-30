
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
			k, limit: INTEGER;
		do
			--| Note: must set EIF_GS_LIMIT environment
			--| variable to 5000 or other large number before
			--| executing system
			limit :=  args.item (1).to_integer;
			from
				k := 1;
			until
				k > limit
			loop
				create s.make (k);
				k := k + 1;
			end
		end;

	s: STRING
	
end
