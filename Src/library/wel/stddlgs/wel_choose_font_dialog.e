indexing
	description: "Standard dialog box to choose a font."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_FONT_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_dialog_make
		end

	WEL_CF_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_FONT_TYPE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_font_type_constant
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make and setup the structure.
			-- By default the dialog will show the screen fonts.
		local
			lf: WEL_LOG_FONT
		do
			standard_dialog_make
			cwel_choose_font_set_lstructsize (item, structure_size)
			create lf.make (10, "System")
			set_log_font (lf)
			set_flags (Cf_screenfonts + Cf_effects + Cf_inittologfontstruct)
		end

feature -- Access

	log_font: WEL_LOG_FONT
			-- Information about the selected font

	font_type: INTEGER is
			-- Type of the selected font.
			-- See class WEL_FONT_TYPE_CONSTANTS for values.
		require
			selected: selected
		do
			Result := cwel_choose_font_get_nfonttype (item)
		ensure
			valid_font_type: valid_font_type_constant (Result)
		end

	point_size: INTEGER is
			-- Size of the selected font (in units of 1/10 of
			-- a point)
		require
			selected: selected
		do
			Result := cwel_choose_font_get_ipointsize (item)
		end

	minimum_size: INTEGER is
			-- Minimum point size a user can select
		do
			Result := cwel_choose_font_get_nsizemin (item)
		end

	maximum_size: INTEGER is
			-- Maximum point size a user can select
		do
			Result := cwel_choose_font_get_nsizemax (item)
		end

	flags: INTEGER is
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in 
			-- class WEL_CF_CONSTANTS.
		do
			Result := cwel_choose_font_get_flags (item)
		end

	color: WEL_COLOR_REF is
			-- Font color
		require
			exits: exists
		do
			create Result.make_by_color (cwel_choose_font_get_rgbcolors (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_dc (a_dc: WEL_DC) is
			-- Set a device context `a_dc' of the printer whose
			-- fonts will be listed in the dialog box.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			add_flag (Cf_printerfonts)
			cwel_choose_font_set_hdc (item, a_dc.item)
		end

	set_log_font (a_log_font: WEL_LOG_FONT) is
			-- Set `log_font' with `a_log_font'.
		require
			a_log_font_not_void: a_log_font /= Void
		do
			log_font := a_log_font
			add_flag (Cf_inittologfontstruct)
			cwel_choose_font_set_lplogfont (item, a_log_font.item)
		ensure
			log_font_set: log_font.item = a_log_font.item
		end

	set_minimum_size (size: INTEGER) is
			-- Set `minimum_size' with `size'.
		do
			add_flag (Cf_limitsize)
			cwel_choose_font_set_nsizemin (item, size)
		ensure
			minimum_size_set: minimum_size = size
		end

	set_maximum_size (size: INTEGER) is
			-- Set `maximum_size' with `size'.
		do
			add_flag (Cf_limitsize)
			cwel_choose_font_set_nsizemax (item, size)
		ensure
			maximum_size_set: maximum_size = size
		end

	set_color (a_color: WEL_COLOR_REF) is
			-- Set `color' with `a_color'.
		do
			add_flag (Cf_effects)
			cwel_choose_font_set_rgbcolors (item, a_color.item)
		ensure
			color_set: color.is_equal (a_color)
		end

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		do
			cwel_choose_font_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER) is
			-- Add `a_flags' to `flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER) is
			-- Remove `a_flags' from `flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' set in `flags'?
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		do
			Result := flag_set (flags, a_flags)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_choose_font (item)
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set the parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_choose_font_set_hwndowner (item, a_parent.item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_choose_font
		end

feature {NONE} -- Externals

	c_size_of_choose_font: INTEGER is
		external
			"C [macro <choosefo.h>]"
		alias
			"sizeof (CHOOSEFONT)"
		end

	cwel_choose_font_set_lstructsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_hwndowner (ptr: POINTER; value: POINTER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_hdc (ptr: POINTER; value: POINTER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_lplogfont (ptr: POINTER; value: POINTER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_rgbcolors (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_nsizemin (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_nsizemax (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_rgbcolors (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_ipointsize (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nfonttype (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nsizemin (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nsizemax (ptr: POINTER): INTEGER is
		external
			"C [macro <choosefo.h>]"
		end

	cwin_choose_font (ptr: POINTER): BOOLEAN is
			-- SDK ChooseFont
		external
			"C [macro <cdlg.h>] (LPCHOOSEFONT): EIF_BOOLEAN"
		alias
			"ChooseFont"
		end

end -- class WEL_CHOOSE_FONT_DIALOG


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

