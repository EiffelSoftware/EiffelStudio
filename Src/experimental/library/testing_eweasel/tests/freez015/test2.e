
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
		redefine
			weasel
		end
feature
		
	weasel is
		do
			io.put_string ("Weasel 2%N")
		end
	
	new_address: POINTER is
		do
			Result := to_pointer ($weasel)
		end

end
