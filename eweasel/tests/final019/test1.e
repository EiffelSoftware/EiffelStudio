
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]

feature
	try
		do
			a := Void
			a ?= x
			io.put_boolean (a /= Void); io.new_line
  		end
			
	a: TEST3

	x: G

end
