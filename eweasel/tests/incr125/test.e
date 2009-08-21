
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make (args: ARRAY [STRING]) is
		local
			i: INTEGER;
			r: REAL;
			d: DOUBLE;
		do
			i := 47;
			r := {REAL_32} 47.25;
			d := 47.5;
			
			ia := 47;
			ra := {REAL_32} 47.25;
			da := 47.5;
			
			weasel1 (47);
			weasel1 (Constant1);
			weasel1 (i);
			weasel1 (ia);
			
			weasel2 (47);
			weasel2 (Constant1);
			weasel2 (i);
			weasel2 (ia);
			
			wimp1 (47);
			wimp1 (Constant1);
			wimp1 (Constant2);
			wimp1 ({REAL_32} 47.5);
			wimp1 (i);
			wimp1 (r);
			wimp1 (ia);
			wimp1 (ra);
			
			hamster (47);
			hamster (Constant1);
			hamster (Constant2);
			hamster (Constant3);
			hamster (i);
			hamster (r);
			hamster (d);
			hamster (ia);
			hamster (ra);
			hamster (da);
			
			weasel3 (47);
			weasel3 (Constant1);
			weasel3 (i);
			weasel3 (ia);
			
			wimp2 (47);
			wimp2 (Constant1);
			wimp2 (Constant2);
			wimp2 ({REAL_32} 47.5);
			wimp2 (i);
			wimp2 (r);
			wimp2 (ia);
			wimp2 (ra);
			
			turkey (47);
			turkey (Constant1);
			turkey (Constant2);
			turkey (Constant3);
			turkey (47.5);
			turkey (i);
			turkey (r);
			turkey (d);
			turkey (ia);
			turkey (ra);
			turkey (da);
		end
	
	ia: INTEGER;
	ra: REAL;
	da: DOUBLE;

	weasel1 (arg: $ARG_TYPE1 ) is
		do
			print (arg); io.new_line;
		end
	
	weasel2 (arg: $ARG_TYPE2 ) is
		do
			print (arg); io.new_line;
		end
	
	weasel3 (arg: $ARG_TYPE3 ) is
		do
			print (arg); io.new_line;
		end
	
	wimp1 (arg: $ARG_TYPE4 ) is
		do
			print (arg); io.new_line;
		end
	
	wimp2 (arg: $ARG_TYPE5 ) is
		do
			print (arg); io.new_line;
		end
	
	turkey (arg: $ARG_TYPE6 ) is
		do
			print (arg); io.new_line;
		end
	
	hamster (arg: $ARG_TYPE7 ) is
		do
			print (arg); io.new_line;
		end

	Constant1: INTEGER is 47;
	Constant2: REAL is 47.25;
	Constant3: DOUBLE is 47.5;
end
