
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make (args: ARRAY [STRING]) is
		local
			y: TEST1
		do
			create y
			y.try
		end;

end
