
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make is
		local
			x: TEST2
		do
			x := value
		end

	value: TEST2 is
		do
			Result.set_a (47)
		ensure
			good: show (not equal (old Result, value))
		end

	show (b: BOOLEAN): BOOLEAN is
		do
			print (b);
			io.new_line
			Result := True
		end
end

