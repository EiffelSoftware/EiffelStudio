
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

expanded class TEST2
inherit
	ANY
		rename
			default_create as new_create
		redefine
			new_create
		end
create
	new_create

feature
	new_create
		do
			print ("In TEST2 default_create%N")
		end

	n: DOUBLE
end
