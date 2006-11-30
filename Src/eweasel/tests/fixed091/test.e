
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	-- To reproduce error:
	-- Compile with class as is.
	-- When es3 stops and reports violation of validity constraint VLEC 
	-- (Expanded Client rule), comment out the declaration of 
	-- feature `m' below and then hit return.
	
	default_create is
		do
		end;
	
	$FEATURE
	
end 
