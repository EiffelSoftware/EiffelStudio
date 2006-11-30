
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	ANY
		redefine
			default_create
		end
create
	default_create

feature 

	default_create is
		do
			print ("Creating TEST1 instance%N")
		end

	to_reference: TEST1 is
		do
			create Result
		end
end
