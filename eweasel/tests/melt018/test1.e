
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1

feature 

	try (n: like Current) is
		do
			io.putbool (n = Current); io.new_line;
		end
	
end
