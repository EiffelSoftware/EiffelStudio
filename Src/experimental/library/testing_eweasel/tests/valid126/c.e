
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class C [G -> A]

feature

	f (a: G) is
		local
			b: B [G]
		do
			b := a.new_b
		end

end
