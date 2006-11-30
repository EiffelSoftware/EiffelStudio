
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			x: INTEGER_64
		do
			x := value
			inspect x
			when value then
			end
		end

	value: INTEGER_64 is 1

end
