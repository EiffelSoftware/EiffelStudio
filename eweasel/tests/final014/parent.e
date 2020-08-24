
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class PARENT
feature
	make
		do
			count := weasel_amount;
		end

	count: INTEGER;

	weasel_amount: INTEGER 
		external
			"C [macro %"$INCLUDE_FILE%"]"
		end;
		

end
