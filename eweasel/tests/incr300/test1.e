
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST1 [G -> ANY create default_create end]

feature
	weasel: G
		require
			valid: create {like a} /= Void
		do
		end

	a: G

end
