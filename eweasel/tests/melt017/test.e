
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
			child: CHILD;
			k, count: INTEGER;
		do
			count := args.item (1).to_integer;
			from 
				create child.make;
				k := 1;
			until
				k > count
			loop
				child.weasel;
				k := k + 1;
			end
		end

end
