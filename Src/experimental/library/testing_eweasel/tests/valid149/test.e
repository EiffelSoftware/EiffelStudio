
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature

	make (args: ARRAY [STRING]) is
		local
			x: TEST1
		do
			create {TEST2} x
			print (x.try)
			io.new_line
		end
		
		
end
