
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST3 [G]
feature
	
	f: G
	
	to_any: ANY is
		do
			Result := Current
		end

end
