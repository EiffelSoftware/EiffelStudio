
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
			
feature
	make is
		do
			io.put_integer (weasel); io.new_line
		end

	weasel: INTEGER is
		do
			Result := 47
		end
	
	wimp: INTEGER is
		do
			Result := 16
		end
	
end
