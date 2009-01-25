note
	description: "Contains information that a rich edit control uses to %
		%format its output for a particular device."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FORMAT_RANGE

inherit
	WEL_STRUCTURE

create
	make,
	make_by_pointer

feature -- Access

	rect: WEL_RECT
			-- Area to render to.
			-- Units are in TWIPS.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_formatrange_get_rc (item))
		ensure
			result_not_void: Result /= Void
		end

	rect_page: WEL_RECT
			-- Entire area of rendering device.
			-- Units are in TWIPS.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_formatrange_get_rcpage (item))
		ensure
			result_not_void: Result /= Void
		end

	character_range: WEL_CHARACTER_RANGE
			-- Range of text to format
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_formatrange_get_chrg (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_dc (a_dc: WEL_DC)
			-- Set the device to render to.
		require
			exists: exists
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			cwel_formatrange_set_hdc (item, a_dc.item)
		end

	set_dc_target (a_dc: WEL_DC)
			-- Set the target device to format for.
		require
			exists: exists
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			cwel_formatrange_set_hdctarget (item, a_dc.item)
		end

	set_rect (a_rect: WEL_RECT)
			-- Set `rect' with `a_rect'.
			-- Units are in TWIPS.
		require
			exists: exists
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
		do
			cwel_formatrange_set_rc (item, a_rect.item)
		end

	set_rect_page (a_rect: WEL_RECT)
			-- Set `rect_page' with `a_rect'.
			-- Units are in TWIPS.
		require
			exists: exists
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
		do
			cwel_formatrange_set_rcpage (item, a_rect.item)
		end

	set_character_range (a_character_range: WEL_CHARACTER_RANGE)
			-- Set `character_range' with `a_character_range'.
		require
			exists: exists
			a_character_range_not_void: a_character_range /= Void
			a_character_range_exists: a_character_range.exists
		do
			cwel_formatrange_set_chrg (item, a_character_range.item)
		end

	set_range (min, max: INTEGER)
			-- Set the range with `min' and `max'.
		require
			exists: exists
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

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_formatrange
		end

feature {NONE} -- Externals

	c_size_of_formatrange: INTEGER
		external
			"C [macro <frange.h>]"
		alias
			"sizeof (FORMATRANGE)"
		end

	cwel_formatrange_set_hdc (ptr: POINTER; value: POINTER)
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_hdctarget (ptr: POINTER; value: POINTER)
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_rc (ptr: POINTER; value: POINTER)
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_rcpage (ptr: POINTER; value: POINTER)
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_set_chrg (ptr: POINTER; value: POINTER)
		external
			"C [macro <frange.h>]"
		end

	cwel_formatrange_get_rc (ptr: POINTER): POINTER
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

	cwel_formatrange_get_rcpage (ptr: POINTER): POINTER
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

	cwel_formatrange_get_chrg (ptr: POINTER): POINTER
		external
			"C [macro <frange.h>] (FORMATRANGE*): EIF_POINTER"
		end

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

end
