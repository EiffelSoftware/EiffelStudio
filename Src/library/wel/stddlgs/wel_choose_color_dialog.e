indexing
	description: "Standard dialog box to choose a color."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_COLOR_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_dialog_make
		end

	WEL_CHOOSE_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make and setup the structure
		do
			standard_dialog_make
			cwel_choose_color_set_lstructsize (item, structure_size)
			create custom_colors.make
			set_custom_colors (custom_colors)
		end

feature -- Access

	rgb_result: WEL_COLOR_REF is
			-- Color selected by the user and default color
			-- selected when the dialog box is created.
		require
			selected: selected
		do
			create Result.make_by_color (
				cwel_choose_color_get_rgbresult (item))
		ensure
			result_not_void: Result /= Void
		end

	custom_colors: WEL_CUSTOM_COLORS
			-- Custom colors chosen by the user

	flags: INTEGER is
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in 
			-- class WEL_CHOOSE_COLOR_CONSTANTS.
		do
			Result := cwel_choose_color_get_flags (item)
		end

feature -- Element change

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_CHOOSE_COLOR_CONSTANTS for `a_flags'
			-- values.
		do
			cwel_choose_color_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER) is
			-- Add `a_flags' to `flags'.
			-- See class WEL_CHOOSE_COLOR_CONSTANTS for `a_flags'
			-- values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER) is
			-- Remove `a_flags' from `flags'.
			-- See class WEL_CHOOSE_COLOR_CONSTANTS for `a_flags'
			-- values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

	set_rgb_result (color: WEL_COLOR_REF) is
			-- Set `rgb_result' with `color'
		require
			color_not_void: color /= Void
		do
			add_flag (Cc_rgbinit)
			cwel_choose_color_set_rgbresult (item, color.item)
		ensure
			color_set: rgb_result.item = (color.item)
		end

	set_custom_colors (a_custom_colors: WEL_CUSTOM_COLORS) is
			-- Set `custom_colors' with `a_custom_colors'.
		require
			a_custom_colors_not_void: a_custom_colors /= Void
		do
			custom_colors := a_custom_colors
			cwel_choose_color_set_lpcustcolors (item,
				custom_colors.item)
		ensure
			custom_colors_set: custom_colors = a_custom_colors
		end

feature -- Status setting

	prevent_full_open is
			-- Disable the define custom colors button,
			-- preventing the user from creating custom colors.
		do
			add_flag (Cc_preventfullopen)
		ensure
			full_open_prevented: not full_open_allowed
		end

	allow_full_open is
			-- Enable the define custom colors button,
			-- allowing the user from creating custom colors.
		do
			remove_flag (Cc_preventfullopen)
		ensure
			full_open_allowed: full_open_allowed
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' set in `flags'?
			-- See class WEL_CHOOSE_COLOR_CONSTANTS for `a_flags'
			-- values.
		do
			Result := flag_set (flags, a_flags)
		end

	full_open_allowed: BOOLEAN is
			-- Is the define custom colors button enabled?
			-- This button allows the user to create custom colors.
		do
			Result := not has_flag (Cc_preventfullopen)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_choose_color (item)
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set the parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_choose_color_set_hwndowner (item, a_parent.item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_choose_color
		end

feature {NONE} -- Externals

	c_size_of_choose_color: INTEGER is
		external
			"C [macro <chooseco.h>]"
		alias
			"sizeof (CHOOSECOLOR)"
		end

	cwel_choose_color_set_lstructsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_set_hwndowner (ptr: POINTER; value: POINTER) is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_set_rgbresult (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_set_lpcustcolors (ptr: POINTER; value: POINTER) is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_get_rgbresult (ptr: POINTER): INTEGER is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_choose_color_get_lpcustcolors (ptr: POINTER): POINTER is
		external
			"C [macro <chooseco.h>] (CHOOSECOLOR *): EIF_POINTER"
		end

	cwel_choose_color_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <chooseco.h>]"
		end

	cwin_choose_color (ptr: POINTER): BOOLEAN is
			-- SDK ChooseColor
		external
			"C [macro <cdlg.h>] (CHOOSECOLOR *): EIF_BOOLEAN"
		alias
			"ChooseColor"
		end

end -- class WEL_CHOOSE_COLOR_DIALOG

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

