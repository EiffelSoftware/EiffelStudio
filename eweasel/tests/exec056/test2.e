
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST2
inherit
	SHOW
feature
	weasel
		require else
			test2_precond: show ("TEST2 precondition", True);
		deferred
		ensure then
			test2_postcond: show ("TEST2 postcondition", True);
		end
end
