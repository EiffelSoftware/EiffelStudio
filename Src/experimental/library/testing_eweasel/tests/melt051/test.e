
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
			int: INTERNAL
		do
			create int
			print (int.field_count (Current))
			io.new_line
		end

	$ATTRIBUTE
end

