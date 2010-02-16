
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST

create
	make

feature

	make
		do
			print (x.generating_type); io.new_line
		end

	x: TEST1
		attribute
			create Result
		end
end
