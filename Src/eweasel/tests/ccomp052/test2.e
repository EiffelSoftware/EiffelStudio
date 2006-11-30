
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G -> DOUBLE create default_create end]
inherit
	ANY
		redefine
			default_create
		end
feature
	
	default_create is
		do
			create x
		end
	
	x: G
end
