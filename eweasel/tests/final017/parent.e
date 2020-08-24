--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class PARENT
feature
	weasel
		deferred
		end
	
	try
		local
			p: PROCEDURE
		do
			p := agent weasel
			p.call
		end
end
