indexing 
	description: "EiffelVision password field. A text field%
		% That displays always the same character."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD

inherit
	EV_TEXT_FIELD
		redefine
			make,
			make_with_text,
			implementation
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a text field with, `par' as
			-- parent
		do
			!EV_PASSWORD_FIELD_IMP!implementation.make
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		do
			!EV_PASSWORD_FIELD_IMP!implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Access

	character: CHARACTER is
			-- Displayed character instead of the text.
		require
			exists: not destroyed
		do
			Result := implementation.character
		end

feature -- Element change

	set_character (char: CHARACTER) is
			-- Make `char' the new character displayed in the
			-- password field.
		require
			exists: not destroyed
		do
			implementation.set_character (char)
		end

feature {NONE} -- Implementation

	implementation: EV_PASSWORD_FIELD_I
		-- Implementation

end -- class EV_PASSWORD_FIELD

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
