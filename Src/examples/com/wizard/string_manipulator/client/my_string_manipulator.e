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
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
