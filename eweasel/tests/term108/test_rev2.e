
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is 
		do 
			print (feature {TEST1 [DOUBLE]}.value); io.new_line
			print (feature {TEST1 [INTEGER]}.value); io.new_line
			print (feature {TEST1 [BOOLEAN]}.value); io.new_line
			print (feature {TEST1 [STRING]}.value); io.new_line
			print (feature {TEST1 [TEST2]}.value); io.new_line
		end

end
