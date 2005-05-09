indexing
	description: "Error reports with optional line number information and context action."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_REPORT

inherit
	SHARED_OBJECTS
	
feature -- Status Setting	

	set_error (a_error: ERROR) is
			-- Set error
		do
			error := a_error
		ensure
			has_new_error: error = a_error
		end	

feature -- Access
		
	error: ERROR
			-- Error	
		
	actions: ERROR_ACTIONS is
			-- Available error response actions
		once
			create Result
		end

feature -- Commands

	clear is
			-- Clear
		do
			error := Void
		end		

	show is
			-- Show error
		do			
			if shared_constants.Application_constants.is_gui_mode then
				show_as_message_dialog
			else
				show_command_prompt
			end	
		end		

feature {NONE} -- Commands

	show_command_prompt is
			-- Show error(s) on command prompt.
		local
			l_output_file: PLAIN_TEXT_FILE
		do			
			io.put_string (title)
			io.put_new_line
			io.putstring (error.description)
			l_output_file := Shared_constants.Application_constants.Script_output
			l_output_file.open_append
			l_output_file.putstring ("%NError: ")
			l_output_file.putstring (error.description)
			l_output_file.close
		end		

	show_as_message_dialog is
			-- Show error in message dialog with OK button
		do			
			shared_dialogs.error_dialog.set_error (error, title)
			shared_dialogs.error_dialog.show_relative_to_window (window)
		end

feature {NONE} -- Implementation

	title: STRING is "Report"

	window: EV_WINDOW is
			-- Window
		once
			Result := Application_window
		end		

invariant
	has_title: title /= Void

end -- class ERROR_REPORT
