
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile classes as is.
	-- Uncomment out Creators part in class TEST1.  Rerun es3.
	--	TEST is now invalid, but there is no complaint.
	-- Uncomment declaration of `y' in `make' in TEST and save.  Rerun es3.
	--	The `!!x' call is reported as an error.
	--	(Just modifying TEST without changing class text is
	--	not sufficient).
	-- Change call in TEST to `!!x.make'.  Hit return.  Compiles OK.
	-- Make the Creation clause in TEST1 `creation {NONE} make'.
	--	Rerun es3.  The invalid call in TEST is not detected.
	-- Comment out declaration of `y' in `make' in TEST and save.  
	--	Rerun es3.  The `!!x.make' call is reported as an error.
	

inherit TEST1
	rename
		make as test1_make
	end

creation
	make
feature
	
	make is
		local
			x: TEST1;
		do
			$CREATION_CALL
		end;

end 
