indexing
	description: "Font quality constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_QUALITY_CONSTANTS

feature -- Access

	Default_quality: INTEGER is 0
			-- Appearance of the font does not matter.

	Draft_quality: INTEGER is 1
			-- Appearance of the font is less important than when
			-- the `Proof_quality' value is used. For GDI raster
			-- fonts, scaling is enabled. Bold, italic, underline,
			-- and strikeout fonts are synthesized if necessary.

	Proof_quality: INTEGER is 2
			-- Character quality of the font is more important
			-- than exact matching of the logical-font attributes.
			-- For GDI raster fonts, scaling is disabled and the
			-- font closest in size is chosen. Bold, italic,
			-- underline, and strikeout fonts are synthesized
			-- if necessary.

end -- class WEL_FONT_QUALITY_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

