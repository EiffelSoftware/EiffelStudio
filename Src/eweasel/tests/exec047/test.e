
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			exp_test2.exp_test1.set_string ("wimp");
			show (exp_test2.exp_test1.string);
			set ("weasel");
			show (test1_ref.string);
			show (exp_test2.exp_test1.string);
			set ("hamster");
			show (test1_ref.string);
			show (exp_test2.exp_test1.string);
		end
	
	set (val: STRING) is
		do
			test1_ref := exp_test2.test1_ref;
			test1_ref.set_string (val);
		end
	
	show (val: STRING) is
		do
			if val /= Void then
				io.putstring (val);
			else
				io.putstring ("*** Void ***");
			end
			io.new_line;
		end
	
	exp_test2: expanded TEST2;
	
	test1_ref: TEST1;
end
