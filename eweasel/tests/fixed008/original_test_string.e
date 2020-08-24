
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	ORIGINAL_TEST_STRING
inherit
	MEMORY;
create
	make
feature
	
	-- Init_size: INTEGER is 1048576; -- 1 Megabyte
	Init_size: INTEGER = 32740;
	-- Init_size: INTEGER is 65400;
			-- Initial size of string

	-- Size_incr: INTEGER is 1048576;
	Size_incr: INTEGER = 32740;
	-- Size_incr: INTEGER is 100;
			-- Amount to increment size by

	Try_msg: STRING = "Trying size ";

	make
		local
			s: STRING;
			k, size: INTEGER;
		do
			from
				k := 1;
				size := Init_size;
			until
				false
			loop
				io.putstring(Try_msg);
				io.putint(size); io.new_line ;
				create s.make(size);
				s.fill_blank;
				s.clear;
				s := Void;
				size := size + Size_incr;
				k := k + 1;
			end
		end;

end
