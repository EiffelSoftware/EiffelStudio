
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
			print (Current @ 3); io.new_line
		end

	at alias "@" (m: INTEGER): INTEGER is
		external "C"
		end
			
end
