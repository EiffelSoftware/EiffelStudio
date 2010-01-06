
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
creation
	make
feature
	make is
		local
			b: BIT $BIT_LENGTH
		do
			collection_off;
			b := not b;
			io.putbool (b.item (1));
			io.new_line;
			io.putbool (b.item ($BIT_LENGTH));
			io.new_line;
		end;

end
