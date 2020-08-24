
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	wimp
		local
			x: like w;
		do
			io.put_string ("Entering TEST1 wimp%N") ;
			create x;
			io.put_boolean (x = Void); io.new_line;
			io.put_string ("Leaving TEST1 wimp%N");
		end


	w: TEST3
		do
		end

end
