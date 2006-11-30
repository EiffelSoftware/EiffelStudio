
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A
create
	make
feature
	make is
		do
			print ((create {like x}).generator)
			io.new_line
		end
	x: ANY
end

