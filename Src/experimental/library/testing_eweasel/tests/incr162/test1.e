
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	TEST2
		redefine
			make, f
		end
	$PARENT
creation
	make
feature
	make is
		do
			f
		end

	f is
		do
			io.put_string ("In TEST1 f%N")
			precursor
		end
end
