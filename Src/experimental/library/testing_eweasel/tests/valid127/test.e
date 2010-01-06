
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation

	make

feature

	make is
		local
			j: INTEGER
		do
			i := 2
			j := 32 \\ i
			io.put_integer (j)
			io.new_line
		end

	i: INTEGER

end

