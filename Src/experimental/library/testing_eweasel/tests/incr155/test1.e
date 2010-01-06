
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [reference G -> SEQ_STRING create make end]
inherit
	TEST2 [$ACTUAL_GENERIC]
		redefine
			weasel
		end
feature
	weasel: G is
		do
			Result := precursor
		end
end
