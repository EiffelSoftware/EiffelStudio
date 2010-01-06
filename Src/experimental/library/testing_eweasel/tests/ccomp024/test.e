
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
creation
	make
     
feature
     
   	make is
		local
			k: INTEGER
		do
			 k := try (1, 2);
      		end;
     
   	try (x, y: INTEGER): INTEGER is
		external "C [macro %"$MACRO_INCLUDE%"] (EIF_POINTER, EIF_INTEGER): EIF_INTEGER %
			% | %"$WEASEL_INCLUDE%"	,	%"$WIMP_INCLUDE%""
		alias 
			"hashcode"
      		end;
     
end
