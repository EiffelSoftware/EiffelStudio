indexing 
	description: "EiffelVision font selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONT_DIALOG_I

inherit
	EV_SELECTION_DIALOG_I

feature -- Access

	font: EV_FONT is
			-- Current selected font.
		require
			exists: not destroyed
		deferred
		end

	character_format: EV_CHARACTER_FORMAT is
			-- Current selected character format.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	select_font (a_font: EV_FONT) is
			-- Select `a_font'.
		require
			exists: not destroyed
		deferred
		end

end -- class EV_FONT_DIALOG_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
