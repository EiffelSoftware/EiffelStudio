
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	try is
		do
			io.putint (weasel.a); io.new_line;
			io.putint (wimp.count); io.new_line;
		end
	
	weasel: TEST2 is
		do
		end

	wimp: BIT 32 is
		do
		end

end
