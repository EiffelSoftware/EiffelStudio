indexing
	description: "Font quality constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_QUALITY_CONSTANTS

feature -- Access

	Default_quality: INTEGER is
			-- Appearance of the font does not matter.
		external
			"C [macro <wel.h>]"
		alias
			"DEFAULT_QUALITY"
		end

	Draft_quality: INTEGER is
			-- Appearance of the font is less important than when
			-- the `Proof_quality' value is used. For GDI raster
			-- fonts, scaling is enabled. Bold, italic, underline,
			-- and strikeout fonts are synthesized if necessary.
		external
			"C [macro <wel.h>]"
		alias
			"DRAFT_QUALITY"
		end

	Proof_quality: INTEGER is
			-- Character quality of the font is more important
			-- than exact matching of the logical-font attributes.
			-- For GDI raster fonts, scaling is disabled and the
			-- font closest in size is chosen. Bold, italic,
			-- underline, and strikeout fonts are synthesized
			-- if necessary.
		external
			"C [macro <wel.h>]"
		alias
			"PROOF_QUALITY"
		end

end -- class WEL_FONT_QUALITY_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
