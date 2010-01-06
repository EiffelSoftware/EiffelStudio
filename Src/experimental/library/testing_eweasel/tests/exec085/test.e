
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS;
creation
	make
feature
	make is
		local
			tried: BOOLEAN;
		do
			if not tried then
				weasel;
			end
		rescue
			io.putstring ("In make rescue clause%N");
			display_exception_status;
			tried := True;
			retry;
		end;

	weasel is
		require
			false
		do
		end
	
	display_exception_status is
		do
			io.putstring ("Original exception: ");
			io.putint (original_exception); io.new_line;
			io.putstring ("Exception: ");
			io.putint (exception); io.new_line;
			io.putstring ("Meaning of original exception: ");
			show (meaning (original_exception));
			io.new_line;
			io.putstring ("Original exception: ");
			io.putint (original_exception); io.new_line;
			io.putstring ("Exception: ");
			io.putint (exception); io.new_line;
			io.putstring ("Meaning of exception: ");
			show (meaning (exception));
			io.new_line;
		end

	show (s: STRING) is
		local
			tried: BOOLEAN;
		do
			if not tried then
				io.putstring (s);
			end
		rescue
			io.putstring ("(not available)");
			tried := True;
			retry;
		end
	
end
