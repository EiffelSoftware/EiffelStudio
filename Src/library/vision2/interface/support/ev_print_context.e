indexing
	description:
		"EiffelVision 2 Printer Context, see EV_PRINT_DIALOG"
	status: "See notice at end of class"
	keywords: "print, printer, context"

class
	EV_PRINT_CONTEXT
													
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

	output_to_file: BOOLEAN
		-- Will output be to file.

	printer_name: STRING
		-- Name of printer.

	file_name: STRING
		-- Name of output file.

	portrait: BOOLEAN
		-- Will print output be portrait.

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

	set_printer_name (a_string: STRING) is
			-- Set "printer_name" to "a_string".
		require
			a_string_not_empty: a_string.count > 0
		do
			printer_name := a_string
		ensure
			printer_name_set: printer_name = a_string
		end

	set_file_name (a_string: STRING) is
			-- Set "file_name" to "a_string".
		require
			a_string_not_empty: a_string.count > 0
		do
			file_name := a_string
		ensure
			file_name_set: file_name = a_string
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

feature {EV_PRINT_DIALOG_I, EV_PRINT_PROJECTOR_I} -- Implementation

	printer_context: POINTER
			-- Pointer to the chosen printers handle.

	set_printer_context (a_context: POINTER) is
			-- Set `printer_context' to `a_context'.
		do
			printer_context := a_context
		end	

end -- class EV_PRINT_CONTEXT

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
