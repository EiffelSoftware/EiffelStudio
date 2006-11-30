
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.  Es3 reports violation of VGCP on class
	--	TEST.
	-- Change `try' from a `once' routine to a `do' routine.  Hit
	--	return.  Class accepted.
class 
	TEST
creation	
	make, try
feature
	
	make is
		once
			try;
			make;
		end;
		
	try is
		once
		end;
end
