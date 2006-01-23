indexing
	description:
		"Test for DATE.date_valid_default"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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

	date_string: STRING;
			-- String representation of date

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class VALIDITY_TEST

