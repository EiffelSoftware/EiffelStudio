
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class XY2 
inherit
	XY
		redefine
			f
		end
	X
		undefine
			f
		end

	Y
		undefine
			f
		end

feature
	f
		do
			print ("XY2.f%N")
		end

end
