
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST1
inherit
	ANY
		undefine
			default_rescue
		end
			
feature
	f is
		do
			print ($default_rescue); io.new_line
		end


end
