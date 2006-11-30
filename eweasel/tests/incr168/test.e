
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
inherit
	TEST1
		redefine
			feat
		end
	TEST2
		redefine
			feat
		end
	$PARENT
creation
	make
feature

	make is
		do
			print (feat); io.new_line
		end;

	feat: BOOLEAN is
		require else
			impossible: false
		do
			io.putstring ("In redefined feat%N");
			Result := True
		end;
end
