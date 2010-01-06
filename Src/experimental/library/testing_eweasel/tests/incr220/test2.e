
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G $CONSTRAINT]

feature

	try (n: G) is
		do
			print ((agent {G}.item).item ([n, 1]));
			io.new_line
		end

end
