
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST 
inherit
	ARGUMENTS
creation
	make
feature
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
				io.putstring ("In make%N");
				try;
			end
		rescue
			io.putstring ("In make rescue clause%N");
			tried := True;
			retry;
		end
	
	try is
		local
			x: expanded TEST1
		do
			io.putstring ("In try%N");
			io.putdouble (x.d); io.new_line;
		rescue
			io.putstring ("In try rescue clause%N");
		end
	
end
