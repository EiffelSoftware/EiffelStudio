
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G -> TEST3 create make end]
feature
	f: G is
		do
			io.put_string ("Hey you weasel%N")
			!!x.make
			io.put_string (x.generating_type) io.new_line
			Result := x
		end
	
	x: G
	
end
