indexing
	description: "Font quality constants."
	legal: "See notice at end of class."
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

	Proof_quality: INTEGER is 2;
			-- Character quality of the font is more important
			-- than exact matching of the logical-font attributes.
			-- For GDI raster fonts, scaling is disabled and the
			-- font closest in size is chosen. Bold, italic,
			-- underline, and strikeout fonts are synthesized
			-- if necessary.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_FONT_QUALITY_CONSTANTS

