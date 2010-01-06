
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	address: POINTER is
		do
			Result := to_pointer ($weasel)
		end

	to_pointer (p: POINTER): POINTER is
		do
			Result := p
		end

	weasel is
		do
			io.put_string ("Weasel 1%N")
		end
end
