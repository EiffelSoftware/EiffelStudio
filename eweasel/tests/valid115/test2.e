
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G -> TEST3 create make end]
feature
	f: G
		do
			io.put_string ("Hey you weasel%N") 
			create x.make
			io.put_string (x.generating_type.name_32.to_string_8) io.new_line
			Result := x
		end
	
	x: G
	
end
