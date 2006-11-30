
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	frozen weasel is
		external "C inline"
		alias "printf(%"In weasel\n%");"
		ensure
			$ASSERTION
			-- post6: show ("post6", True)
		end
	
	show (s: STRING b: BOOLEAN): BOOLEAN is
		do
			print (s); io.new_line
			Result := b
		end
end
