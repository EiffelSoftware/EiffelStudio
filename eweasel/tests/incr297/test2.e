
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST2 [G -> TEST3 create default_create end]
inherit
	ANY
		redefine
			default_create
		end
create
	default_create

feature
	default_create
		do
			create n
		end

	n: G
end
