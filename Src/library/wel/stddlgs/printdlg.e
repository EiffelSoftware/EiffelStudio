indexing
	description: "Standard dialog box to specify the properties of a %
		%particular print job."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINT_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_dialog_make
		end

	WEL_PD_CONSTANTS
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
			cwel_print_dlg_set_lstructsize (item, structure_size)
			set_flags (Pd_returndc)
		end

feature -- Access

	from_page: INTEGER is
			-- Value for the starting page edit control
		do
			Result := cwel_print_dlg_get_nfrompage (item)
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER is
			-- Value for the ending page edit control
		do
			Result := cwel_print_dlg_get_ntopage (item)
		ensure
			positive_result: Result >= 0
		end

	minimum_page: INTEGER is
			-- Minimum value for the range of pages specified
			-- in the From and To page edit controls
		do
			Result := cwel_print_dlg_get_nminpage (item)
		end

	maximum_page: INTEGER is
			-- Maximum value for the range of pages specified
			-- in the From and To page edit controls
		do
			Result := cwel_print_dlg_get_nmaxpage (item)
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control
		do
			Result := cwel_print_dlg_get_ncopies (item)
		end

	flags: INTEGER is
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in 
			-- class WEL_PD_CONSTANTS.
		do
			Result := cwel_print_dlg_get_flags (item)
		end

	dc: WEL_PRINTER_DC is
			-- Device context associated to the selected printer
		require
			selected: selected
		do
			Result := private_dc
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		do
			cwel_print_dlg_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER) is
			-- Add `a_flags' to `flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER) is
			-- Remove `a_flags' from `flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

	set_from_page (page: INTEGER) is
			-- Set `from_page' with `page'.
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nfrompage (item, page)
		ensure
			from_page_set: from_page = page
		end

	set_to_page (page: INTEGER) is
			-- Set `to_page' with `page'.
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_ntopage (item, page)
		ensure
			to_page_set: to_page = page
		end

	set_minimum_page (page: INTEGER) is
			-- Set `minimum_page' with `page'.
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nminpage (item, page)
		ensure
			minimum_page_set: minimum_page = page
		end

	set_maximum_page (page: INTEGER) is
			-- Set `maximum_page' with `page'.
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nmaxpage (item, page)
		ensure
			maximum_page_set: maximum_page = page
		end

	set_copies (number: INTEGER) is
			-- Set `copies' with `number'.
		do
			cwel_print_dlg_set_ncopies (item, number)
		ensure
			copies_set: copies = number
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' set in `flags'?
			-- See class WEL_PD_CONSTANTS for `a_flags'
			-- values.
		do
			Result := flag_set (flags, a_flags)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_print_dlg (item)
			if selected then
				!! private_dc.make_by_pointer (cwel_print_dlg_get_hdc (item))
			else
				private_dc := Void
			end
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set the parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_print_dlg_set_hwndowner (item, a_parent.item)
		end

	private_dc: WEL_PRINTER_DC
			-- Device context associated to the selected printer

feature {NONE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_print_dlg
		end

feature {NONE} -- Externals

	c_size_of_print_dlg: INTEGER is
		external
			"C [macro <printdlg.h>]"
		alias
			"sizeof (PRINTDLG)"
		end

	cwel_print_dlg_set_lstructsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_hwndowner (ptr: POINTER; value: POINTER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nfrompage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_ntopage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nminpage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nmaxpage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_ncopies (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nfrompage (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_ntopage (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nminpage (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nmaxpage (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_ncopies (ptr: POINTER): INTEGER is
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_hdc (ptr: POINTER): POINTER is
		external
			"C [macro <printdlg.h>]"
		end

	cwin_print_dlg (ptr: POINTER): BOOLEAN is
			-- SDK PrintDlg
		external
			"C [macro <cdlg.h>] (PRINTDLG *): EIF_BOOLEAN"
		alias
			"PrintDlg"
		end

end -- class WEL_PRINT_DIALOG

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
