
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	TEST1
create
	make
feature
	make is
		do
		end

	try is
		do
			print ((agent stoat).item ([]));
			io.new_line
		end
	
end
