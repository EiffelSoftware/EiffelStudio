
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
			bitmap := new_bitmap;
		end;

	bitmap: BIT 10;

	new_bitmap: BIT Bitmap_length;
	
	Bitmap_length: INTEGER is $BIT_LENGTH;

end

