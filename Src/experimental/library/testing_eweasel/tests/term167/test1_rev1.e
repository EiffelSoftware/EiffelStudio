
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST1 [G -> NUMERIC create default_create end]

feature
	hamster alias "##" (val: ANY): G
		do
			Result := create {G}
		end

end
