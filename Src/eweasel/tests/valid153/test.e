
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	index: INTEGER

	make is
		do
		end

	parse_char_code(str: STRING): BOOLEAN is
		require
			str @ index /= '%N'
		do
		end
end
