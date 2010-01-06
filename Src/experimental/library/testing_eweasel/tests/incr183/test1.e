
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
feature
	default_create is
		do
			$BODY
			-- weasel := 47
		end

	weasel: INTEGER

			
end
