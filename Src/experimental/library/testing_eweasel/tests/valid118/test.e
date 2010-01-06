
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		redefine
			weasel
		end
	TEST1
		rename
			weasel as wimp
		select
			wimp
		end
creation
	make
feature
	make is
		do
		end;

	weasel: STRING is
		do
			Result := precursor {TEST1}
		end
	
end
