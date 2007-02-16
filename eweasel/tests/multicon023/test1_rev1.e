
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> {NUMERIC rename default_create as foo, default_create as poo end, COMPARABLE} create default_create end] 
feature
	test
			-- Actually we should NOT be able to create an instance of G
		local
			l_g: G
		do
			create l_g
		end
end
