
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	SHARED
creation
	make
feature
	make is
		do
			!!t.make;
			set_ok;
			io.putstring ("In make%N");
			try;
		end
	
	t: TEST2;

	try is
		local
			x: expanded TEST1

		do
			io.putstring ("In try%N");
			io.putdouble (x.d); io.new_line;
		rescue
			io.putstring ("In try rescue clause%N");
			x.do_nothing
			unset_ok;
			x := t.x;
			retry;
		end
	
end
