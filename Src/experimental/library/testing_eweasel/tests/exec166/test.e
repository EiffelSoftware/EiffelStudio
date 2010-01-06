
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	ANY
creation
	default_create,
   	make

convert
	to_expanded: {expanded TEST}

feature
   make is
		local
			n: INTEGER
        	do
			n := weasel (Current);
			print (n > 0); io.new_line
        	end;

        weasel (x: expanded TEST): INTEGER is
                external
                        "C macro signature (EIF_INTEGER): EIF_INTEGER use %"eif_eiffel.h%""
                alias
                        "abs"
                end

	to_expanded: expanded TEST is
		do
		end
end
