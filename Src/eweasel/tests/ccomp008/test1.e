
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

inherit
	TEST2
		rename
			make as test2_make
		end;
	
creation
	make

feature

	make (args: LINKED_LIST [STRING]) is
		local
			real_args: LINKED_LIST [STRING];
		do
			!!real_args.make;
			real_args.merge_right (args);
		end;

end
