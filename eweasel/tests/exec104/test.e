
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
create
	make
feature
	make (args: ARRAY [STRING])
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

	try
		local
			x: TEST1;
		do 
			create x.make;
		end

end
