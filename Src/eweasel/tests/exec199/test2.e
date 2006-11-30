
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1 [ANY]
		redefine
			dummy_event_data_internal, g
		end

create
	make

feature

	dummy_event_data_internal: TEST3

	g: STRING

end
