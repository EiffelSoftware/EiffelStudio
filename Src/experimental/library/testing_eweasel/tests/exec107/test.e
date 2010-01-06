
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	EXCEPTIONS

creation
	make

feature

	blow_up: STRING

	make is
		local
			tried: BOOLEAN
			l_mem: MEMORY
		do
			if not tried then
				from
					create l_mem
					l_mem.set_max_mem (100_000_000)
					blow_up := ("x").twin
				until
					False
				loop
					blow_up.append (blow_up)
				end
			end
      		rescue
         		if exception = No_more_memory then
				tried := True
				retry
         		end
      		end

end
