
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST1 [G -> HASHABLE]
create
	default_create

feature
	y: G
		attribute
			create Result
		end
end
