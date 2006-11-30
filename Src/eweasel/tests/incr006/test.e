
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Delete inheritance clause in class CHILD.  Recompile.
	-- 	VDRD violation not detected.

class 
	TEST
inherit
	TEST1
		redefine
			try
		end;
creation
	make
feature

	make is
		do
		end;

	try (arg: CHILD) is
		do
		end
end

