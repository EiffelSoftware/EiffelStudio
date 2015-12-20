--| Copyright (c) 1993-2013 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Comment out `access' cluster in Ace.  Rerun es3.  When VTCT
	--	violation is reported, uncomment `access' cluster again.
	--	Hit return.  Get exception trace in pass 3.

class 
	TEST

create
	make

feature
	
	make
		local
			i: $TYPE
		do
			i := 256
		end

end
