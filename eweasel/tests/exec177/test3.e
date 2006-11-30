
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	TEST2
		redefine
			is_stopable
		end
feature
	is_stopable: BOOLEAN is
		do
			Result := False
		end
	
end
