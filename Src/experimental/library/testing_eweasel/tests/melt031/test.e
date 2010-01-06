
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
			b: BOOLEAN;
		do
			b := try;
		end;

	try: BOOLEAN is
		local
			tried: BOOLEAN;
		do
			io.putstring ("Starting try%N");
			if not tried then
				io.putstring ("Raising exception%N");
				raise ("weasels");
			end
			Result := True;
		ensure	
			post: old weasel;
		rescue
			io.putstring ("In rescue clause%N");
			tried := True;
			retry;
		end
	
	weasel: BOOLEAN is
		do
			io.putstring ("Evaluating weasel%N");
			Result := True;
		end;

end
