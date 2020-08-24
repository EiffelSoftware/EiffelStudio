
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
feature	
	weasel: STRING;

	set_weasel (s: STRING)
		do
			weasel := s;
		end

	to_reference: TEST2
		do
			create Result
			Result.set_weasel (weasel)
		end
end
