
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make is
		do
			(agent try ({NONE} ?)).call ([Void])
		end;

	try (n: NONE) is
		do
			if n /= Void then
				print ("Not Void%N")
			end
		end
end
