
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2

inherit

	PARENT

creation

	make

feature -- Creation

	make is
		do
			$TEST2_MAKE_BODY
		end;

	new_bitmap: BIT 8 is
		do
		end;

feature -- Modification

	mod_read_access (val: BOOLEAN) is
		do
			bitmap.put (True, 1);
		end;

end
