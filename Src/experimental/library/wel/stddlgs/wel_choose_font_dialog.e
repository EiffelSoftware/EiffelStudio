note
	description: "Standard dialog box to choose a font."
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_FONT_TYPE_CONSTANTS
		export
			{NONE} all
			{ANY} valid_font_type_constant
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
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

	font_type: INTEGER
			-- Type of the selected font.
			-- See class WEL_FONT_TYPE_CONSTANTS for values.
		require
			exists: exists
			selected: selected
		do
			Result := cwel_choose_font_get_nfonttype (item)
		ensure
			valid_font_type: valid_font_type_constant (Result)
		end

	point_size: INTEGER
			-- Size of the selected font (in units of 1/10 of
			-- a point)
		require
			exists: exists
			selected: selected
		do
			Result := cwel_choose_font_get_ipointsize (item)
		end

	minimum_size: INTEGER
			-- Minimum point size a user can select
		require
			exists: exists
		do
			Result := cwel_choose_font_get_nsizemin (item)
		end

	maximum_size: INTEGER
			-- Maximum point size a user can select
		require
			exists: exists
		do
			Result := cwel_choose_font_get_nsizemax (item)
		end

	flags: INTEGER
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in
			-- class WEL_CF_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_choose_font_get_flags (item)
		end

	color: WEL_COLOR_REF
			-- Font color
		require
			exits: exists
		do
			create Result.make_by_color (cwel_choose_font_get_rgbcolors (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_dc (a_dc: WEL_DC)
			-- Set a device context `a_dc' of the printer whose
			-- fonts will be listed in the dialog box.
		require
			exists: exists
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			add_flag (Cf_printerfonts)
			cwel_choose_font_set_hdc (item, a_dc.item)
		end

	set_log_font (a_log_font: WEL_LOG_FONT)
			-- Set `log_font' with `a_log_font'.
		require
			exists: exists
			a_log_font_not_void: a_log_font /= Void
			a_log_font_exists: a_log_font.exists
		do
			log_font := a_log_font
			add_flag (Cf_inittologfontstruct)
			cwel_choose_font_set_lplogfont (item, a_log_font.item)
		ensure
			log_font_set: log_font.item = a_log_font.item
		end

	set_minimum_size (size: INTEGER)
			-- Set `minimum_size' with `size'.
		require
			exists: exists
		do
			add_flag (Cf_limitsize)
			cwel_choose_font_set_nsizemin (item, size)
		ensure
			minimum_size_set: minimum_size = size
		end

	set_maximum_size (size: INTEGER)
			-- Set `maximum_size' with `size'.
		require
			exists: exists
		do
			add_flag (Cf_limitsize)
			cwel_choose_font_set_nsizemax (item, size)
		ensure
			maximum_size_set: maximum_size = size
		end

	set_color (a_color: WEL_COLOR_REF)
			-- Set `color' with `a_color'.
		require
			exists: exists
			a_color_not_void: a_color /= Void
		do
			add_flag (Cf_effects)
			cwel_choose_font_set_rgbcolors (item, a_color.item)
		ensure
			color_set: color.same_color (a_color)
		end

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			cwel_choose_font_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER)
			-- Add `a_flags' to `flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER)
			-- Remove `a_flags' from `flags'.
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN
			-- Is `a_flags' set in `flags'?
			-- See class WEL_CF_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			Result := flag_set (flags, a_flags)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW)
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_choose_font (item)
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW)
			-- Set the parent window with `a_parent'.
		require
			exists: exists
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_choose_font_set_hwndowner (item, a_parent.item)
		end

	hwnd_parent: POINTER
		require
			exists: exists
		do
			Result := cwel_choose_font_get_hwndowner (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_choose_font
		end

feature {NONE} -- Externals

	c_size_of_choose_font: INTEGER
		external
			"C [macro <choosefo.h>]"
		alias
			"sizeof (CHOOSEFONT)"
		end

	cwel_choose_font_set_lstructsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_hwndowner (ptr: POINTER; value: POINTER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_hdc (ptr: POINTER; value: POINTER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_lplogfont (ptr: POINTER; value: POINTER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_rgbcolors (ptr: POINTER; value: INTEGER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_nsizemin (ptr: POINTER; value: INTEGER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_nsizemax (ptr: POINTER; value: INTEGER)
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_set_lpfnhook (ptr: POINTER; value: POINTER)
		external
			"C inline use <choosefo.h>"
		alias
			"((LPCHOOSEFONT) $ptr)->lpfnHook = (LPCFHOOKPROC) $value;"
		end

	cwel_choose_font_get_hwndowner (ptr: POINTER): POINTER
		external
			"C inline use <choosefo.h>"
		alias
			"return ((LPCHOOSEFONT) $ptr)->hwndOwner;"
		end

	cwel_choose_font_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_rgbcolors (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_ipointsize (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nfonttype (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nsizemin (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_nsizemax (ptr: POINTER): INTEGER
		external
			"C [macro <choosefo.h>]"
		end

	cwel_choose_font_get_lpfnhook (ptr: POINTER): POINTER
		external
			"C inline use <choosefo.h>"
		alias
			"return ((LPCHOOSEFONT) $ptr)->lpfnHook;"
		end

	cwin_choose_font (ptr: POINTER): BOOLEAN
			-- SDK ChooseFont
		external
			"C [macro <cdlg.h>] (LPCHOOSEFONT): EIF_BOOLEAN"
		alias
			"ChooseFont"
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_CHOOSE_FONT_DIALOG

