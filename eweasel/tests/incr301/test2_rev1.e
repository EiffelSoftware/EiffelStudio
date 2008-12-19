
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

expanded class TEST2 [G -> POINTER create default_create end]
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			n := $default_create
		end

	n: G
end
