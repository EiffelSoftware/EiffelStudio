
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	ANY
		redefine
			default_create
		end
create
	make, default_create
feature

	default_create, make is
		local
			t: expanded MY_LIST [like Current]
		do
			print (t.count); io.new_line
		end

end
