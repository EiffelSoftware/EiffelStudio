
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			io.putstring ("In TEST1 make%N");
		end;

	weasel: BOOLEAN is 
		do
			io.putstring ("In weasel%N");
			Result := True;
		end
end
