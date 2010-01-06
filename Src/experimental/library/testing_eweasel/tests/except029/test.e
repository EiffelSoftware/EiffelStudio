
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature

	make (args: ARRAY [STRING])
		local
			count: INTEGER
			tried: BOOLEAN
		do
			if not tried then
				count := args.item (1).to_integer
			else
				print ("Retry OK%N")
			end
		rescue
			tried := True
			retry
		end

end
