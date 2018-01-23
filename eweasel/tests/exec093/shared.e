--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHARED

feature

	show (s: STRING): BOOLEAN
		do
			;(0).io.putstring (s)
			;(0).io.new_line
			Result := True
		ensure
			is_class: class
		end

end
