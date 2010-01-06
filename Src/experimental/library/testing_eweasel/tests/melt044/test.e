
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
			x: TEST1;
		do
			!!x.make (47);
			io.put_integer (x.value); io.new_line;
			!!x.make (x.value);
			io.put_integer (x.value); io.new_line;
      		end;
     

end
