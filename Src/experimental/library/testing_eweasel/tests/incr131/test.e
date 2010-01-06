
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
			e: $EXPANSION TEST1;
			a: ARRAY [ $EXPANSION TEST1];
		do
			a := << e >>;
			print (a.item (1)); io.new_line;
		end

end
