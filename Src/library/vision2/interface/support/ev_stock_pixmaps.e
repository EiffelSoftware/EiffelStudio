indexing
	description	: "Facilities for accessing default pixmaps."
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_DEFAULT_PIXMAPS

feature -- Access

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		do
			Result := default_pixmaps_imp.Information_pixmap
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		do
			Result := default_pixmaps_imp.Error_pixmap
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		do
			Result := default_pixmaps_imp.Warning_pixmap
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		do
			Result := default_pixmaps_imp.Question_pixmap
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		do
			Result := default_pixmaps_imp.Default_window_icon
		end

feature {NONE} -- Implementation

	default_pixmaps_imp: EV_DEFAULT_PIXMAPS_IMP is
			-- Responsible for interaction with the native graphics toolkit.
		once
			create Result
		end

end -- class EV_DEFAULT_PIXMAPS

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/05/03 16:31:21  pichery
--| Platform independant default pixmaps
--|
--| Revision 1.2  2000/05/03 00:23:57  pichery
--| Added default window pixmap.
--|
--| Revision 1.1  2000/04/29 03:21:55  pichery
--| Added new class with Default pixmaps
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

