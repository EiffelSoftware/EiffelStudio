indexing
	description:
		"Facilities for accessing default fonts."
	keywords: "font, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_FONTS

feature -- Access

	Screen_font: EV_FONT is
			-- Default screen font.
		once
			create Result
		end

	Dialog_font: EV_FONT is
			-- Font used in dialogs.
		once
			Result := Screen_font
		end

	Menu_font: EV_FONT is
			-- Font used in menus.
		once
			Result := Screen_font
		end

invariant
	Screen_font_not_void: Screen_font /= Void
	Dialog_font_not_void: Dialog_font /= Void
	Menu_font_not_void:Menu_font /= Void

end -- class EV_STOCK_FONTS

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------
