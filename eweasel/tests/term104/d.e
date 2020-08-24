
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
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
	
	f: LIST [C [like item]]
		do
			Result := Precursor
		end
	
end
