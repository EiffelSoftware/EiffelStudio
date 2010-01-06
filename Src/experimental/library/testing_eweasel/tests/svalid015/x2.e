
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class XY 
inherit
	X
		undefine
			f
		end
	Y
		select
			f
		end

feature
	f
		do
			print ("XY.f%N")
		end

end
