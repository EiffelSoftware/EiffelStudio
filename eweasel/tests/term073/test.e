
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make	
feature	

	make (args: ARRAY [STRING])
		do
			print (weasel (args));
		end
	
	weasel (args: ARRAY [STRING]): TEST1 [STRING, STRING]
		do 
			create Result.make;
			Result.set (args, args);
		end

end
