indexing
	description: "Contains information that a rich edit control uses to %
		%format its output for a particular device."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FORMAT_RANGE

inherit
	WEL_STRUCTURE

creation
	make,
	make_by_pointer

feature -- Access

	rect: WEL_RECT is
			-- Area to render to.
			-- Units are in TWIPS.
		do
			create Result.make_by_pointer (
				cwel_formatrange_get_rc (item))
		ensure
			result_not_void: Result /= Void
		end

	rect_page: WEL_RECT is
			-- Entire area of rendering device.
			-- Units are in TWIPS.
		do
			create Result.make_by_pointer (
				cwel_formatrange_get_rcpage (item))
		ensure
			result_not_void: Result /= Void
		end

	character_range: WEL_CHARACTER_RANGE is
			-- Range of text to format
		do
			create Result.make_by_pointer (
				cwel_formatrange_get_chrg (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_dc (a_dc: WEL_DC) is
			-- Set the device to render to.
		require
			a_dc_not_void: a_dc /= Void
		do
			cwel_formatrange_set_hdc (item, a_dc.item)
		end

	set_dc_target (a_dc: WEL_DC) is
			-- Set the target device to format for.
		require
			a_dc_not_void: a_dc /= Void
		do
			cwel_formatrange_set_hdctarget (item, a_dc.item)
		end

	set_rect (a_rect: WEL_RECT) is
			-- Set `rect' with `a_rect'.
			-- Units are in TWIPS.
		require
			a_rect_not_void: a_rect /= Void
		do
			cwel_formatrange_set_rc (item, a_rect.item)
		end

	set_rect_page (a_rect: WEL_RECT) is
			-- Set `rect_page' with `a_rect'.
			-- Units are in TWIPS.
		require
			a_rect_not_void: a_rect /= Void
		do
			cwel_formatrange_set_rcpage (item, a_rect.item)
		end

	set_character_range (a_character_range: WEL_CHARACTER_RANGE) is
			-- Set `character_range' with `a_character_range'.
		require
			a_character_range_not_void: a_character_range /= Void
		do
			cwel_formatrange_set_chrg (item, a_character_range.item)
		end

	set_range (min, max: INTEGER) is
			-- Set the range with `min' and `max'.
		require
			valid_min_max: max >= min
		local
			cr: WEL_CHARACTER_RANGE
		do
			create cr.make (min, max)
			cwel_formatrange_set_chrg (item, cr.item)
		ensure
			set_min: character_range.minimum = min
			set_max: character_range.maximum = max
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_formatrange
		end

feature {NONE} -- Externals

	c_size_of_formatrange: INTEGER is
		external
			"C [macro <frange.h>]"
		alias
			"sizeof (FORMATRANGE)"
		end

	cwel_formatrange_set_hdc (ptr: POINTER; value: POINTER) is
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_hdctarget (ptr: POINTER; value: POINTER) is
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_rc (ptr: POINTER; value: POINTER) is
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_rcpage (ptr: POINTER; value: POINTER) is
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_chrg (ptr: POINTER; value: POINTER) is
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_get_rc (ptr: POINTER): POINTER is
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

	cwel_formatrange_get_rcpage (ptr: POINTER): POINTER is
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

	cwel_formatrange_get_chrg (ptr: POINTER): POINTER is
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

end -- class WEL_FORMAT_RANGE


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

