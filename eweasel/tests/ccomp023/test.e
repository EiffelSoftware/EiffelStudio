
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
			io.put_integer (try); io.new_line;
      		end;
     
   	try: INTEGER is
		external "C :EIF_INTEGER | %"eif_except.h%""
		alias "arg_number"
      		end;
     
end
