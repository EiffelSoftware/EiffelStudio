
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		external "C inline use %"eif_eiffel.h%", <stdio.h>"
		alias "[
			printf ("Hey you weasel\n");
  			printf ("Argument count is %ld\n", eif_field (eif_access($args), "upper", EIF_INTEGER));
			fflush(stdout);
			]"
		end

end
