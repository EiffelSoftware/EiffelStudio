
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compiler stops and complains about violation of VTEC,
	-- comment out the declaration of `a' below, save, and then
	-- hit return to tell es3 to retry.

class TEST

creation
	make
feature
	
	$FEATURE

	make is
		do
			print ("Hi");
		end;
	
end 
