indexing 
        description: "EiffelVision print dialog."
        status: "See notice at end of class"
        date: "$Date$"
        revision: "$Revision$"

class
		EV_PRINT_DIALOG

inherit
		EV_STANDARD_DIALOG
                redefine
                        implementation
                end

create
        default_create

feature -- Access

	from_page: INTEGER is
			-- Value for the starting page edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.from_page
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER is
			-- Value for the ending page edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.to_page
		ensure
			positive_result: Result >= 0
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.copies
		ensure
			positive_result: Result >= 0
		end

	maximum_to_page: INTEGER is
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

	minimum_from_page: INTEGER is
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

	output_file_name: STRING is
			-- String representation of the path to output
			-- the printed area to.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.output_file_name
		ensure
			result_not_void: Result /= Void
		end

	printer_name: STRING is
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

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.all_pages_selected
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Range" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.page_numbers_selected
		end

	selection_selected: BOOLEAN is
			-- Is the "Selection" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selection_selected
		end

	page_numbers_enabled: BOOLEAN is
			-- Is the "Range" radio button enabled?
		require
			not_destroyed: not is_destroyed
		do
			 Result := implementation.page_numbers_enabled
		end

	selection_enabled: BOOLEAN is
			-- Is the "Selection" radio button selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selection_enabled
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.collate_checked
		end

	print_to_file_enabled: BOOLEAN is
			-- Is the "File" radio button enabled?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_enabled
		end

	print_to_file_shown: BOOLEAN is
			-- Is the "File" radio button visible?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_shown
		end

	print_to_file_checked: BOOLEAN is
			-- Is the "File" radio button checked?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_to_file_checked
		end

	landscape_checked: BOOLEAN is
			-- Is the landscape option selected.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.landscape_checked
		end

	print_context: EV_PRINT_CONTEXT is
			-- Return a print context for the dialog box.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.print_context
		end

feature -- Status setting

	select_all_pages is
			-- Select the "All pages" radio button.
			-- Selected by default.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_all_pages
		end

	select_page_numbers is
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_page_numbers
		end

	select_selection is
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.select_selection
		end

	enable_page_numbers is
			-- Enable the "Range" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_page_numbers
		end

	disable_page_numbers is
			-- Disable the "Range" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_page_numbers
		end

	enable_selection is
			-- Enable the "Selection" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_selection
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_selection
		end

	check_collate is
			-- Check the "Collate" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.check_collate
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate is
			-- Uncheck the "Collate" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.uncheck_collate
		ensure
			colate_not_checked: not collate_checked
		end

	enable_print_to_file is
			-- Enable the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_print_to_file
		end

	disable_print_to_file is
			-- Disable the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_print_to_file
		end

	show_print_to_file is
			-- Show the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_print_to_file
		end

	hide_print_to_file is
			-- Hide the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_print_to_file
		end

	check_print_to_file is
			-- Check the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.check_print_to_file
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file is
			-- Check the "Print to file" check box.
		require
			not_destroyed: not is_destroyed
		do
			implementation.uncheck_print_to_file
		ensure
			print_to_file_not_checked: not print_to_file_checked
		end

feature -- Element change

	set_from_page (value: INTEGER) is
			-- Make `value' the new `from_page' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_from_page (value)
		ensure
			from_page_set: from_page = value
		end

	set_to_page (value: INTEGER) is
			-- Make `value' the new `to_page' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_to_page (value)
		ensure
			to_page_set: to_page = value
		end

	set_copies (value: INTEGER) is
			-- Make `value' the new `copies' number.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_copies (value)
		ensure
			copies_set: copies = value
		end

	set_maximum_to_page (value: INTEGER) is
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

	set_minimum_from_page (value: INTEGER) is
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
		
feature {EV_ANY_I} -- Implementation
		
	implementation: EV_PRINT_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PRINT_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_PRINT_DIALOG

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
