
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
create
	make_from_array
convert
	make_from_array ({ARRAY [NONE]})
feature 
	make is
		do
		end
	
	make_from_array (d: ARRAY [NONE]) is
		do
			array := d
		end
	
	array: ARRAY [NONE]
end
     
