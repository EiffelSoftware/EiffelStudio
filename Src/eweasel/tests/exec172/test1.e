
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	$FROZEN value: INTEGER is
		external "C inline"
		alias "47"
		ensure
			$ASSERTION
		end

end
