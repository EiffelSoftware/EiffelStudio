
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	try is
		local
			z: like Current
		do
			x := create {like Current}
			print (x.generating_type)
			io.new_line
			
			print ((create {like Current}).generating_type)
			io.new_line
			
			create x
			print (x.generating_type); 
			io.new_line
			
			z := create {like Current}
			print (x.generating_type)
			io.new_line
			
			create z
			print (z.generating_type); 
			io.new_line
		end

	x: like Current
	
end
