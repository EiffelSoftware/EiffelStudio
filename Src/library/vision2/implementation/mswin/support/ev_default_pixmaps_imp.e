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
			icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Icon.
			create icon.make_by_predefined_id (
				Idi_constants.Idi_information
				)
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_icon (icon)
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		local
			pixmap_imp: EV_PIXMAP_IMP
			icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Icon.
			create icon.make_by_predefined_id (
				Idi_constants.Idi_error
				)
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_icon (icon)
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		local
			pixmap_imp: EV_PIXMAP_IMP
			icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Icon.
			create icon.make_by_predefined_id (
				Idi_constants.Idi_warning
				)
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_icon (icon)
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		local
			pixmap_imp: EV_PIXMAP_IMP
			icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Icon.
			create icon.make_by_predefined_id (
				Idi_constants.Idi_question
				)
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_icon (icon)
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		local
			pixmap_imp: EV_PIXMAP_IMP
			icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_default
		end

feature {NONE} -- Constants

	Idi_constants: WEL_IDI_CONSTANTS is
		once
			create Result
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
--| Revision 1.1  2000/05/03 16:35:40  pichery
--| New default pixmaps platform independent implementation
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

