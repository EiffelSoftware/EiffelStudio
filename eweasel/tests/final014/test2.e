
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	PARENT
		redefine
			weasel_amount
		end
creation
	make
feature

	weasel_amount: INTEGER is 
		external
			"C [macro %"$INCLUDE_FILE%"]"
		alias
			"hamster_amount"
		end;
		

end
