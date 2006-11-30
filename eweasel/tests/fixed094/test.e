
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Uncomment declaration of feature `a' in class TEST and
	-- Rerun es3.
	-- Change TEST1 to a deferred class by uncommenting both
	-- occurrences of "deferred" and commenting out "do" in body
	-- of `a'.
	-- Rerun es3. Compiler doesn't detect violation of VTEC.

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
