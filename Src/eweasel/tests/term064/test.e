
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			io.putint (try (args.item (1).to_integer));
			io.new_line;
		end

	try (a: INTEGER): INTEGER is
		external "C [macro %"weasel.h%"] :EIF_INTEGER"
		end
end
