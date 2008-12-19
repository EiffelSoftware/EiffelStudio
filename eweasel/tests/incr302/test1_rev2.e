
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST1 [G]
create
	default_create

feature
	y: G
		attribute
			create Result.make (3)
		end
end
