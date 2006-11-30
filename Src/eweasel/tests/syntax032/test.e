
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
			try (3, 5);
      		end;
     
   	try (a, b: INTEGER) is
		external "C (EIF_POINTER, EIF_INTEGER):EIF_INTEGER"
		alias "str_blank"
      		end;
     
end
