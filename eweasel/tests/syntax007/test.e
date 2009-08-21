
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature
	
	make is
		local
			s: STRING;
			c: CHARACTER;
			n: INTEGER;
			r: REAL;
			d: DOUBLE;
		do
			-------------------------------------------------
			-- Not accepted, but book says they should be:
			
			c := '%/15/';
			s := "%/15/";
			n := 12_383;
			r := {REAL_32} 12_383.;
			r := {REAL_32} 12_383.123_456;
			d := 12_383.;
			d := 12_383.123_456;
			-------------------------------------------------
		end;
	
end 
