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
		redefine
			make
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
			Precursor {WEL_STANDARD_DIALOG}
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

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		do
			Result := not has_flag (Pd_pagenums) and then
				not has_flag (Pd_selection)
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Page" radio button selected?
		do
			Result := has_flag (Pd_pagenums)
		end

	selection_selected: BOOLEAN is
			-- Is the "Selection" radio box selected?
		do
			Result := has_flag (Pd_selection)
		end

	page_numbers_enabled: BOOLEAN is
			-- Is the "Page numbers" radio button enabled?
		do
			Result := not has_flag (Pd_nopagenums)
		end

	selection_enabled: BOOLEAN is
			-- Is the "Selection" radio button enabled?
		do
			Result := not has_flag (Pd_noselection)
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		do
			Result := has_flag (Pd_collate)
		end

	print_to_file_enabled: BOOLEAN is
			-- Is the "Print to file" check box enabled?
		do
			Result := not has_flag (Pd_disableprinttofile)
		end

	print_to_file_shown: BOOLEAN is
			-- Is the "Print to file" check box shown?
		do
			Result := not has_flag (Pd_hideprinttofile)
		end

	print_to_file_checked: BOOLEAN is
			-- Is the "Print to file" check box checked?
		do
			Result := has_flag (Pd_printtofile)
		end

	warning_enabled: BOOLEAN is
			-- Is the warning message from being displayed when
			-- there is no default printer enabled?
		do
			Result := not has_flag (Pd_nowarning)
		end

	print_setup_enabled: BOOLEAN is
			-- Is the Print setup dialog box enabled?
		do
			Result := has_flag (Pd_printsetup)
		end

feature -- Status setting

	select_all_pages is
			-- Select the "All pages" radio button.
		do
			remove_flag (Pd_pagenums + Pd_selection)
		ensure
			all_pages_selected: all_pages_selected
		end

	select_page_numbers is
			-- Select the "Page numbers" radio button.
		do
			add_flag (Pd_pagenums)
		ensure
			page_numbers_selected: page_numbers_selected
		end

	select_selection is
			-- Select the "Selection" radio button.
		do
			add_flag (Pd_selection)
		ensure
			selection_selected: selection_selected
		end

	enable_page_numbers is
			-- Enable the "Page numbers" radio button.
		do
			remove_flag (Pd_nopagenums)
		ensure
			page_numbers_enabled: page_numbers_enabled
		end

	disable_page_numbers is
			-- Disable the "Page numbers" radio button.
		do
			add_flag (Pd_nopagenums)
		ensure
			page_numbers_disabled: not page_numbers_enabled
		end

	enable_selection is
			-- Enable the "Selection" radio button.
		do
			remove_flag (Pd_noselection)
		ensure
			selection_enabled: selection_enabled
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		do
			add_flag (Pd_noselection)
		ensure
			selection_disabled: not selection_enabled
		end

	check_collate is
			-- Check the "Collate" check box.
		do
			add_flag (Pd_collate)
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate is
			-- Uncheck the "Collate" check box.
		do
			remove_flag (Pd_collate)
		ensure
			collate_unchecked: not collate_checked
		end

	enable_print_to_file is
			-- Enable the "Print to file" check box.
		do
			remove_flag (Pd_disableprinttofile)
		ensure
			print_to_file_enabled: print_to_file_enabled
		end

	disable_print_to_file is
			-- Disable the "Print to file" check box.
		do
			add_flag (Pd_disableprinttofile)
		ensure
			print_to_file_disabled: not print_to_file_enabled
		end

	show_print_to_file is
			-- Show the "Print to file" check box.
		do
			remove_flag (Pd_hideprinttofile)
		ensure
			print_to_file_shown: print_to_file_shown
		end

	hide_print_to_file is
			-- Hide the "Print to file" check box.
		do
			add_flag (Pd_hideprinttofile)
		ensure
			print_to_file_hidden: not print_to_file_shown
		end

	check_print_to_file is
			-- Check the "Print to file" check box.
		do
			add_flag (Pd_printtofile)
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file is
			-- Uncheck the "Print to file" check box.
		do
			remove_flag (Pd_printtofile)
		ensure
			print_to_file_unchecked: not print_to_file_checked
		end

	enable_warning is
			-- Enable the warning message from being displayed when
			-- there is no default printer.
		do
			remove_flag (Pd_nowarning)
		ensure
			warning_enabled: warning_enabled
		end

	disable_warning is
			-- Disable the warning message from being displayed when
			-- there is no default printer.
		do
			add_flag (Pd_nowarning)
		ensure
			warning_disabled: not warning_enabled
		end

	enable_print_setup is
			-- Enable the system to display the Print setup dialog
			-- box rather than the Print dialog box.
		do
			add_flag (Pd_printsetup)
		ensure
			print_setup_enabled: print_setup_enabled
		end

	disable_print_setup is
			-- Disable the system to display the Print setup dialog
			-- box rather than the Print dialog box.
		do
			remove_flag (Pd_printsetup)
		ensure
			print_setup_disabled: not print_setup_enabled
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_print_dlg (item)
			if selected then
				create private_dc.make_by_pointer (cwel_print_dlg_get_hdc (item))
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

feature -- Measurement

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
			"C [macro <printdlg.h>] (PRINTDLG *): EIF_POINTER"
		end

	cwin_print_dlg (ptr: POINTER): BOOLEAN is
			-- SDK PrintDlg
		external
			"C [macro <cdlg.h>] (PRINTDLG *): EIF_BOOLEAN"
		alias
			"PrintDlg"
		end

end -- class WEL_PRINT_DIALOG


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

