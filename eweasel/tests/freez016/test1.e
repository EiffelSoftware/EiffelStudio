
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> ANY]
feature
	
	w: G
	
	weasel
		do
			io.put_string (w.generating_type.name_32.to_string_8); io.new_line
		end

end
