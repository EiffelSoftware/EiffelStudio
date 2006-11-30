
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature

	make (args: ARRAY [STRING]) is
		local
			f: PLAIN_TEXT_FILE;
		do
			!!f.make_open_read (args.item (1));
			f.start;
			f.close;
		end;
	
end
