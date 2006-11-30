
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST
inherit
	ANY
		redefine
			default_create
		end

creation
	default_create

feature
	
	default_create is
		local
			z: TEST1 [ARRAY [TEST]]
		do
		end

	to_reference: ANY is
		do
			create Result
		end

end
