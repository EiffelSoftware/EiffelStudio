
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> LINKED_LIST [STRING]]
feature
	
	try is
		local
			s: STRING;
		do
			$TRY_BODY
		end;

	weasel: G;
	
	set_weasel (val: G) is
		do
			weasel := val;
		end
end
