
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
create
	make
feature
	make is
		do
			print (a.x1.d1); io.new_line
			print (a.x1.d100); io.new_line
			print (a.x100.d1); io.new_line
			print (a.x100.d100); io.new_line
			full_collect
			print ("All done%N")
		end
	
	a: expanded TEST1
end
