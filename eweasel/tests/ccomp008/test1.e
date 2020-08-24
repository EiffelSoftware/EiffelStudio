
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

inherit
	TEST2
		rename
			make as test2_make
		end;
	
create
	make

feature

	make (args: LINKED_LIST [STRING])
		local
			real_args: LINKED_LIST [STRING];
		do 
			create real_args.make;
			real_args.merge_right (args);
		end;

end
