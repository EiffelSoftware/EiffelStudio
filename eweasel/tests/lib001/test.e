
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature

	make (args: ARRAY [STRING])
		local
			f: PLAIN_TEXT_FILE;
		do 
			create f.make_open_read (args.item (1));
			f.start;
			f.close;
		end;
	
end
