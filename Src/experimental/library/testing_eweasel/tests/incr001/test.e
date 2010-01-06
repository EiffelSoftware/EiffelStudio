
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, with TEST as root class (no freezing).
	-- Add `expanded' before `class' in TEST1, making it an expanded
	--	class.
	-- Recompile.  VLEC violation detected.
	-- Remove formal generic parameter `[G]' from TEST1, but *not*
	--	from type of attribute `x'.
	-- Resume compilation.  VTCT violation detected.
	-- Add formal generic parameter `[G]' back to TEST1.
	-- 	Resume compilation.  VLEC violation not detected.

class TEST 
feature

	a: TEST1 [STRING];
end
