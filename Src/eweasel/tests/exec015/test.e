
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Execute `test'.
	-- Does not read long lines correctly.

class TEST
inherit
	ARGUMENTS
creation
	make
feature
	
	make is
		local
			fname: STRING;
			f: PLAIN_TEXT_FILE;
			k: INTEGER;
		do
			fname := argument (1);
			from
				!!f.make_open_read (fname);
			until
				f.end_of_file
			loop
				f.readline;
				if not f.end_of_file then
					k := k + 1;
					io.putstring ("Line ");
					io.putint (k);
					io.putstring (" (length = ");
					io.putint (f.laststring.count);
					io.putstring ("): ");
					io.putstring (f.laststring); io.new_line;
				end
			end;
			f.close;
		end;
	
end

