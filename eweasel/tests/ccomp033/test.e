
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		local
			s: STRING
		do
			s := args.item (1)
			s.to_lower
			io.put_string (s); io.new_line
		end
end
