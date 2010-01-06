
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G $CONSTRAINT]

create
	make

feature
	make is
		do
			print ((agent {G}.generator).generating_type);
			io.new_line
		end

end
