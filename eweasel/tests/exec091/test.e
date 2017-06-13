--| Copyright (c) 1993-2017 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature

	make
		local
			t: TESTER [ANY]
		do
				-- Expanded only with basic values.
			io.put_string ("Basic")
			io.put_new_line
			io.put_string ("0: ")
			create {TESTER [EXPANDED_BASIC]} t
			io.put_string ("1: ")
			t.test
			io.put_new_line

				-- Expanded with reference values.
			io.put_string ("Reference")
			io.put_new_line
			io.put_string ("0: ")
			create {TESTER [EXPANDED_REFERENCE]} t
			io.put_string ("1: ")
			t.test
			io.put_new_line
		end

end
