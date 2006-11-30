
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST2
		redefine
			report_anchor
		end
create
	make

feature

	make is
			-- Run tests.
		do
		end

feature
	report_anchor: LIST [TEST]

end
