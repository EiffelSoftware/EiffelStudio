
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	wimp is
		local
			x: like w;
		do
			io.put_string ("Entering TEST1 wimp%N");
			!!x;
			io.put_boolean (x = Void); io.new_line;
			io.put_string ("Leaving TEST1 wimp%N");
		end


	w: TEST3 is
		do
		end

end
