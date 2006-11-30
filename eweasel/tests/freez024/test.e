
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature

	my_const: INTEGER_8 is 0x8f

	make is
   		local
       			i: INTEGER_8
   		do
       			i := my_const
       			inspect i
       			when my_const then
           			print ("Inspect OK%N")
       			else
           			print ("Inspect Wrong%N")
       			end
       			if i = my_const then
           			print ("If OK%N")
       			else
           			print ("If Wrong%N")
       			end
		end

end
