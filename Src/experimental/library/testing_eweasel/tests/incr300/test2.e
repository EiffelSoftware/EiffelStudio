
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			print ("In TEST2 default_create%N")
		end

	n: DOUBLE
end
