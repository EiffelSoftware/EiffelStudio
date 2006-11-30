
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the error:
	-- Compile classes as is.  Es3 does not complain about the
	-- assignment `attribute := x' in feature `test_me' which
	-- becomes invalid in TEST.
	-- Finish_freezing.  Execute `test'.

class 
	TEST
inherit 
	TEST1
creation
	make
feature
	
	make is
		do
			test_me;
			io.putstring ("Getting ready to call turkey...%N");
			attribute.turkey;
			io.putstring ("Nope, did not die%N");
		end;

	weasel (s: STRING) is
		do
			io.putstring ("In weasel%N");
			io.putstring (s); io.new_line;
		end;

	turkey is
		do
			io.putstring ("In turkey%N");
		end;

end
