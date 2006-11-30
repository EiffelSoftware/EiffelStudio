
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature

	make is
		local
			weasel: ARRAYED_LIST [STRING];
		do
			!!weasel.make (4);
			weasel := weasel.twin
			io.putstring ("Twin worked%N");
		end
	
end
