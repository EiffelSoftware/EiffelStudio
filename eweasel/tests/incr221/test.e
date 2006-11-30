
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	$PARENT
creation
	make

feature

	make is
		do
			Current.set_weasel (Current)
		end

feature {TEST2}

	set_weasel (n: like Current)is
		do
		end

end
