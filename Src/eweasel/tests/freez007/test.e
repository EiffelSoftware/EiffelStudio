
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		do
			try;
		end
	
	try is
		local
			x: expanded TEST1;
			tried: BOOLEAN;
		do
			io.putstring ("In try%N");
			if not tried then
				raise ("weasels");
			end
			io.putdouble (x.d); io.new_line;
		rescue
			io.putstring ("In try rescue clause%N");
			tried := True;
			retry;
		end
	
end
