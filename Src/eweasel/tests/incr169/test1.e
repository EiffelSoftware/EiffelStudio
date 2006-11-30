
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> STRING create make end]
feature
	display is
		do
			create x.make (1)
			print (x.generating_type); 
			io.new_line
			print ((create {ARRAY [G]}.make (1, 2)).generating_type); 
			io.new_line
		end

	x: G
end
