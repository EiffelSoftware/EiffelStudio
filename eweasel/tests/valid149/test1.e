--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	try: INTEGER is
		external "C inline"
		alias "29"
		ensure
			is_class: class
		end

end
