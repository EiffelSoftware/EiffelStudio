
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
convert
	to_reference: {TEST1_REF}
feature
	default_create is
		do
			io.putstring ("In TEST1 make%N");
			wuss := 47.29;
		end;

	to_reference: TEST1_REF is
		do
			create Result
			Result.set_wuss (wuss)
		end

	wuss: DOUBLE;

	set_wuss (d: DOUBLE) is
		do
			wuss := d
		end

end
