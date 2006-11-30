
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class PARENT
feature
	weasel is
		deferred
		end
	
	try is
		local
			p: PROCEDURE [like Current, TUPLE]
		do
			p := ~weasel
			p.call (Void)
		end
end
