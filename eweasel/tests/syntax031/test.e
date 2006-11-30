
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
		end;

	weasel (a, b: INTEGER) is
		external
			"C [macro$TERMINATOR <weasel.h>]"
		end;

end
