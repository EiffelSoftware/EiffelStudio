
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
			child: CHILD;
			k, count: INTEGER;
		do
			count := args.item (1).to_integer;
			from
				!!child.make;
				k := 1;
			until
				k > count
			loop
				child.weasel;
				k := k + 1;
			end
		end

end
