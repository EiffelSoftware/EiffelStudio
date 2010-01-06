
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
			double_value: DOUBLE
			temp_ptr: POINTER
			buffer: POINTER
		do
			buffer := buffer.memory_alloc (8)
			buffer.memory_copy ($double_value, 8)
			double_value := 1.0
			temp_ptr := $double_value
			temp_ptr.memory_copy (buffer, 8)
			print (double_value)
			io.new_line
		end 

end
