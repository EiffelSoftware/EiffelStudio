
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
		redefine
			dispose
		end
	EXCEPTIONS


create
	make

feature
	
	make is
		do
			no_message_on_failure
			io.put_string (Void)
		end

	dispose is
		do
		rescue
		end


end
