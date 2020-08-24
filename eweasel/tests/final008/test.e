
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	make
		local
			x: TEST1;
			z: expanded TEST1;
			
		do 
			create x;
			x.set_value (29);
			z.set_value (47);
			
			print ((x.weasel (x)).value); io.new_line;
			print ((x.weasel (z)).value); io.new_line;
			print ((z.weasel (x)).value); io.new_line;
			print ((z.weasel (z)).value); io.new_line;
			
		end

end
