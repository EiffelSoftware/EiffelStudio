
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compiler reports VTCG error, change DOUBLE to STRING.
	-- Resume.  Exception trace.

class TEST
creation
	make
feature

	make is
		do
		end;

	x: HASH_TABLE [STRING, $HASHABLE_TYPE]
end
