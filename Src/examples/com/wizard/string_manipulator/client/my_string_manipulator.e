indexing
	description: "String Manipulator"

class
	MY_STRING_MANIPULATOR

inherit
	STRING_MANIPULATOR_PROXY
		redefine
			replace_substring_user_precondition
		end

creation
	make,
	make_from_other,
	make_from_pointer

feature -- Status Report

	replace_substring_user_precondition (s: STRING; start_pos: INTEGER; end_pos: INTEGER): BOOLEAN is
			-- User-defined preconditions for `replace_substring'.
		do
			Result := start_pos <= end_pos and
					start_pos > 0
		end

end -- MY_STRING_MANIPULATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-2001.
--| Modifications and extensions: copyright (C) ISE, 2001.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

