
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	SHARED
	TEST2;
	TEST3;
create
	make
feature
	make
		do
		end

invariant
	inv1: show ("TEST1 invariant");
end
