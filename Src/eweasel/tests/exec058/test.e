
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
			k: INTEGER;
		do
			from
				k := 1
			until
				k > 5
			loop
				print (weasel); io.new_line;
				k := k + 1;
			end
		end;

	weasel: BIT 8 is
		once
			Result := 1B;
		end
end
