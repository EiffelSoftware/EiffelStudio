--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision print dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRINT_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I
		redefine
			internal_accept
		end

feature -- Access

	from_page: INTEGER is
			-- Value for the starting page edit control
		require
		deferred
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER is
			-- Value for the ending page edit control
		require
		deferred
		ensure
			positive_result: Result >= 0
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control
		require
		deferred
		ensure
			positive_result: Result >= 0
		end

	maximum_to_page: INTEGER
			-- Maximum `to_page' value.

	minimum_from_page: INTEGER
			-- Minimum `from_page' value.

	output_file_name: STRING is
			-- String representation of the path to output
			-- the printed area to.
		require
		deferred
		ensure
			result_not_void: Result /= Void
		end

	printer_name: STRING is
			-- String representation of the printer to output
			-- the printed area to.
		require
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		require
		deferred
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Range" radio button selected?
		require
		deferred
		end

	selection_selected: BOOLEAN is
			-- Is the "Selection" radio button selected?
		require
		deferred
		end

	page_numbers_enabled: BOOLEAN is
			-- Is the "Range" radio button enabled?
		require
		deferred
		end

	selection_enabled: BOOLEAN is
			-- Is the "Selection" radio button selected?
		require
		deferred
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		require
		deferred
		end

	print_to_file_enabled: BOOLEAN is
			-- Is the "File" radio button enabled?
		require
		deferred
		end

	print_to_file_shown: BOOLEAN is
			-- Is the "File" radio button visible?
		require
		deferred
		end

	print_to_file_checked: BOOLEAN is
                        -- Is the "File" radio button checked?
                require
		deferred
		end

	landscape_checked: BOOLEAN is
			-- Is the landscape option selected.
		require
		deferred
		end

	print_context: EV_PRINT_CONTEXT is
			-- Return a print context for the dialog box.
		local
			context: EV_PRINT_CONTEXT
		do
			create context
			context.set_range (from_page, to_page)
			context.set_copies (copies)
			if all_pages_selected then
				context.set_selection_to_all
			elseif page_numbers_selected then
				context.set_selection_to_range
			else
				context.set_selection_to_selection
			end
			context.set_printer_name (printer_name)
			context.set_file_name (output_file_name)
			if landscape_checked then
				context.set_landscape
			else
				context.set_portrait
			end
			if print_to_file_checked then
				context.set_output_to_file
			else
				context.set_output_to_printer
			end
			Result := context
		end

feature -- Status setting

	select_all_pages is
			-- Select the "All pages" radio button.
                        -- Selected by default.
                require
		deferred
		end

	select_page_numbers is
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		require
		deferred
		end

	select_selection is
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		require
		deferred
		end

	enable_page_numbers is
			-- Enable the "Range" radio button.
		require
		deferred
		end

	disable_page_numbers is
			-- Disable the "Range" radio button.
		require
		deferred
		end

	enable_selection is
			-- Enable the "Selection" radio button.
		require
		deferred
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		require
		deferred
		end

	check_collate is
			-- Check the "Collate" check box.
		require
		deferred
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate is
			-- Uncheck the "Collate" check box.
		require
		deferred
		ensure
			colate_not_checked: not collate_checked
		end	

	enable_print_to_file is
			-- Enable the "Print to file" check box.
		require
		deferred
		end

	disable_print_to_file is
			-- Disable the "Print to file" check box.
		require
		deferred
		end

	show_print_to_file is
			-- Show the "Print to file" check box.
		require
		deferred
		end

	hide_print_to_file is
			-- Hide the "Print to file" check box.
		require
		deferred
		end

	check_print_to_file is
			-- Check the "Print to file" check box.
		require
		deferred
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file is
			-- Check the "Print to file" check box.
		require
		deferred
		ensure
			print_to_file_not_checked: not print_to_file_checked
		end

feature -- Element change

	set_from_page (value: INTEGER) is
			-- Make `value' the new `from_page' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			from_page_set: from_page = value
		end

	set_to_page (value: INTEGER) is
			-- Make `value' the new `to_page' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			to_page_set: to_page = value
		end

	set_copies (value: INTEGER) is
			-- Make `value' the new `copies' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			copies_set: copies = value
		end

	set_maximum_to_page (value: INTEGER) is
			-- Make `value' the new maximum `to_page' value.
		require
			positive_value: value > 0
			not_less_than_minimum: value >= minimum_from_page
		deferred
		ensure
			maximum_to_page_set: maximum_to_page = value
		end

	set_minimum_from_page (value: INTEGER) is
			-- Make `value' the new minimum `from_page' value.
		require
			positive_value: value > 0
			not_greater_than_maximum_value: value <= maximum_to_page
		deferred
		ensure
			minimum_from_page_set: minimum_from_page = value
		end

feature {NONE} -- Implementation

	internal_accept: STRING is
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- See comment in EV_STANDARD_DIALOG_I.
		do
			Result := ev_print
		end

end -- class EV_PRINT_DIALOG_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

