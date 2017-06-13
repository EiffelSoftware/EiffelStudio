--| Copyright (c) 1993-2017 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class EXPANDED_BASIC

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature

	default_create
		do
			io.put_string ("create ")
			item := 47
		end

	item: INTEGER

	show: BOOLEAN
		do
			io.put_string ("invariant")
			io.put_new_line
			Result := item = 47
		end

invariant

	test: show

end
