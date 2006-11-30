
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
			io.put_integer (weasel); io.new_line
  		end
			
	weasel: INTEGER is
		once
			io.put_string ("Weasel is ")
			io.put_integer (weasel)
			io.new_line
			Result := 47
		end

end
