
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	D
	
inherit
	C [STRING]
		redefine
			f
		end

feature
	
	f: LIST [C [like item]] is
		do
			Result := Precursor
		end
	
end
