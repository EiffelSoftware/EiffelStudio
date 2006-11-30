
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
			io.putstring ("BIT length is ");
			io.putint (bitmap.count);
			io.new_line;
		end;

	bitmap: BIT Bitmap_length is
		do
		end;

	Bitmap_length: INTEGER is $BIT_LENGTH;

end

