
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> STRING create make end]
feature
	weasel: G is
		do
			!!Result.make (0)
			print (agent Result.make)
		end

end
