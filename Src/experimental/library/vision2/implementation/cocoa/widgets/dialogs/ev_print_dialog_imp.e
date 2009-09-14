note
	description: "Eiffel Vision print dialog. Cocoa implementation."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I
		redefine
			interface,
			print_context
		select
			copy
		end

	EV_STANDARD_DIALOG_IMP
		undefine
			internal_accept,
			cocoa_copy
		redefine
			interface,
			make,
			show_modal_to_window,
			dispose
		end

	NS_PRINT_PANEL
		rename
			make as cocoa_panel_make,
			item as cocoa_panel,
			screen as cocoa_screen,
			set_background_color as cocoa_set_background_color,
			background_color as cocoa_background_color,
			title as cocoa_title,
			set_title as cocoa_set_title,
			copy as cocoa_copy
		undefine
			is_equal
		redefine
			dispose
		select
			make_window,
			cocoa_panel,
			cocoa_screen
		end

create
	make

feature {NONE} -- Initialization

	make
				-- Setup window and action sequences.
		do
			create print_panel.make
			Precursor {EV_STANDARD_DIALOG_IMP}
			enable_closeable
			minimum_from_page := 1
			maximum_to_page := 1
			forbid_resize
			set_is_initialized (True)
		end

	show_modal_to_window (a_window: EV_WINDOW)
		local
			ret: INTEGER
		do
			ret := print_panel.run_modal
		end


	set_output_to_printer
			-- enable/disable appropriate text fields
		do
		end

	set_output_to_file
			-- enable/disable appropriate text fields
		do
		end

	range_spin_buttons_enable_sensitive
			-- Enable spin buttons for range selection
		do
		end

	from_spin_button_value_change
			-- Reset max and min values of 'to' button when input changes
		do
		end

	to_spin_button_value_change
			-- Reset max and min values of 'from' button when input changes
		do
		end

	range_spin_buttons_disable_sensitive
			-- Disable spin buttons for range selection
		do
		end

	toggle_collate_pages
			-- toggle collate status pixmap
		do
		end

feature -- Access

	print_context: EV_PRINT_CONTEXT
			-- Return a print context from the dialog
		local
			pspc: EV_POSTSCRIPT_PAGE_CONSTANTS
			page_constant: INTEGER
		do
			Result := Precursor {EV_PRINT_DIALOG_I}

				-- Set the vertical and horizontal resolutions.
			create pspc
			page_constant := pspc.Letter

			Result.set_horizontal_resolution (pspc.page_width (page_constant, landscape_checked) - (2 * pspc.Default_left_margin))
			Result.set_vertical_resolution (pspc.page_height (page_constant, landscape_checked) - (2 * pspc.Default_bottom_margin))
		end

	from_page: INTEGER
			-- Value for the starting page edit control
		do
		end

	to_page: INTEGER
			-- Value for the ending page edit control
		do
		end

	copies: INTEGER
			-- Number of copies for the Copies edit control
		do
		end

	output_file_name: STRING_32
			-- String representation of the path to output
			-- the printed area to.
		do
			create Result.make_empty
		end

	printer_name: STRING_32
			-- String representation of the printer to output
			-- the printed area to.
		do
			create Result.make_empty
		end

feature -- Status report

	all_pages_selected: BOOLEAN
			-- Is the "All pages" radio button selected?
		do
		end

	page_numbers_selected: BOOLEAN
			-- Is the "Page" radio button selected?
		do
		end

	selection_selected: BOOLEAN
			 -- Is the "Selection" radio button selected?
		do
		end

	page_numbers_enabled: BOOLEAN
			-- Is the "Range" radio button enabled?
		do
		end

	selection_enabled: BOOLEAN
			-- Is the "Selection" radio button selected?
		do
		end

	collate_checked: BOOLEAN
			-- Is the "Collate" check box checked?
		do
		end

	print_to_file_enabled: BOOLEAN
			-- Is the "File" radio button enabled?
		do
		end

	print_to_file_shown: BOOLEAN
			-- Is the "File" radio button visible?
		do
		end

	print_to_file_checked: BOOLEAN
			-- Is the "File" radio button checked?
		do
		end

	landscape_checked: BOOLEAN
			-- Is the "Landscape" radio button checked?
		do
 		end

feature -- Status setting

	select_all_pages
			-- Select the "All pages" radio button.
			-- Selected by default.
		do
		end

	select_page_numbers
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		do
		end

 	select_selection
  			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		do
		end

	enable_page_numbers
			-- Enable the "Range" radio button.
		do
		end

	disable_page_numbers
			-- Disable the "Range" radio button.
		do
		end

	enable_selection
			-- Enable the "Selection" radio button.
		do
		end

	disable_selection
			-- Disable the "Selection" radio button.
		do
		end

	check_collate
                        -- Check the "Collate" check box.
		do
		end

	uncheck_collate
			-- Uncheck the "Collate" check box.
		do
		end

	enable_print_to_file
			-- Enable the "File" radio button.
		do
		end

	disable_print_to_file
			-- Disable the "File" radio button.
		do
		end

	show_print_to_file
			-- Show the "File" radio button.
		do
		end

	hide_print_to_file
			-- Hide the "File" radio button.
		do
		end

	check_print_to_file
			-- Check the "File" check box.
			-- By default, the "Printer" button is selected.
		do
		end

        uncheck_print_to_file
			-- Uncheck the "File" check box.
			-- By default, the "Printer" button is selected.
		do
		end

feature -- Element change

	set_from_page (value: INTEGER)
			 -- Make `value' the new `from_page' number.
		do
  		end

	set_to_page (value: INTEGER)
			-- Make `value' the new `to_page' number.
		do
		end

	set_copies (value: INTEGER)
			-- Make `value' the new `copies' number.
		do

		end

	set_maximum_to_page (value: INTEGER)
			-- Make `value' the new maximum `to_page' value.
		do
			maximum_to_page := value
		end

	set_minimum_from_page (value: INTEGER)
			-- Make `value' the new minimum `from_page' value.
		do
			minimum_from_page := value
		end

feature {NONE} -- Implementation

	Letter: STRING = "Letter"
	Legal: STRING = "Legal"
	Executive: STRING = "Executive"
	Ledger: STRING = "Ledger"
	A4: STRING = "A4"
	A5: STRING = "A5"
	B5: STRING = "B5"
	C5: STRING = "C5"

	print_panel: NS_PRINT_PANEL

	dispose
		do
			Precursor {NS_PRINT_PANEL}
			Precursor {EV_STANDARD_DIALOG_IMP}
		end

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: detachable EV_COLOR_DIALOG note option: stable attribute end;

end -- class EV_PRINT_DIALOG_IMP
