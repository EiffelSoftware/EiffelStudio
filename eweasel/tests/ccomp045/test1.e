--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make

feature

	default_create
		do
			make
		end

	make
		external "C inline use <stdio.h>"
		alias
			"printf(%"In TEST1 make\n%"); fflush(stdout);"
		end

	a: INTEGER

end
