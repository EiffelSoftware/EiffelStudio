
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class PARENT
feature
	make is
		do
			count := weasel_amount;
		end

	count: INTEGER;

	weasel_amount: INTEGER is 
		external
			"C [macro %"$INCLUDE_FILE%"]"
		end;
		

end
