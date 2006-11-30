
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile classes as is.
	-- Uncomment declaration of local `x' in `make' in TEST.  Rerun es3.
	-- Remove last formal generic parameter I from TEST1.
	--	Rerun es3.  Accepts invalid class.
	-- Uncomment `print' in `make' of class TEST.  Rerun es3.
	--	Validity violation VTUG is now reported.  
	-- Remove last actual generic parameter in declaration of `x'.
	--	Hit return.  Compiler accepts correct class, but
	--	bites the big one in pass 5 on class TEST1.

creation
	make
feature
	
	make is
		local
			$LOCAL
		do
		end;

end 
