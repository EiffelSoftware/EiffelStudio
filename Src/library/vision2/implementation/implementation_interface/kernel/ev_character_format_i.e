indexing
	description:
		"EiffelVision character format,implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHARACTER_FORMAT_I

inherit
	EV_ANY_I

feature -- Access

	font: EV_FONT is
			-- Font of the current format
		require
			exists: not destroyed
		deferred
		end

	color: EV_COLOR is
			-- Color of the current format
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	is_bold: BOOLEAN is
			-- Is the character bold?
		require
			exists: not destroyed
		deferred
		end

	is_italic: BOOLEAN is
			-- Is the character in italic?
		require
			exists: not destroyed
		deferred
		end

	is_underline: BOOLEAN is
			-- Is the character underline?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_bold (flag: BOOLEAN) is
			-- Set bold characters if `flag', unset otherwise.
		require
			exists: not destroyed
		deferred
		ensure
			flag_set: (flag implies is_bold) and 
						(not flag implies not is_bold)
		end

	set_italic (flag: BOOLEAN) is
			-- Set italic characters if `flag', unset otherwise.
		require
			exists: not destroyed
		deferred
		ensure
			flag_set: (flag implies is_italic) and 
						(not flag implies not is_italic)
		end

	set_underline (flag: BOOLEAN) is
			-- Set underline characters if `flag', unset otherwise.
		require
			exists: not destroyed
		deferred
		ensure
			flag_set: (flag implies is_underline) and 
						(not flag implies not is_underline)
		end

feature -- Element change

	set_font (value: EV_FONT) is
			-- Make `value' the new font.
		require
			exists: not destroyed
			valid_font: is_valid (value)
		deferred
		ensure
--			font_set: font = value
		end

	set_color (value: EV_COLOR) is
			-- Make `value' the new color.
		require
			exists: not destroyed
			valid_color: is_valid (value)
		deferred
		ensure
			color_set: color.equal_color (value)
		end

end -- class EV_CHARACTER_FORMAT_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
