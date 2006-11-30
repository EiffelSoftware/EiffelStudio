
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
			(agent try ()).call ([47])
		end

	try (n: INTEGER) is
		do
		end
end
