
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
			y: expanded TEST2
			z: TEST3
		do
			create y
			create z
			z.try (y)
		end

end
