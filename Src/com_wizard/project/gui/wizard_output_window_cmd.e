indexing
	description: "Console application output"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_WINDOW_CMD

inherit 
	WIZARD_OUTPUT_WINDOW

feature -- Basic Operations

	add_title (a_text: STRING) is
			-- Add `a_text' to output using title format.
		do
			io.put_string (a_text)
			io.put_string ("%N")
		end

	add_message (a_text: STRING) is
			-- Add `a_text' to output using standard format.
		do
			io.put_string (a_text)
			io.put_string ("%N")
		end

	add_continuous_message (a_text: STRING) is
			-- Add `a_text' to output using standard format.
			-- Do not add new line.
		do
			io.put_string (a_text)
		end

	add_warning (a_text: STRING) is		
			-- Add `a_text' to output using warning format.
		do
			io.put_string (a_text)
			io.put_string ("%N")
		end

	add_error (a_text: STRING) is		
			-- Add `a_text' to output using error format.
		do
			io.put_string (a_text)
			io.put_string ("%N")
		end

	clear is
			-- Clear output.
		do
		end

	refresh is
			-- Refresh output.
		do
		end

end -- class WIZARD_OUTPUT_WINDOW_CMD

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
