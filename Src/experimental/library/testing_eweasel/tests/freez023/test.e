
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
			output_value: REAL
		do
			output_value:= multiply ({REAL_32} 1.01, {REAL_32} 2.1)
			print (output_value.out)
			io.new_line
		end
		
	multiply (a_real, another_real: REAL): REAL is
		do
			Result:= a_real * another_real
		ensure
			definition: Result = a_real * another_real
		end
		
end
