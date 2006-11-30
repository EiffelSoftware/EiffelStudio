
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST1
feature
	make is
		$BODY1
		end

	f is
		deferred
		end

invariant
	
	(create {STRING}.make (0)).count = 0
end
