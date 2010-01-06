
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
inherit
	TEST4
		redefine
			try
		end
	TEST5
		redefine
			try
		end
	SHOW
feature
	try is
		require else
			assert: show ("Precondition of try in TEST3");
		do
		ensure then
			assert: show ("Postcondition of try in TEST3");
		end
end
