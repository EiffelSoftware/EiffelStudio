
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class B
create
	default_create

feature
	i: INTEGER
	c: C
	test: ARRAY [C]
	
	set_i (l_i: INTEGER) is 
		do 
			i := l_i 
			create test.make (1, 5)
		end

	to_reference: ANY is
		do
		end
end
