
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit	
	TEST2
		redefine
			f1, f2
		end
creation
	make
feature
	make is
		do
			f1
			f2
		end

	$HEADER is
		do
			precursor {TEST2}
		end;

	$OTHER

end
