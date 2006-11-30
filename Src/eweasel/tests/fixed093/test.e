
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the error:
	-- Compile class as is.
	-- Uncomment the "expanded" line below (part of class header)
	-- and rerun es3.  No complaints are issued.

$CLASS_HEADER
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	
	a: TEST;

	default_create is
		do
			print ("Hi");
		end;
	
end 
