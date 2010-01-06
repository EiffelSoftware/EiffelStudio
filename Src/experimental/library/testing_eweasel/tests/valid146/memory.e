
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class MEMORY
inherit
	ANY
		rename
			default_create as weasel
		redefine
			weasel
		end

feature
	weasel is
		do
			print ("Hey you weasel%N")
		end

end
