
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
		require
			weasel
		local
			tried: BOOLEAN;
		do
			io.putstring ("Starting try%N");
			Result := True;
		end
	
	weasel: BOOLEAN is
		require
			show ("Evaluating weasel precondition%N")
		local
			tried: BOOLEAN;
		do
			io.putstring ("Evaluating weasel%N");
			if not tried then
				io.putstring ("Raising exception%N");
				raise ("weasels");
			end
			Result := True;
		rescue
			io.putstring ("In rescue clause%N");
			tried := True;
			retry;
		end;

	show (s: STRING): BOOLEAN is
		do
			io.putstring (s);
			Result := True;
		end

end
