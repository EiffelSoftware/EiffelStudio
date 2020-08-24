
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G]
feature
	wimp: G;

	weasel: like wimp

	set_weasel (val: G)
		do
			weasel := val;
		end;
	
	do_weasel
		do
			io.putstring ("Hey you weasel%N");
		end

end
