
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		local
			tried: BOOLEAN;
		do
			if not tried then
				try;
			end
		rescue
			io.putstring ("In make rescue clause%N");
			tried := True;
			retry;
		end;

	try is
		do
			io.putstring ("Starting try%N");
		ensure
			old weasel
		rescue
			io.putstring ("In try rescue clause%N");
		end
	
	weasel: BOOLEAN is
		local
			tried: BOOLEAN;
		do
			io.putstring ("Raising exception in weasel%N");
			raise ("weasels");
			Result := True;
		end;

end
