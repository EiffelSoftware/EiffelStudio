
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile classes as is.  Es3 reports violation of VMFN though
	--	classes seem to be valid.
class 
	TEST
inherit
	TEST1
		rename
			try as weasel
		end;
	TEST1
		rename
			try as weasel
		end;
	TEST1
		rename 
			try as real_try
		select
			real_try
		end;
creation
	make
feature
	
	make is
		do
		end;

end


