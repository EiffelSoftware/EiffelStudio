
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			a: expanded TEST1
		do
			print (a.x1.d1); io.new_line
			print (a.x1.d2); io.new_line
			print (a.x2000.d1); io.new_line
			print (a.x2000.d2); io.new_line
		end
	
end
