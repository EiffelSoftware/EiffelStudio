
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit	
	EXECUTION_ENVIRONMENT
	EXCEPTIONS
creation
	make
feature
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
				put ("abc%/0/def", "weasel%/0/stoat")
			end
		rescue
			if exception = Precondition then
				tried := True;
				retry
			end
		end
	
end
