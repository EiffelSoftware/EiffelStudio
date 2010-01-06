
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
			t: TEST1 [STRING]
		do
			t := create {TEST1 [STRING]} .make ("Weasels");
			io.put_string (t.x); io.new_line
  		end
	

end
