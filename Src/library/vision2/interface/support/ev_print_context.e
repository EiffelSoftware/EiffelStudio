indexing
	description:
		"EiffelVision 2 Printer Context, see EV_PRINT_DIALOG"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "print, printer, context"

class
	EV_PRINT_CONTEXT

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create `Current' in default state.
		do
			selection_type := all_pages
			copies := 1
			output_to_file := False
			printer_name := "Default"
			portrait := True
			horizontal_resolution := 575
			vertical_resolution := 759
			portrait := True
		end

feature {NONE} -- Initialization

	all_pages: INTEGER is 0
		-- Constant for print all pages setting.

	page_range: INTEGER is 1
		-- Constant for print a range of pages setting.

	selection: INTEGER is 2
		-- Constant for print a selection of pages setting.

feature -- Access	

	from_page: INTEGER
		-- Page print job starts from.

	to_page: INTEGER
		-- Page print job prints to.

	copies: INTEGER
		-- Number of copies of print job.

	selection_type: INTEGER
		-- Type code of chosen selection.
		-- corresponds to `all_pages', `page_range'
		-- or `selection'.

	output_to_file: BOOLEAN
		-- Will output be to file?

	printer_name: STRING_32
		-- Name of printer.

	horizontal_resolution: INTEGER
		-- Horizontal resolution in points (1/72 of an inch), equating to full width
		-- of printed page.

	vertical_resolution: INTEGER
		-- Vertical resolution in points (1/72 of an inch), equating to full height
		-- of printed page.

	file_name: STRING_32
		-- Name of output file.

	portrait: BOOLEAN
		-- Will print output be portrait?

feature {EV_PRINT_DIALOG_I} -- Status setting

	set_selection_to_all is
			-- Set the "selection_type" to be "all_pages".
		do
			selection_type := all_pages
		ensure
			selection_type_set: selection_type = all_pages
		end

	set_selection_to_range is
			-- Set the "selection_type" to be "page_range".
		do
			selection_type := page_range
		ensure
			selection_type_set: selection_type = page_range
		end

	set_selection_to_selection is
			-- Set the "selection_type" to be "selection".
		do
			selection_type := selection
		ensure
			selection_type_set: selection_type = selection
		end

	set_range (a_from_value, a_to_value: INTEGER) is
			-- Set "from_page" to "a_from_value" and
			-- "to_page" to "a_to_page".
		require
			a_from_value_not_negative: a_from_value >= 0
			a_to_value_not_negative: a_to_value >= 0
			non_negative_range: a_from_value <= a_to_value
		do
			from_page := a_from_value
			to_page := a_to_value
		ensure
			from_page_set: from_page = a_from_value
			to_page_set: to_page = a_to_value
			non_negative_range: from_page <= to_page
		end

	set_copies (a_value: INTEGER) is
			-- Set "copies" to "a_value".
		require
			a_value_positive: a_value > 0
		do
			copies := a_value
		ensure
			copies_set: copies = a_value
		end

	set_printer_name (a_string: STRING_GENERAL) is
			-- Set "printer_name" to "a_string".
		require
			a_string_not_empty: a_string.count > 0
		do
			printer_name := a_string
		ensure
			printer_name_set: printer_name = a_string
		end

	set_file_name (a_string: STRING_GENERAL) is
			-- Set "file_name" to "a_string".
		require
			a_string_not_empty: a_string.count > 0
		do
			file_name := a_string
		ensure
			file_name_set: file_name = a_string
		end

	set_horizontal_resolution (resolution: INTEGER) is
			-- Assign `resolution' to `horizontal_resolution'.
		require
			resolution_positive: resolution > 0
		do
			horizontal_resolution := resolution
		ensure
			resolution_set: horizontal_resolution = resolution
		end

	set_vertical_resolution (resolution: INTEGER) is
			-- Assign `resolution' to `vertical_resolution'.
		require
			resolution_positive: resolution > 0
		do
			vertical_resolution := resolution
		ensure
			resolution_set: vertical_resolution = resolution
		end

	set_portrait is
			-- Set "portrait" to "True".
		do
			portrait := True
		ensure
			portrait_true: portrait
		end

	set_landscape is
			-- Set "portrait" to "False".
		do
			portrait := False
		ensure
			portrait_false: not portrait
		end

	set_output_to_printer is
			-- Set "output_to_file" to "False".
		do
			output_to_file := False
		ensure
			output_to_file_false: not output_to_file
		end

	set_output_to_file is
			-- Set "output_to_file" to "True".
		do
			output_to_file := True
		ensure
			output_to_file_true: output_to_file
		end

feature {EV_PRINT_DIALOG_I, EV_PRINT_PROJECTOR_I, EV_MODEL_PRINT_PROJECTOR_I} -- Implementation

	printer_context: POINTER
			-- Pointer to the chosen printers handle.

	set_printer_context (a_context: POINTER) is
			-- Set `printer_context' to `a_context'.
		do
			printer_context := a_context
		end

invariant
	selection_type_valid: selection_type = all_pages or selection_type = page_range
		or selection_type = selection

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_CONTEXT

