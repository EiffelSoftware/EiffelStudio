
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
			check_on ("+weasel123")
			check_on ("-weasel123")
			check_on ("+w1")
			check_on ("-w1")
		end;

	check_on (s: STRING) is
		do
			io.put_boolean (s.is_integer); io.new_line
		end
	
end
