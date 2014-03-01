
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation

	make

feature

	make is
		local
			r: $REAL_TYPE
		do
			r := value (i8)
			io.put_double (r)
			io.new_line
		end

	i8: INTEGER_8 is 127

	value (r: DOUBLE): like r is
		do
			Result := r.truncated_to_real
		end

end
