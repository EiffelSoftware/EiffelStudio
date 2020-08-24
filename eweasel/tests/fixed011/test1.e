
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
	
create 
	
	make

feature
	make (x: INTEGER): REAL
		do
			io.putstring ("In TEST1 creation proc%N");
			Result := 3.14159;
		end;

end 
