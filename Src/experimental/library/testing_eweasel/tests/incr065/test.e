
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			s: STRING;
		do
			s := Current @index 3;
			print (s);
			s := Current @Index 3;
			print (s);
			s := Current @INDEX 3;
			print (s);
		end;
	
	infix "$FEATURE_NAME" (a: INTEGER): STRING is
		do
		end;

end 
