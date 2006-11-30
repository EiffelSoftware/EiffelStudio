
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
creation
	make
feature
	make (args: ARRAY [STRING]) is
		local
			k, count, tries: INTEGER;
		do
			count := args.item (1).to_integer;
			if tries < count then
				io.put_string ("Garbage collection on: ");
				io.put_boolean (collecting); io.new_line;
				try;
				full_collect;
			end
		rescue
			tries := tries + 1;
			io.put_string ("Rescue: tries is ");
			io.put_integer (tries); io.new_line;
			retry;
		end;

	try is
		local
			x: TEST1;
		do
			!!x.make;
		end

end
