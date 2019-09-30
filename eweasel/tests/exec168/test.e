
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		rename
			weasel as weasel alias "@",
			stoat as stoat alias "@@",
			ermine as ermine alias "@@@",
			f1 as hamster1 alias "@@@1",
			f2 as hamster2 alias "@@@2",
			f3 as hamster3 alias "@@@3"
		end
creation
	make
feature
	make is
		do
			local_try;
			try;
		end
	
	local_try is
		do
			io.put_double (Current @ 13.9); io.new_line;
			io.put_double (Current @@ 14.9); io.new_line;
			io.put_double (Current @@@ 15.9); io.new_line;
			io.put_double (hamster1 (5.9)); io.new_line;
			io.put_double (hamster2 (6.9)); io.new_line;
			io.put_double (hamster3 (7.9)); io.new_line;
		end
	
end
