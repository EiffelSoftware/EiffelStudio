
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make
feature
	make (args: ARRAY [STRING]) is
		do
			$CREATE
			x.try
		end

	x: TEST1
end
