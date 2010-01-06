
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class B

feature
	i: INTEGER
	c: C
	
	set_i (l_i: INTEGER) is 
		do 
			i := l_i 
		end

	set_c (l_c: C) is 
		do 
			c := l_c 
		end

	to_reference: ANY is
		do
--			create Result
--			Result.set_i (i)
--			Result.set_c (c)
		end
end
