
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler dies with run-time panic in
	--	pass 3 on class DISPENSER.

class TEST
feature
	w: LINKED_LIST [NONE];
end
