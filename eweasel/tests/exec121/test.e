
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create

	make

feature

	make
		local
			a: A
			a2: A2 [C]
		do 
			create a2
			a2.f
			a ?= a2
			a2.f
		end

end
