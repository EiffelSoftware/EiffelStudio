indexing
	description	: "Facilities for accessing default pixmaps."
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_DEFAULT_PIXMAPS_IMP

feature -- Access

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		local
			pixmap_imp: EV_PIXMAP_IMP
			gdk_pixmap: POINTER
		do
			create Result
			pixmap_imp ?= Result.implementation
			gdk_pixmap := information_pixmap_xpm
			gdk_pixmap := C.gdk_pixmap_create_from_xpm_d (
				C.gdk_root_parent,
				Default_pointer,
				Default_pointer,
				error_pixmap_xpm
			)
			pixmap_imp.set_pixmap (gdk_pixmap, Default_pointer)
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		do
			--| FIXME: To be implemented
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		do
			--| FIXME: To be implemented
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		do
			--| FIXME: To be implemented
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
				-- Create a default pixmap
			create Result
			pixmap_imp ?= Result.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_default
		end

feature {NONE} -- Externals

	C: EV_C_EXTERNALS is
		once
			create Result
		end

	information_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"information_pixmap_xpm"
		end

	error_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"error_pixmap_xpm"
		end

	warning_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"warning_pixmap_xpm"
		end

	question_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"question_pixmap_xpm"
		end

end -- class EV_DEFAULT_PIXMAPS_IMP

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
--| Revision 1.3  2000/05/03 21:34:49  king
--| Added default_pixmap externals
--|
--| Revision 1.2  2000/05/03 17:51:13  brendel
--| Added pixmap_imp.
--|
--| Revision 1.1  2000/05/03 16:37:22  pichery
--| New default pixmaps GTK implementation
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

