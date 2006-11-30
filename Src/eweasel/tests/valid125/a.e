
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A
feature
	e1: E

	e2: E
	
	g is
		do
			e1 := e2
		end
end
