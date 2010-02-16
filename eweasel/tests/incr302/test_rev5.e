
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST

create
	make

feature

	make
		do
			print (x.y); io.new_line
		end

	x: TEST1 [STRING]
		attribute
			create Result
		end
end
