indexing
	description: "Process warnings and errors."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MESSAGE_OUTPUT

inherit
	WIZARD_MESSAGES
		export
			{NONE} all
		end

	WIZARD_WARNINGS
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_LOGGER
		export
			{NONE} all
		end

	WIZARD_OUTPUT_LEVEL
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

feature -- Access

	output_window: WIZARD_OUTPUT_WINDOW is
			-- Output window
		do
			Result := output_window_cell.item
		end

feature -- Element setting

	set_output_window (a_output_window: WIZARD_OUTPUT_WINDOW) is
			-- Set `output_window' to `a_output_window.
		require
			non_void_output_window: a_output_window /= Void
		do
			output_window_cell.replace (a_output_window)
		ensure
			output_window_set: output_window = a_output_window
		end

feature -- Basic operations

	add_message (origin: ANY; reason: STRING) is
			-- Display message.
		do
			if Shared_wizard_environment.output_level = Output_all then
				output_window.add_message (reason)
			end
			add_log (origin, reason)
		end

	add_warning (origin: ANY; reason: STRING) is
			-- Display warning.
		do
			if Shared_wizard_environment.output_level = Output_warnings or 
					Shared_wizard_environment.output_level = Output_all 
			then
				output_window.add_warning (reason)
			end
			add_log (origin, reason)
		end

	add_error (origin: ANY; reason: STRING) is
			-- Display error.
		do
			output_window.add_error (reason)
			add_log (origin, reason)
		end

feature {NONE} -- Implementation

	output_window_cell: CELL [WIZARD_OUTPUT_WINDOW] is
			-- Output window holder
		once
			create Result.put (Void)
		end

end -- class WIZARD_MESSAGE_OUTPUT

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

