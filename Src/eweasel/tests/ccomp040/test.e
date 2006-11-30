
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation

	make

feature

	make is
		local
			a1: A [STRING]
			a2: A2
		do
			if a1 /= Void then
				a1.g
			end
			!! a2
			a2.g
		end

end
