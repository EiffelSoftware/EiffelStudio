
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class Y2
inherit
	Y
		redefine
			f
		end

feature
	f
		do
			print ("Y2.f%N")
		end

end
