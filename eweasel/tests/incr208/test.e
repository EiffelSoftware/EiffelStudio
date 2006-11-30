
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		do
			$INSTRUCTION
			print ((create {TEST1 [BIT 8]}).generating_type)
			io.new_line
			print ((create {TEST1 [BIT n]}).generating_type)
			io.new_line
		end
	
	n: INTEGER is 8

end
