
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class C [G -> A]

feature

	f (a: G)
		local
			b: B [G]
		do
			b := a.new_b
		end

end
