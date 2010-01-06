
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A

create
	make, default_create

feature
	make is
		do
			if once_value /= Void then
				print ("Not Void")
			else
				print ("Void")
			end
			io.new_line
		end

feature
	once_value: A is
		once
			create Result.make
		end

end
