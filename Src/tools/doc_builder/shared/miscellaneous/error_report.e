indexing
	description: "Error reports with optional line number information and context action."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_REPORT

inherit
	SHARED_OBJECTS

create
	make

feature -- Creation

	make (a_context: STRING) is
			-- Make with error context
		require
			context_not_void: a_context /= Void
		do
			create errors.make (1)
			title := a_context
		ensure
			has_error_list: errors /= Void
			has_no_error: errors.count = 0
		end			

feature -- Status Setting	

	append_error (a_error: ERROR) is
			-- Append error
		require
			error_not_void: a_error /= Void
		do
			errors.extend (a_error)
		ensure
			has_new_error: errors.count = old errors.count + 1
		end	

feature -- Query

	is_empty: BOOLEAN is
			-- Is Current empty?
		do
			Result := errors.is_empty
		end	

feature -- Access

	title: STRING
			-- Title indicating type of errors in `errors'

	errors: ARRAYED_LIST [ERROR]
			-- Individual errors
			
	errors_text: STRING is
			-- All error errors in text representation
		local
			l_message: STRING
		do
			create Result.make_from_string (title)
			Result.append ("%N")
			from
				errors.start
			until
				errors.after
			loop
				l_message ?= errors.item.description
				if l_message /= Void then
					Result.append (l_message)
					Result.append ("%N")
				end
				errors.forth
			end
		end		
		
	actions: ERROR_ACTIONS is
			-- Available error response actions
		once
			create Result
		end

feature -- Commands

	show is
			-- Show error
		do
			if is_empty then
				append_error (empty_error)
			end
			if shared_constants.Application_constants.is_gui_mode then
				show_as_message_dialog
			else
				show_command_prompt
			end	
		end		

	clear is
			-- Clear error report
		do
			if errors /= Void then
				errors.wipe_out	
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
			io.putstring (errors_text)
			l_output_file := Shared_constants.Application_constants.Script_output
			l_output_file.open_append
			l_output_file.putstring ("%NError: ")
			l_output_file.putstring (errors_text)
			l_output_file.close
		end		

	show_as_message_dialog is
			-- Show error in message dialog with OK button
		do			
			shared_dialogs.error_dialog.set_error_list (errors, title)
			shared_dialogs.error_dialog.show_relative_to_window (window)
		end

feature {NONE} -- Implementation

	window: EV_WINDOW is
			-- Window
		once
			Result := Application_window
		end		

	empty_error: ERROR is 
			-- Empty error
		once
			create Result.make ("No errors found")	
		end

invariant
	has_title: title /= Void
	has_message_list: errors /= Void

end -- class ERROR_REPORT
