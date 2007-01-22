
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> {STRING,COMPARABLE}]
creation
	make
feature
	make (arg: G) is
		do
			arg.fill_blank;
		end
end
