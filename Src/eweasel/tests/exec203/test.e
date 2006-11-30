
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
			b1, b2: B
		do
			b1.a.set_value (10000)
			b2 := b1
			io.put_integer (b1.a.value)
			io.put_new_line
		end
			
end
