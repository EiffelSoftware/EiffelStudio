indexing
	description: "Contains information about a rebar control band."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REBARBANDINFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_RBBIM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make,
	make_with_id,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Create a band with no informations.
		do
			structure_make
			set_cbsize (structure_size)
		end

	make_with_id (an_id: INTEGER) is
			-- Create a band with `an_id' as id.
		do
			make
			set_id (an_id)
		end

feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Rbbim_* values.
			-- See class WEL_RBBIM_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_rebarbandinfo_get_fmask (item)
		end

	style: INTEGER is
			-- Array of flags that specify the band style.
			-- This value can be a combinaison of RBBS_* constants.
			-- See class WEL_RBBS_CONSTANTS.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_style))
			Result := cwel_rebarbandinfo_get_fstyle (item)
		end

	text: STRING is
			-- Item text
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_text))
			create Result.make (0)
			Result.from_c (cwel_rebarbandinfo_get_lptext (item))
		end

	length: INTEGER is
			-- Current `length' of the band.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_size))
			Result := cwel_rebarbandinfo_get_cx (item)
		ensure
			positive_result: Result >= 0
		end

	id: INTEGER is
			-- `id' of the band.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_id))
			Result := cwel_rebarbandinfo_get_wid (item)
		end

	child: WEL_WINDOW is
			-- Child currently in the rebar.
		require
			exists: exists
		local
			hwnd: POINTER
		do
			set_mask (set_flag (mask, Rbbim_child))
			hwnd := cwel_rebarbandinfo_get_hwndchild (item)
			Result := window_of_item (hwnd)
		end

	child_minimum_width: INTEGER is
			-- Minimum width required by the child.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_childsize))
			Result := cwel_rebarbandinfo_get_cxminchild (item)
		ensure
			positive_result: Result >= 0
		end

	child_minimum_height: INTEGER is
			-- Minimum width required by the child.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_childsize))
			Result := cwel_rebarbandinfo_get_cyminchild (item)
		ensure
			positive_result: Result >= 0
		end

	foreground_color: WEL_COLOR_REF is
			-- foreground color used for the text of the
			-- control
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_colors))
			create Result.make_by_color (cwel_rebarbandinfo_get_clrfore (item))
		ensure
			color_not_void: Result /= Void
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_colors))
			create Result.make_by_color (cwel_rebarbandinfo_get_clrback (item))
		ensure
			color_not_void: Result /= Void
		end

feature -- Element change

	set_style (value: INTEGER) is
			-- Set `cbSize' (size of the structure) as `value'.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_style))
			cwel_rebarbandinfo_set_fstyle (item, value)
		ensure
			style_set: style = value
		end

	set_text (txt: STRING) is
			-- Set `text' as `txt'.
		require
			exists: exists
			a_text_not_void: txt /= Void
		do
			set_mask (set_flag (mask, Rbbim_text))
			create str_text.make (txt)
			cwel_rebarbandinfo_set_cch (item, txt.count)
			cwel_rebarbandinfo_set_lptext (item, str_text.item)
		ensure
			text_set: text.is_equal (txt)
		end

	set_length (value: INTEGER) is
			-- Set `length' as `value'.
		require
			exists: exists
			valid_value: value >= 0
		do
			set_mask (set_flag (mask, Rbbim_size))
			cwel_rebarbandinfo_set_cx (item, value)
		ensure
			length_set: length = value
		end

	set_id (value: INTEGER) is
			-- Set `id' as `value'.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Rbbim_id))
			cwel_rebarbandinfo_set_wid (item, value)
		ensure
			id_set: id = value
		end

	set_child (window: WEL_WINDOW) is
			-- Set `child' as `window'.
			-- Do not use this features for controls as toolbars
			-- that reposition themself automaticaly at a specific
			-- place. Use `set_reposition_child'.
		require
			exists: exists
			window_not_void: window /= Void
			window_is_inside: window.is_inside
		do
			set_mask (set_flag (mask, Rbbim_child))
			cwel_rebarbandinfo_set_hwndchild (item, window.item)
		ensure
			window_set: child.is_equal (window)
		end

	set_unpositionable_child (window: WEL_WINDOW) is
			-- Set `child' as `window'.
			-- Use this features for controls as toolbars
			-- that reposition themself automaticaly at a specific
			-- place. Use `set_reposition_child'.
			-- Do not use for usual controls.
		require
			exists: exists
			window_not_void: window /= Void
			window_is_inside: window.is_inside
		local
			container: WEL_UNPOSITIONABLE_CONTROL_CONTAINER
			composite: WEL_COMPOSITE_WINDOW
		do
			set_mask (set_flag (mask, Rbbim_child))
			composite ?= window.parent
			create container.make (composite, window)
			cwel_rebarbandinfo_set_hwndchild (item, container.item)
		ensure
			window_set: child.is_equal (window.parent)
		end

	set_child_minimum_width (value: INTEGER) is
			-- Set `child_minimum_width' as `value'.
		require
			exists: exists
			valid_value: value >= 0
		do
			set_mask (set_flag (mask, Rbbim_childsize))
			cwel_rebarbandinfo_set_cxminchild (item, value)
		ensure
			value_set: child_minimum_width = value
		end

	set_child_minimum_height (value: INTEGER) is
			-- Set `child_minimum_height' as `value'.
		require
			exists: exists
			valid_value: value >= 0
		do
			set_mask (set_flag (mask, Rbbim_childsize))
			cwel_rebarbandinfo_set_cyminchild (item, value)
		ensure
			value_set: child_minimum_height = value
		end

	set_foreground_color (color: WEL_COLOR_REF) is
			-- Set `foreground_color' as `color'.
		require
			exists: exists
			color_not_void: color /= Void
		do
			set_mask (set_flag (mask, Rbbim_colors))
			cwel_rebarbandinfo_set_clrfore (item, color.item)
		ensure
			color_set: foreground_color.is_equal (color)
		end

	set_background_color (color: WEL_COLOR_REF) is
			-- Set `background_color' as `color'.
		require
			exists: exists
			color_not_void: color /= Void
		do
			set_mask (set_flag (mask, Rbbim_colors))
			cwel_rebarbandinfo_set_clrback (item, color.item)
		ensure
			color_set: background_color.is_equal (color)
		end

	set_background_bitmap (bmp: WEL_BITMAP) is
			-- Set `background_bitmap' with `bmp'.
		require
			exists: exists
			bitmap_not_void: bmp /= Void
		do
			set_mask (set_flag (mask, Rbbim_background))
			cwel_rebarbandinfo_set_hbmback (item, bmp.to_integer)
		end

feature -- Basic operation

	clear_mask is
			-- Clear the current `mask'.
			-- Call it before to call a set_? feature when you
			-- want to change only one parameter.
		require
			exists: exists
		do
			set_mask (0)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rebarbandinfo
		end

feature {WEL_REBAR} -- Implementation

	set_cch (value: INTEGER) is
			-- Set the maximum size of the text getting by get item)
		do
			cwel_rebarbandinfo_set_cch (item, value)
		end

	set_cbsize (value: INTEGER) is
			-- Set `cbSize' (size of the structure) as `value'.
		do
			cwel_rebarbandinfo_set_cbsize (item, value)
		end

	set_mask (a_mask: INTEGER) is
			-- Set `mask' with `a_mask'.
			-- Internal use
		do
			cwel_rebarbandinfo_set_fmask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save the text

feature {NONE} -- Externals

	c_size_of_rebarbandinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (REBARBANDINFO)"
		end

	cwel_rebarbandinfo_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_fmask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_fstyle (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_clrfore (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_clrback (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_lptext (ptr, value: POINTER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_cch (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_iimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_hwndchild (ptr, value: POINTER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_cxminchild (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_cyminchild (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_cx (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_hbmback (ptr: POINTER; integer: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_set_wid (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_cbsize (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_fmask (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_fstyle (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_clrfore (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_clrback (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_lptext (ptr: POINTER): POINTER is
		external
			"C [macro %"rebarbandinfo.h%"] (REBARBANDINFO *): EIF_POINTER"
		end

	cwel_rebarbandinfo_get_cch (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_iimage (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_hwndchild (ptr: POINTER): POINTER is
		external
			"C [macro %"rebarbandinfo.h%"] (REBARBANDINFO *): EIF_POINTER"
		end

	cwel_rebarbandinfo_get_cxminchild (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_cyminchild (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_cx (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end

	cwel_rebarbandinfo_get_hbmback (ptr: POINTER): POINTER is
		external
			"C [macro %"rebarbandinfo.h%"] (REBARBANDINFO *): EIF_POINTER"
		end

	cwel_rebarbandinfo_get_wid (ptr: POINTER): INTEGER is
		external
			"C [macro %"rebarbandinfo.h%"]"
		end
		
end -- class WEL_REBARINFO

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

