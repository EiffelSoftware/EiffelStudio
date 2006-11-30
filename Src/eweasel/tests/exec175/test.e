
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature


feature
	make is
		local
			x: ANY
		do
			create x
			print (x.generating_type); 
			io.new_line
		end

end
