
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit {NONE}
NON_CONFORMING_CLASS

create
	make

feature
	make
		do
			if {x: !NON_CONFORMING_CLASS} Current then
				print ("Error%N")
			else
				print ("OK%N")
			end
		end
end 
