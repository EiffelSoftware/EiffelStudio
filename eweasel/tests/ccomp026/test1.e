
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	weasel (code: INTEGER) is
		external "C | %"eif_except.h%""
		alias "esdie"
		end;
end
