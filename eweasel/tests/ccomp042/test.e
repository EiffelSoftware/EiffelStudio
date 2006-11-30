
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make
	
feature
	make is
		local
			d: DOUBLE
		do
			d := - - 3.5
			print (d); io.new_line
		end
		
end
