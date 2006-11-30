
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G $CONSTRAINT]

feature
	
	try (n: G) is
		do
			print (n.count)
			io.new_line
		end

end
