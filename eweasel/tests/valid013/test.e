
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the error:
	-- Compile classes as is.  Es3 does not complain about the
	-- assignment `attribute_field := x' in feature `test_me' which
	-- becomes invalid in TEST.
	-- Finish_freezing.  Execute `test'.

class 
	TEST
inherit 
	TEST1
create
	make
feature
	
	make
		do
			test_me;
			io.putstring ("Getting ready to call turkey...%N");
			attribute_field.turkey;
			io.putstring ("Nope, did not die%N");
		end;

	weasel (s: STRING)
		do
			io.putstring ("In weasel%N");
			io.putstring (s); io.new_line;
		end;

	turkey
		do
			io.putstring ("In turkey%N");
		end;

end
