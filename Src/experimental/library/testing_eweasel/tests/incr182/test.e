
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	$PARENT
creation
	make
feature
	
	make is
		do
			f
		end
			
	f
		do
			io.put_string ("Hey you weasel%N")
		end

end
     
