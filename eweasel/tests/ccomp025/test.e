
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
creation
	make
     
feature
     
   	make is
		do
			print (weasel (111b)); io.new_line;
      		end;
     
   	weasel (a: BIT 3): BIT 3 is
		do
			Result := a;
      		end;
     
end
