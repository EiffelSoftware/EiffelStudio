
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
		do
			try;
		end;

	try is
		do
			io.putstring ("Starting try%N");
			check
				show ("Evaluating try check assertion%N")
				weasel
			end
		end
	
	weasel: BOOLEAN is
		local
			tried: BOOLEAN;
		do
			io.putstring ("Starting weasel%N");
			if not tried then
				check
					show ("Evaluating weasel check assertion%N")
					wimp
				end
				io.putstring ("Raising exception%N");
				raise ("weasels");
			end
			print (wimp); io.new_line;
			Result := True;
		rescue
			io.putstring ("In weasel rescue clause%N");
			tried := True;
			retry;
		end;

	wimp: BOOLEAN is
		do
			io.putstring ("Starting wimp%N");
			check
				show ("Evaluating wimp check assertion%N")
			end
			Result := True;
		end;

	show (s: STRING): BOOLEAN is
		do
			io.putstring (s);
			Result := True;
		end

end
