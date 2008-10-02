
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	make is
		local
			b: B [STRING]
			d: D [STRING]
		do
			b := a
			d := a
		end

	a: A [STRING]

end
