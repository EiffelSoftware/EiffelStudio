
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		rename
			weasel as hamster,
			wimp as hamster
		redefine
			hamster
		end
creation
	make
feature

	hamster: INTEGER is
		do
			Result := precursor {TEST1} + 29
		end
end
