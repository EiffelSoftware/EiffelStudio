
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			!!table.make (0);
			table.put ("turkey", "wimp");
		end
	
	table: HASH_TABLE [STRING, $ACTUAL_GENERIC ]

end
