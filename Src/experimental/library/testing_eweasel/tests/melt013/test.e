
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
			$CREATION_INST;
			set_bitmap (Bitmap_length);
		end;

	new_bitmap: BIT Bitmap_length is
		do
		end;
	
	bitmap: $ATTRIBUTE_TYPE;

	set_bitmap (count: INTEGER) is
		local
			k: INTEGER
		do
			from
				k := 1;
			until
				k > count
			loop
				bitmap.put (True, k);
				k := k + 1;
			end
		end;

	Bitmap_length: INTEGER is 180;
end

