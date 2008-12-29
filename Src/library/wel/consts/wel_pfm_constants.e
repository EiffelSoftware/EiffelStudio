note
	description: "Paragraph format mask (PFM) constants for the rich edit %
		%control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PFM_CONSTANTS

feature -- Access

	Pfm_startindent: INTEGER = 1
			-- The dxStartIndent member is valid.

	Pfm_rightindent: INTEGER = 2
			-- The dxRightIndent member is valid.

	Pfm_offset: INTEGER = 4
			-- The dxStartIndent member is valid and specifies
			-- a relative value.

	Pfm_alignment: INTEGER = 8
			-- The wAlignment member is valid.

	Pfm_tabstops: INTEGER = 16
			-- The cTabStobs and rgxTabStops members are valid.

	Pfm_numbering: INTEGER = 32
			-- The wNumbering member is valid.
			
	Pfm_spacebefore: INTEGER = 64
			-- The dySpaceBefore member is valid.
			
	Pfm_spaceafter: INTEGER = 128
			-- The dySpaceAfter member is valid.
			
	Pfm_linespacing: INTEGER = 256
			-- The dyLineSpacing member is valid.
			
	Pfm_style: INTEGER = 512
			-- The sStyle member is valid.
			
	Pfm_border: INTEGER = 2048
			-- The wBorderSpace, wBorderWidth and wBorders members are valid.
			
	Pfm_shading: INTEGER = 4096
			-- The wShadingStyle and wShadingWeight members arevalid.
			
	Pfm_numberingstyle: INTEGER = 8092
			-- The wNumberingStyle member is valid.
			
	Pfm_numberingtab: INTEGER = 16384
			-- The wNumberingTab member is valid.
			
	Pfm_numberingstart: INTEGER = 32768
			-- The wNumberingStart member is valid.

	Pfm_offsetindent: INTEGER = -2147483648;
			-- The dxOffset member is valid.

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




end -- class WEL_PFM_CONSTANTS

