
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
			set_real_value (13.245);
        	end

	attribute_field: REAL;

	set_real_value (v: REAL) is
		do
			attribute_field := v;
			if attribute_field /= v then
				io.put_string ("Disaster: assignment or comparison doesn't work%N");
			end
		end

end
