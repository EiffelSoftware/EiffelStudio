
--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	-- To reproduce error:
	-- Compile this class as is.
	-- Then uncomment out the two lines at end of `make'
	-- and the declaration of `prefix "or"' below and rerun es3.
	-- When it stops with syntax error, change both the declaration
	-- of prefix "or" to prefix "+" and the call to `+ Current'.

	make is
		local
			s: STRING;
		do
			s := Current #index 3;
			print (s);
			s := Current #Index 3;
			print (s);
			s := Current #INDEX 3;
			print (s);
			s := + Current;
			print (s);
		end;
	
	g alias "#index" (a: INTEGER): STRING is
		do
			io.putstring ("In lowercase index%N");
			Result := "1";
		end;


	i alias "+": STRING is
		do
			io.putstring ("In  pre");
			Result := "4";
		end;

end 
