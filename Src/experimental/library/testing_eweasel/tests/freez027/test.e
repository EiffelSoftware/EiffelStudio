
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make

feature {NONE}-- Initialization

	make is
		local
			a, b, c, d, e, f: STRING
		do
			make1 (15)
		end

	make1 (k: INTEGER) is
		local
			a, b, c, d, e, f, g, h: STRING
			retried: BOOLEAN
		do
			if k = 0 then
				if not retried then
					failure
				end
			else
				make1 (k - 1)
			end
		rescue
			retried := True
			retry
		end
		
	failure is
		local
			a, b, c, d, e, f, g, h: STRING
		do
			a.to_lower
		end

end
