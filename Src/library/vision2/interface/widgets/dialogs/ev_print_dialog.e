note
	description: "EiffelVision print dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG

inherit
	EV_STANDARD_DIALOG
		rename
			ok_actions as print_actions
		redefine
			implementation
		end

create
        default_create,
        make_with_title

feature -- Event handling

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when user clicks Print.
		obsolete
			"This has been replaced by print_actions [2017-05-31]"
		do
			Result := print_actions
		ensure
			not_void: Result /= Void
		end

feature -- Access

	from_page: INTEGER
			-- Value for the starting page edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.from_page
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER
			-- Value for the ending page edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.to_page
		ensure
			positive_result: Result >= 0
		end

	copies: INTEGER
			-- Number of copies for the Copies edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.copies
		ensure
			positive_result: Result >= 0
		end

	maximum_to_page: INTEGER
			-- Maximum value for the page specified
			-- in the To page edit controls.
			-- 1 by default.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.maximum_to_page
		ensure
			positive_result: Result >= 0
		end

	minimum_from_page: INTEGER
			-- Minimum value for the page specified
			-- in the From page edit controls.
			-- 1 by default.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_from_page
		ensure
			positive_result: Result >= 0
		end

	output_file_name: STRING_32
			-- String representation of the path to output
			-- the printed area to.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.output_file_name
		ensure
			result_not_void: Result /= Void
		end

	printer_name: STRING_32
			-- String representation of the printer to output
			-- the printed area to.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.printer_name
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	all_pages_selected: BOOLEAN
			-- Is the "All pages" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.all_pages_selected
		end

	page_numbers_selected: BOOLEAN
			-- Is the "Range" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.page_numbers_selected
		end

	selection_selected: BOOLEAN
			-- Is the "Selection" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selection_selected
		end

	page_numbers_enabled: BOOLEAN
			-- Is the "Range" radio button enabled?
		require
			not_destroyed: not is_destroyed
		do
			 Result := implementation.page_numbers_enabled
		end

	selection_enabled: BOOLEAN
			-- Is the "Selection" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selection_enabled
		end

	collate_checked: BOOLEAN
			-- Is the "Collate" check box checked?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.collate_checked
		end

	print_to_file_enabled: BOOLEAN
			-- Is the "File" radio button enabled?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_enabled
		end

	print_to_file_shown: BOOLEAN
			-- Is the "File" radio button visible?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_shown
		end

	print_to_file_checked: BOOLEAN
			-- Is the "File" radio button checked?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_checked
		end

	landscape_checked: BOOLEAN
			-- Is the landscape option selected.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.landscape_checked
		end

	print_context: EV_PRINT_CONTEXT
			-- Return a print context for the dialog box.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_context
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	select_all_pages
			-- Select the "All pages" radio button.
			-- Selected by default.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_all_pages
		end

	select_page_numbers
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_page_numbers
		end

	select_selection
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_selection
		end

	enable_page_numbers
			-- Enable the "Range" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_page_numbers
		end

	disable_page_numbers
			-- Disable the "Range" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_page_numbers
		end

	enable_selection
			-- Enable the "Selection" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_selection
		end

	disable_selection
			-- Disable the "Selection" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_selection
		end

	check_collate
			-- Check the "Collate" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.check_collate
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate
			-- Uncheck the "Collate" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.uncheck_collate
		ensure
			colate_not_checked: not collate_checked
		end

	enable_print_to_file
			-- Enable the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_print_to_file
		end

	disable_print_to_file
			-- Disable the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_print_to_file
		end

	show_print_to_file
			-- Show the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_print_to_file
		end

	hide_print_to_file
			-- Hide the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_print_to_file
		end

	check_print_to_file
			-- Check the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.check_print_to_file
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file
			-- Check the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.uncheck_print_to_file
		ensure
			print_to_file_not_checked: not print_to_file_checked
		end

feature -- Element change

	set_from_page (value: INTEGER)
			-- Make `value' the new `from_page' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_from_page (value)
		ensure
			from_page_set: from_page = value
		end

	set_to_page (value: INTEGER)
			-- Make `value' the new `to_page' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_to_page (value)
		ensure
			to_page_set: to_page = value
		end

	set_copies (value: INTEGER)
			-- Make `value' the new `copies' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_copies (value)
		ensure
			copies_set: copies = value
		end

	set_maximum_to_page (value: INTEGER)
			-- Make `value' the new maximum "to_page" value.
		require
			not_destroyed: not is_destroyed
			positive_value: value > 0
			not_less_than_minimum: value >= minimum_from_page
		do
			implementation.set_maximum_to_page (value)
		ensure
			maximum_to_page_set: maximum_to_page = value
		end

	set_minimum_from_page (value: INTEGER)
			-- Make `value' the new minimum "from_page" value.
		require
			not_destroyed: not is_destroyed
			positive_value: value > 0
			not_greater_than_maximum_value: value <= maximum_to_page
		do
			implementation.set_minimum_from_page (value)
		ensure
			minimum_from_page_set: minimum_from_page = value
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PRINT_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PRINT_DIALOG_IMP} implementation.make
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




end -- class EV_PRINT_DIALOG





