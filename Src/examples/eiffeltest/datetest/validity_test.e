indexing
	description:
		"Test for DATE.date_valid_default"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class VALIDITY_TEST inherit

	TEST_CASE

	EXCEPTIONS
		export
			{NONE} all
		end

create

	make

feature -- Access

	Name: STRING is "Validity test"

feature -- Status setting

	set_date_string (s: STRING) is
			-- Set date string to `s'.
		require
			non_empty_string: s /= Void and then not s.empty
		do
			date_string := s
		ensure
			string_set: date_string = s
		end

feature -- Basic operations

	do_test is
			-- Execute test.
		local
			d: DATE
		do
			if date_string = Void then
				raise ("No date set")
			end
			create d.make_now
			assert (d.date_valid_default (date_string), "Date valid?")
		end

feature {NONE} -- Implementation

	date_string: STRING
			-- String representation of date

end -- class VALIDITY_TEST

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
