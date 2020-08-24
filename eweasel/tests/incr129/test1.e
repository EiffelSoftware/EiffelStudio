
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2 [STRING]]
feature
	weasel
		local
			x: G
		do
			if x /= Void then
				io.putstring (x.out); io.new_line;
			else
				io.putstring ("Local is void%N");
			end
		end

end
