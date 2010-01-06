
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	default_create,
   	make
convert
	to_expanded: {expanded TEST}
feature
      make is
        	do
			io.put_integer (weasel (Current)); io.new_line;
        	end;

	weasel (x: expanded TEST): INTEGER is
		external
			"C (EIF_INTEGER): EIF_INTEGER"
		alias
			"abs"
		end

	to_expanded: expanded TEST is
		do
		end

end
