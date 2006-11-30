
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.


class TEST
creation 
	make
feature
	make is
		do
			weasel
			weasel
  		end
			
	weasel is
		$ROUTINE_TYPE
			io.put_string ("Weasel");
			io.new_line
		end
end
