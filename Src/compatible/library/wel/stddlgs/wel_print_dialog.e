note
	description: "Standard dialog box to specify the properties of a %
		%particular print job."
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Make and setup the structure
		do
			Precursor {WEL_STANDARD_DIALOG}
			cwel_print_dlg_set_lstructsize (item, structure_size)
			set_flags (Pd_returndc)
		end

feature -- Access

	from_page: INTEGER
			-- Value for the starting page edit control
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_nfrompage (item)
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER
			-- Value for the ending page edit control
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_ntopage (item)
		ensure
			positive_result: Result >= 0
		end

	minimum_page: INTEGER
			-- Minimum value for the range of pages specified
			-- in the From and To page edit controls
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_nminpage (item)
		end

	maximum_page: INTEGER
			-- Maximum value for the range of pages specified
			-- in the From and To page edit controls
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_nmaxpage (item)
		end

	copies: INTEGER
			-- Number of copies for the Copies edit control
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_ncopies (item)
		end

	flags: INTEGER
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in
			-- class WEL_PD_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_print_dlg_get_flags (item)
		end

	dc: WEL_PRINTER_DC
			-- Device context associated to the selected printer
		require
			selected: selected
		local
			l_dc: detachable WEL_PRINTER_DC
		do
			l_dc := private_dc
				-- Pre precondition
			check l_dc_attached: l_dc /= Void end
			Result := l_dc
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			cwel_print_dlg_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER)
			-- Add `a_flags' to `flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER)
			-- Remove `a_flags' from `flags'.
			-- See class WEL_PD_CONSTANTS for `a_flags' values.
		require
			exists: exists
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

	set_from_page (page: INTEGER)
			-- Set `from_page' with `page'.
		require
			exists: exists
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nfrompage (item, page)
		ensure
			from_page_set: from_page = page
		end

	set_to_page (page: INTEGER)
			-- Set `to_page' with `page'.
		require
			exists: exists
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_ntopage (item, page)
		ensure
			to_page_set: to_page = page
		end

	set_minimum_page (page: INTEGER)
			-- Set `minimum_page' with `page'.
		require
			exists: exists
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nminpage (item, page)
		ensure
			minimum_page_set: minimum_page = page
		end

	set_maximum_page (page: INTEGER)
			-- Set `maximum_page' with `page'.
		require
			exists: exists
		do
			add_flag (Pd_pagenums)
			cwel_print_dlg_set_nmaxpage (item, page)
		ensure
			maximum_page_set: maximum_page = page
		end

	set_copies (number: INTEGER)
			-- Set `copies' with `number'.
		require
			exists: exists
		do
			cwel_print_dlg_set_ncopies (item, number)
		ensure
			copies_set: copies = number
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN
			-- Is `a_flags' set in `flags'?
			-- See class WEL_PD_CONSTANTS for `a_flags'
			-- values.
		require
			exists: exists
		do
			Result := flag_set (flags, a_flags)
		end

	all_pages_selected: BOOLEAN
			-- Is the "All pages" radio button selected?
		require
			exists: exists
		do
			Result := not has_flag (Pd_pagenums) and then
				not has_flag (Pd_selection)
		end

	page_numbers_selected: BOOLEAN
			-- Is the "Page" radio button selected?
		require
			exists: exists
		do
			Result := has_flag (Pd_pagenums)
		end

	selection_selected: BOOLEAN
			-- Is the "Selection" radio box selected?
		require
			exists: exists
		do
			Result := has_flag (Pd_selection)
		end

	page_numbers_enabled: BOOLEAN
			-- Is the "Page numbers" radio button enabled?
		require
			exists: exists
		do
			Result := not has_flag (Pd_nopagenums)
		end

	selection_enabled: BOOLEAN
			-- Is the "Selection" radio button enabled?
		require
			exists: exists
		do
			Result := not has_flag (Pd_noselection)
		end

	collate_checked: BOOLEAN
			-- Is the "Collate" check box checked?
		require
			exists: exists
		do
			Result := has_flag (Pd_collate)
		end

	print_to_file_enabled: BOOLEAN
			-- Is the "Print to file" check box enabled?
		require
			exists: exists
		do
			Result := not has_flag (Pd_disableprinttofile)
		end

	print_to_file_shown: BOOLEAN
			-- Is the "Print to file" check box shown?
		require
			exists: exists
		do
			Result := not has_flag (Pd_hideprinttofile)
		end

	print_to_file_checked: BOOLEAN
			-- Is the "Print to file" check box checked?
		require
			exists: exists
		do
			Result := has_flag (Pd_printtofile)
		end

	warning_enabled: BOOLEAN
			-- Is the warning message from being displayed when
			-- there is no default printer enabled?
		require
			exists: exists
		do
			Result := not has_flag (Pd_nowarning)
		end

	print_setup_enabled: BOOLEAN
			-- Is the Print setup dialog box enabled?
		require
			exists: exists
		do
			Result := has_flag (Pd_printsetup)
		end

feature -- Status setting

	select_all_pages
			-- Select the "All pages" radio button.
		require
			exists: exists
		do
			remove_flag (Pd_pagenums + Pd_selection)
		ensure
			all_pages_selected: all_pages_selected
		end

	select_page_numbers
			-- Select the "Page numbers" radio button.
		require
			exists: exists
		do
			add_flag (Pd_pagenums)
		ensure
			page_numbers_selected: page_numbers_selected
		end

	select_selection
			-- Select the "Selection" radio button.
		require
			exists: exists
		do
			add_flag (Pd_selection)
		ensure
			selection_selected: selection_selected
		end

	enable_page_numbers
			-- Enable the "Page numbers" radio button.
		require
			exists: exists
		do
			remove_flag (Pd_nopagenums)
		ensure
			page_numbers_enabled: page_numbers_enabled
		end

	disable_page_numbers
			-- Disable the "Page numbers" radio button.
		require
			exists: exists
		do
			add_flag (Pd_nopagenums)
		ensure
			page_numbers_disabled: not page_numbers_enabled
		end

	enable_selection
			-- Enable the "Selection" radio button.
		require
			exists: exists
		do
			remove_flag (Pd_noselection)
		ensure
			selection_enabled: selection_enabled
		end

	disable_selection
			-- Disable the "Selection" radio button.
		require
			exists: exists
		do
			add_flag (Pd_noselection)
		ensure
			selection_disabled: not selection_enabled
		end

	check_collate
			-- Check the "Collate" check box.
		require
			exists: exists
		do
			add_flag (Pd_collate)
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate
			-- Uncheck the "Collate" check box.
		require
			exists: exists
		do
			remove_flag (Pd_collate)
		ensure
			collate_unchecked: not collate_checked
		end

	enable_print_to_file
			-- Enable the "Print to file" check box.
		require
			exists: exists
		do
			remove_flag (Pd_disableprinttofile)
		ensure
			print_to_file_enabled: print_to_file_enabled
		end

	disable_print_to_file
			-- Disable the "Print to file" check box.
		require
			exists: exists
		do
			add_flag (Pd_disableprinttofile)
		ensure
			print_to_file_disabled: not print_to_file_enabled
		end

	show_print_to_file
			-- Show the "Print to file" check box.
		require
			exists: exists
		do
			remove_flag (Pd_hideprinttofile)
		ensure
			print_to_file_shown: print_to_file_shown
		end

	hide_print_to_file
			-- Hide the "Print to file" check box.
		require
			exists: exists
		do
			add_flag (Pd_hideprinttofile)
		ensure
			print_to_file_hidden: not print_to_file_shown
		end

	check_print_to_file
			-- Check the "Print to file" check box.
		require
			exists: exists
		do
			add_flag (Pd_printtofile)
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file
			-- Uncheck the "Print to file" check box.
		require
			exists: exists
		do
			remove_flag (Pd_printtofile)
		ensure
			print_to_file_unchecked: not print_to_file_checked
		end

	enable_warning
			-- Enable the warning message from being displayed when
			-- there is no default printer.
		require
			exists: exists
		do
			remove_flag (Pd_nowarning)
		ensure
			warning_enabled: warning_enabled
		end

	disable_warning
			-- Disable the warning message from being displayed when
			-- there is no default printer.
		require
			exists: exists
		do
			add_flag (Pd_nowarning)
		ensure
			warning_disabled: not warning_enabled
		end

	enable_print_setup
			-- Enable the system to display the Print setup dialog
			-- box rather than the Print dialog box.
		require
			exists: exists
		do
			add_flag (Pd_printsetup)
		ensure
			print_setup_enabled: print_setup_enabled
		end

	disable_print_setup
			-- Disable the system to display the Print setup dialog
			-- box rather than the Print dialog box.
		require
			exists: exists
		do
			remove_flag (Pd_printsetup)
		ensure
			print_setup_disabled: not print_setup_enabled
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW)
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

	set_parent (a_parent: WEL_COMPOSITE_WINDOW)
			-- Set the parent window with `a_parent'.
		require
			exists: exists
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_print_dlg_set_hwndowner (item, a_parent.item)
		end

	private_dc: detachable WEL_PRINTER_DC
			-- Device context associated to the selected printer

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_print_dlg
		end

feature {NONE} -- Externals

	c_size_of_print_dlg: INTEGER
		external
			"C [macro <printdlg.h>]"
		alias
			"sizeof (PRINTDLG)"
		end

	cwel_print_dlg_set_lstructsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_hwndowner (ptr: POINTER; value: POINTER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nfrompage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_ntopage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nminpage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_nmaxpage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_ncopies (ptr: POINTER; value: INTEGER)
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_set_lpfnprinthook (ptr: POINTER; value: POINTER)
		external
			"C inline use <windows.h>"
		alias
			"((LPPRINTDLG) $ptr)->lpfnPrintHook = (LPPRINTHOOKPROC) $value;"
		end

	cwel_print_dlg_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nfrompage (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_ntopage (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nminpage (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_nmaxpage (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_ncopies (ptr: POINTER): INTEGER
		external
			"C [macro <printdlg.h>]"
		end

	cwel_print_dlg_get_hdc (ptr: POINTER): POINTER
		external
			"C [macro <printdlg.h>] (PRINTDLG *): EIF_POINTER"
		end

	cwel_print_dlg_get_lpfnprinthook (ptr: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) ((LPPRINTDLG) $ptr)->lpfnPrintHook;"
		end

	cwin_print_dlg (ptr: POINTER): BOOLEAN
			-- SDK PrintDlg
		external
			"C [macro <cdlg.h>] (PRINTDLG *): EIF_BOOLEAN"
		alias
			"PrintDlg"
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




end -- class WEL_PRINT_DIALOG

