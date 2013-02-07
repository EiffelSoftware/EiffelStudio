--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
note
	description: "EiffelVision print dialog, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	from_page: INTEGER
			-- Value for the starting page edit control
		require
		deferred
		ensure
			positive_result: Result >= 0
		end

	to_page: INTEGER
			-- Value for the ending page edit control
		require
		deferred
		ensure
			positive_result: Result >= 0
		end

	copies: INTEGER
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

	output_file_name: STRING_32
			-- String representation of the path to output
			-- the printed area to.
		require
		deferred
		ensure
			result_not_void: Result /= Void
		end

	printer_name: STRING_32
			-- String representation of the printer to output
			-- the printed area to.
		require
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	all_pages_selected: BOOLEAN
			-- Is the "All pages" radio button selected?
		require
		deferred
		end

	page_numbers_selected: BOOLEAN
			-- Is the "Range" radio button selected?
		require
		deferred
		end

	selection_selected: BOOLEAN
			-- Is the "Selection" radio button selected?
		require
		deferred
		end

	page_numbers_enabled: BOOLEAN
			-- Is the "Range" radio button enabled?
		require
		deferred
		end

	selection_enabled: BOOLEAN
			-- Is the "Selection" radio button selected?
		require
		deferred
		end

	collate_checked: BOOLEAN
			-- Is the "Collate" check box checked?
		require
		deferred
		end

	print_to_file_enabled: BOOLEAN
			-- Is the "File" radio button enabled?
		require
		deferred
		end

	print_to_file_shown: BOOLEAN
			-- Is the "File" radio button visible?
		require
		deferred
		end

	print_to_file_checked: BOOLEAN
                        -- Is the "File" radio button checked?
                require
		deferred
		end

	landscape_checked: BOOLEAN
			-- Is the landscape option selected.
		require
		deferred
		end

	print_context: EV_PRINT_CONTEXT
			-- Return a print context for the dialog box.
		local
			context: EV_PRINT_CONTEXT
		do
			create context
			if attached selected_button as l_selected_button and then not l_selected_button.same_string (ev_cancel) then
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
				context.set_file_path (create {PATH}.make_from_string (output_file_name))
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
			end
			Result := context
		end

feature -- Status setting

	select_all_pages
			-- Select the "All pages" radio button.
                        -- Selected by default.
                require
		deferred
		end

	select_page_numbers
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		require
		deferred
		end

	select_selection
			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		require
		deferred
		end

	enable_page_numbers
			-- Enable the "Range" radio button.
		require
		deferred
		end

	disable_page_numbers
			-- Disable the "Range" radio button.
		require
		deferred
		end

	enable_selection
			-- Enable the "Selection" radio button.
		require
		deferred
		end

	disable_selection
			-- Disable the "Selection" radio button.
		require
		deferred
		end

	check_collate
			-- Check the "Collate" check box.
		require
		deferred
		ensure
			collate_checked: collate_checked
		end

	uncheck_collate
			-- Uncheck the "Collate" check box.
		require
		deferred
		ensure
			colate_not_checked: not collate_checked
		end

	enable_print_to_file
			-- Enable the "Print to file" check box.
		require
		deferred
		end

	disable_print_to_file
			-- Disable the "Print to file" check box.
		require
		deferred
		end

	show_print_to_file
			-- Show the "Print to file" check box.
		require
		deferred
		end

	hide_print_to_file
			-- Hide the "Print to file" check box.
		require
		deferred
		end

	check_print_to_file
			-- Check the "Print to file" check box.
		require
		deferred
		ensure
			print_to_file_checked: print_to_file_checked
		end

	uncheck_print_to_file
			-- Check the "Print to file" check box.
		require
		deferred
		ensure
			print_to_file_not_checked: not print_to_file_checked
		end

feature -- Element change

	set_from_page (value: INTEGER)
			-- Make `value' the new `from_page' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			from_page_set: from_page = value
		end

	set_to_page (value: INTEGER)
			-- Make `value' the new `to_page' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			to_page_set: to_page = value
		end

	set_copies (value: INTEGER)
			-- Make `value' the new `copies' number.
		require
			positive_value: value >= 0
		deferred
		ensure
			copies_set: copies = value
		end

	set_maximum_to_page (value: INTEGER)
			-- Make `value' the new maximum `to_page' value.
		require
			positive_value: value > 0
			not_less_than_minimum: value >= minimum_from_page
		deferred
		ensure
			maximum_to_page_set: maximum_to_page = value
		end

	set_minimum_from_page (value: INTEGER)
			-- Make `value' the new minimum `from_page' value.
		require
			positive_value: value > 0
			not_greater_than_maximum_value: value <= maximum_to_page
		deferred
		ensure
			minimum_from_page_set: minimum_from_page = value
		end

feature {NONE} -- Implementation

	internal_accept: IMMUTABLE_STRING_32
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- See comment in EV_STANDARD_DIALOG_I.
		do
			Result := ev_print
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_DIALOG_I





