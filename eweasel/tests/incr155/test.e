
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make
		do 
			create x
			io.put_string (x.weasel.generating_type.name_32.to_string_8); io.new_line
  		end
			
	x: TEST1 [SEQ_STRING]
			
end
