
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	try is
		do
			(agent {$EXPANDED TEST2}.hamster).call ([x]);
		end

	x: expanded TEST2

end

