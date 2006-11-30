
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
creation
	make
feature
	make (arg: G) is
		do
			io.putstring ("In generic class make%N");
			print (arg); io.new_line;
			io.putstring (arg.out); io.new_line;
		end

end
