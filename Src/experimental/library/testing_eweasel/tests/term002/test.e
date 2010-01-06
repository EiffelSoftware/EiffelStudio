
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- When compiler reports VWBE violation, delete everything
	-- 	except `class TEST' and the closing `end'.
	-- Hit return.  Exception trace.

class TEST

end


