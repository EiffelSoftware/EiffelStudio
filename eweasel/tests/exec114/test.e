
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		local
			s: STRING
		do
			s := "%/0/1%/0/%/0/00%/0/"
			io.put_boolean (s.is_integer); io.new_line
			io.put_boolean (s.is_real); io.new_line
			io.put_boolean (s.is_double); io.new_line
		end;

	
end
