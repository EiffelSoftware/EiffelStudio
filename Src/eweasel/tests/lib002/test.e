
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature
	make is
       		local
            		s, t: STRING
        	do
            		create s.make (9)
            		create t.make (10)
            		t.append ("1234567890")
            		s.copy (t)
		end

end
