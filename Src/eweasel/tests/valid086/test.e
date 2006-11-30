
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
			try
		end

	try is
		require
			ok: is_non_void (weasel);
		do
		end

	is_non_void (x: ANY): BOOLEAN is
		do
		end

feature {NONE}
	
	weasel: TEST;

end
