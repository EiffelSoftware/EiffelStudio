
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
	EXCEPTIONS
creation
	make
feature
	make is
		local
			tried: BOOLEAN;
		do
			collection_off;
			if not tried then
				try;
			end
		rescue
			io.putstring ("In make rescue clause%N");
			tried := True;
			display_exception_status;
			retry;
		end;

	try is
		local
			b: BOOLEAN
		do
			io.putstring ("Starting try%N");
			b := weasel;
		rescue
			io.putstring ("In try rescue clause%N");
			display_exception_status;
		end
	
	weasel: BOOLEAN is
		local
			tried: BOOLEAN;
		do
			io.putstring ("Starting weasel%N");
			io.putstring ("Raising exception%N");
			raise ("weasels");
			Result := True;
		end;

	display_exception_status is
		do
			io.putstring ("Assertion violation: ");
			io.putbool (assertion_violation); io.new_line;
			io.putstring ("Original exception: ");
			io.putint (original_exception); io.new_line;
			io.putstring ("Exception: ");
			io.putint (exception); io.new_line;
			io.putstring ("Meaning of original exception: ");
			show (meaning (original_exception));
			io.new_line;
			io.putstring ("Meaning of exception: ");
			show (meaning (exception));
			io.new_line;
		end

	show (s: STRING) is
		do
			if s /= Void then
				io.putstring (s);
			else
				io.putstring ("(not available)");
			end
		end
	
end
