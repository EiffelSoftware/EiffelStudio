
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	SHARED
	TEST2;
	TEST3;
creation
	make
feature
	make is
		do
		end

invariant
	inv1: show ("TEST1 invariant");
end
