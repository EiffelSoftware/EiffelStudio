
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create is
		local
			x: expanded TEST2 [like Current]
		do
			print (x.generating_type)
			io.new_line
		end

end
