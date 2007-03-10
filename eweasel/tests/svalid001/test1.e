
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	make is
			--
		local
			size: INTEGER
		do
			size := (size * (2 ^ size)).truncated_to_integer
		end

	string: STRING
end
