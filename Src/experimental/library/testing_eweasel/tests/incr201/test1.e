
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> STRING create make, at end]
creation
	make
feature
	make is
		do
			$SYNTAX_ERROR
		end

end
