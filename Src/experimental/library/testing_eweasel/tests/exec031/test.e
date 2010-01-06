
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	
creation 
	
	make

feature
	make (s: ARRAY[STRING]) is 
		local
			k: INTEGER;
		do
			io.putbool (s = Void); io.new_line;
			io.putint (s.lower); io.new_line;
			io.putint (s.upper); io.new_line;
			io.putint (s.count); io.new_line;
			from
				k := s.lower + 1;
			until
				k > s.upper
			loop
				io.putstring (s.item (k)); io.new_line;
				k := k + 1;
			end
		end;

end 
