
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler won't accept standard operator
	-- name which has one or more characters in uppercase.

class TEST
	
creation
	make
feature
	
	make is
		do
			print (Current OR Current); io.new_line;
			print (Current OR ELSE Current); io.new_line;
			print (Current AND Current); io.new_line;
			print (Current AND THEN Current); io.new_line;
			print (Current IMPLIES Current); io.new_line;
			print (Current XOR Current); io.new_line;
			print (Current #XOR Current); io.new_line;
			print (Current.negated); io.new_line;
			print (NOT Current); io.new_line;
			print (#NOT Current); io.new_line;
		end;

	disjuncted alias "OR" (arg: like Current): like Current is
		do
		end;

	disjuncted_semistrict alias "OR ElsE" (arg: like Current): like Current is
		do
		end;
	
	conjuncted alias "aNd" (arg: like Current): like Current is
		do
		end

	conjuncted_semistrict alias "aNd Then" (arg: like Current): like Current is
		do
		end

	implication alias "IMpliES" (arg: like Current): like Current is
		do
		end

	disjuncted_exclusive alias "XOr" (arg: like Current): like Current is
		do
		end

	disjuncted_exclusive_sharp alias "#XOr" (arg: like Current): like Current is
		do
		end

	negated alias "NoT": like Current is
		do
		end

	negated_sharp alias "#NoT": like Current is
		do
		end

end

