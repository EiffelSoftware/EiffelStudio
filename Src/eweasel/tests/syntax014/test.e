
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports syntax error even
	--	though the free operator appears to be legal.

class 
	TEST
creation
	make
feature

	make is
		do
			test1;
		end;

	test1 is
		do
			print (##%% Current);
			print (##% Current);
		end;
	
	prefix "##%%": like Current is
		do
			Result := Current;
		end;

end

