
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit 
	INTEGER
creation
	make
feature
	
	make is
		do
			set_item (47);
			io.putint (item); io.new_line;
			io.putint (hash_code); io.new_line;
			io.putstring (out); io.new_line;
			io.putbool (Current < 13); io.new_line;
			io.putint (Current + 29); io.new_line;
			io.putint (Current - 29); io.new_line;
			io.putint (Current * 29); io.new_line;
			io.putreal (Current / 29); io.new_line;
			io.putint (Current // 29); io.new_line;
			io.putint (Current \\ 29); io.new_line;
			io.putint (Current ^ 3); io.new_line;
		end

end
