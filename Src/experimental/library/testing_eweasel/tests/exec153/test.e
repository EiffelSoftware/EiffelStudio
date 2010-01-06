
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		do
			print ((<< << "A" >> , << 47 >> >>).generating_type);
			io.new_line
			print ((<< << 47 >> , << "A" >> >>).generating_type);
			io.new_line
			print ((<< << 47 >> , << 47 >> >>).generating_type);
			io.new_line
			print ((<< << "A" >> , << "B" >> >>).generating_type);
			io.new_line
		end

end
