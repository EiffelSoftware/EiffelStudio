
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G, H]
feature
	try
		do
			print ($x); ;io.new_line
			print ($y); io.new_line
		end
		
	x: G
	Y: H

end
