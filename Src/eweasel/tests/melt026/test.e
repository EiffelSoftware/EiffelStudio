
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
		do
			try (args);
		end;

	try (args: ARRAY [STRING]) is
		local
			k, count: INTEGER
		do
			count := args.item (1).to_integer;
			from
				k := 1
			until
				k > count
			loop
				$ASSIGNMENT
				k := k + 1;
			end
		end;

	wuss: ARRAY [TEST1];
	
	$ARRAY

	$ELEMENT

end
