
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Change header of PARENT to make it an expanded class.
	-- Recompile.  VJRV violation not detected.


class 
	TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
			p ?= Void;
		end;
end

