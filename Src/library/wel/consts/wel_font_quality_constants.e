note
	description: "Font quality constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_QUALITY_CONSTANTS

feature -- Access

	Default_quality: INTEGER = 0
			-- Appearance of the font does not matter.

	Draft_quality: INTEGER = 1
			-- Appearance of the font is less important than when
			-- the `Proof_quality' value is used. For GDI raster
			-- fonts, scaling is enabled. Bold, italic, underline,
			-- and strikeout fonts are synthesized if necessary.

	Proof_quality: INTEGER = 2
			-- Character quality of the font is more important
			-- than exact matching of the logical-font attributes.
			-- For GDI raster fonts, scaling is disabled and the
			-- font closest in size is chosen. Bold, italic,
			-- underline, and strikeout fonts are synthesized
			-- if necessary.

	non_antialiased_quality: INTEGER = 3
			-- Font is never antialiased.

	antialiased_quality: INTEGER = 4
			-- Windows NT 4.0 and later: Font is always antialiased if the font supports it and
			-- the size of the font is not too small or too large. 
			-- Windows 95 Plus!, Windows 98/Me: The display must greater than 8-bit color,
			-- it must be a single plane device, it cannot be a palette display, and it cannot be
			-- in a multiple display monitor setup. In addition, you must select a TrueType font
			-- into a screen DC prior to using it in a DIBSection, otherwise antialiasing does not occur.

	cleartype_quality: INTEGER = 5;
			-- Windows XP: If set, text is rendered (when possible) using ClearType antialiasing method.

note
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

