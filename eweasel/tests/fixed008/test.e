
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
inherit
	MEMORY;
create
	make
feature
	
	Init_size: INTEGER = 1048576;
			-- Initial size of string

	Size_incr: INTEGER = 1048576;
			-- Amount to increment size by

	Try_msg: STRING = "Trying size ";

	make
		local
			s: STRING;
			k, size: INTEGER;
		do
			io.putstring("Hi%N");
			from
				k := 1;
				size := Init_size;
			until
				k > 20
			loop
				io.putstring(Try_msg);
				io.putint(size); io.new_line ;
				create s.make(size);
				s.fill_blank;
				s.wipe_out;
				s := Void;
				size := size + Size_incr;
				k := k + 1;
			end
		end;
end
