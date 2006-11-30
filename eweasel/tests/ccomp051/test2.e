
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2

inherit
	ANY
		redefine
			out
		end

feature
	
	to_any: ANY is
		do
			Result := "Weasel"
		end

	out: STRING is
		do
			Result := "TEST2.out"
		end

end
