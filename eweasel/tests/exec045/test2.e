
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
feature	
	x: expanded TEST1;

	try: TEST1
		do
			Result := x.try;
		end

end
