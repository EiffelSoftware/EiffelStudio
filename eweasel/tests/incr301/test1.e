
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

expanded class TEST1 [G -> detachable G create default_create end]
inherit
	ANY
		redefine
			default_create
		end

feature
	default_create
		do
			precursor
			create s.default_create
		end

	s: detachable G
		attribute
			s := create {G}
		end

end
