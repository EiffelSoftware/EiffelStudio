
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	D [G, H]
	
inherit
	C [H]
		redefine
			f
		end

feature
	
	f (i: like item): LIST [C [like item]] is
		do
			Result := Precursor (i)
		end
	
end

