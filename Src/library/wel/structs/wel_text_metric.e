indexing
	description: "Contains basic information about a physical font. All %
		%size are given in logical units; that is, they depend on the %
		%current mapping mode of the display context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEXT_METRIC

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (dc: WEL_DC) is
			-- Make a text metrics structure for `dc'.
		require
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		do
			structure_make
			cwin_get_text_metric (dc.item, item)
		end

feature -- Access

	height: INTEGER is
			-- Height (ascent + descent) of characters
		do
			Result := cwel_text_metric_get_tmheight (item)
		end

	ascent: INTEGER is
			-- Ascent (units above the base line) of characters
		do
			Result := cwel_text_metric_get_tmascent (item)
		end

	descent: INTEGER is
			-- Descent (units below the base line) of characters
		do
			Result := cwel_text_metric_get_tmdescent (item)
		end

	internal_leading: INTEGER is
			-- Amount of leading (space) inside the bounds set by
			-- `height'
		do
			Result := cwel_text_metric_get_tminternalleading (item)
		end

	external_leading: INTEGER is
			-- Amount of extra leading (space) that the application
			-- adds between rows
		do
			Result := cwel_text_metric_get_tmexternalleading (item)
		end

	average_character_width: INTEGER is
			-- Average width of characters in the font (generally
			-- defined as the width of the letter x)
		do
			Result := cwel_text_metric_get_tmavecharwidth (item)
		end

	maximum_character_width: INTEGER is
			-- Width of the widest character in the font
		do
			Result := cwel_text_metric_get_tmmaxcharwidth (item)
		end

	weight: INTEGER is
			-- Weight of the font.
			-- See class WEL_FW_CONSTANTS for values.
		do
			Result := cwel_text_metric_get_tmweight (item)
		end

	overhang: INTEGER is
			-- Extra width per string that may be added to some
			-- synthesized fonts
		do
			Result := cwel_text_metric_get_tmoverhang (item)
		end

	digitized_aspect_x: INTEGER is
			-- Horizontal aspect of the device for which the
			-- font was designed
		do
			Result := cwel_text_metric_get_tmdigitizedaspectx (item)
		end

	digitized_aspect_y: INTEGER is
			-- Vertical aspect of the device for which the font
			-- was designed
		do
			Result := cwel_text_metric_get_tmdigitizedaspecty (item)
		end

	first_character: INTEGER is
			-- Value of the first character defined in the font
		do
			Result := cwel_text_metric_get_tmfirstchar (item)
		end

	last_character: INTEGER is
			-- Value of the last character defined in the font
		do
			Result := cwel_text_metric_get_tmlastchar (item)
		end

	default_character: INTEGER is
			-- Value of the character to be substituted for
			-- characters not in the font
		do
			Result := cwel_text_metric_get_tmdefaultchar (item)
		end

	break_character: INTEGER is
			-- Value of the character that will be used to define
			-- word breaks for text justification
		do
			Result := cwel_text_metric_get_tmbreakchar (item)
		end

	italic: INTEGER is
			-- Italic font if it is nonzero
		do
			Result := cwel_text_metric_get_tmitalic (item)
		end

	underlined: INTEGER is
			-- Underlined font if it is nonzero
		do
			Result := cwel_text_metric_get_tmunderlined (item)
		end

	struckout: INTEGER is
			-- Strikeout font if it is nonzero
		do
			Result := cwel_text_metric_get_tmstruckout (item)
		end

	pitch_and_family: INTEGER is
			-- Information about the pitch, the technology, and
			-- the family of a physical font.
			-- See class WEL_TMPF_CONSTANTS for values.
		do
			Result := cwel_text_metric_get_tmpitchandfamily (item)
		end

	character_set: INTEGER is
			-- Character set of the font
		do
			Result := cwel_text_metric_get_tmcharset (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_text_metric
		end

feature {NONE} -- Externals

	c_size_of_text_metric: INTEGER is
		external
			"C [macro <tmetric.h>]"
		alias
			"sizeof (TEXTMETRIC)"
		end

	cwel_text_metric_get_tmheight (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmascent (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdescent (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tminternalleading (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmexternalleading (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmavecharwidth (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmmaxcharwidth (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmweight (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmoverhang (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdigitizedaspectx (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdigitizedaspecty (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmfirstchar (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmlastchar (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdefaultchar (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmbreakchar (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmitalic (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmunderlined (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmstruckout (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmpitchandfamily (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmcharset (ptr: POINTER): INTEGER is
		external
			"C [macro <tmetric.h>]"
		end

	cwin_get_text_metric (hdc, ptr: POINTER) is
			-- SDK GetTextMetrics
		external
			"C [macro <wel.h>] (HDC, LPTEXTMETRIC)"
		alias
			"GetTextMetrics"
		end

end -- class WEL_TEXT_METRIC


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

