
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
inherit
	EXCEPTIONS
     
creation
	make
     
feature
     
   	make is
		do
			io.put_string ("Start%N");
			io.put_integer (try); io.new_line;
			io.put_string ("End%N");
      		end;
     
   	try: INTEGER is
		external "$EXTERNAL_STRING"
		alias "is_debug_mode"
      		end;
     
end
