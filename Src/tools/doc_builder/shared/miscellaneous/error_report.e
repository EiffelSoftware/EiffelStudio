indexing
	description: "Error reports with optional line number information and context action."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_REPORT

inherit
	SHARED_OBJECTS

create
	make,
	make_empty

feature -- Creation

	make_empty (a_title: STRING) is
			-- Make with no error
		require
			title_not_void: a_title /= Void
		do
			create messages.make (5)
			title := a_title
		ensure
			has_message_list: messages /= Void
			has_no_error: messages.count = 0
		end		

	make (a_title, a_message: STRING; line_no, line_pos: INTEGER) is
			-- New error with `a_message' on `line_no' at position `line_pos'
		require
			title_not_void: a_title /= Void
			message_not_void: a_message /= Void
		do
			create messages.make (5)
			title := a_title
			append_error (a_message, line_no, line_pos)
		ensure
			has_message_list: messages /= Void
			has_error: messages.count > 0
		end		

feature -- Status Setting	

	append_error (a_message: STRING; line_no, line_pos: INTEGER) is
			-- Append error
		require
			message_not_void: a_message /= Void
		do
			messages.extend ([a_message, line_no, line_pos])
		ensure
			has_new_error: messages.count = old messages.count + 1
		end		

	append_report (a_report: like Current) is
			-- Append `a_report' to end of Current
		do
		    messages.append (a_report.messages)
		end		

	set_error_action (a_action: PROCEDURE [ANY, TUPLE [EV_LIST_ITEM]]) is
			-- Set `a_action' to call when error message is double clicked
		require
			action_not_void: a_action /= Void
		do
			action := a_action
		end

feature -- Query

	is_empty: BOOLEAN is
			-- Is Current empty?
		do
			Result := messages.is_empty
		end	

feature -- Access

	title: STRING
			-- Title indicating type of errors in `messages'

	messages: ARRAYED_LIST [TUPLE [STRING, INTEGER, INTEGER]]
			-- Error message(s)
			
	line_number: INTEGER
			-- Error line number
			
	line_position: INTEGER
			-- Error line position

	messages_text: STRING is
			-- All error messages in text representation
		local
			l_message: STRING
		do
			create Result.make_from_string (title)
			Result.append ("%N")
			from
				messages.start
			until
				messages.after
			loop
				l_message ?= messages.item @ 1
				if l_message /= Void then
					Result.append (l_message)
					Result.append ("%N")
				end
				messages.forth
			end
		end		

feature -- Commands

	show is
			-- Show error
		do
			if is_empty then
				append_error (no_error_string, 0,0)
			end
			if Shared_constants.Application_constants.is_gui_mode then
				show_as_message_dialog
			else
				show_command_prompt
			end	
		end		

	clear is
			-- Clear error report
		do
			if messages /= Void then
				messages.wipe_out	
			end	
		end	

feature {NONE} -- Commands

	show_command_prompt is
			-- Show error (s) on command prompt.
		local
			l_output_file: PLAIN_TEXT_FILE
		do			
			io.put_string (title)
			io.put_new_line
			io.putstring (messages_text)
			l_output_file := Shared_constants.Application_constants.Script_output
			l_output_file.open_append
			l_output_file.putstring ("%NError: ")
			l_output_file.putstring (messages_text)
			l_output_file.close
		end		

	show_as_message_dialog is
			-- 	Show error in message dialog with OK button
		do			
			Shared_dialogs.error_dialog.set_error_list (messages)
			Shared_dialogs.Error_dialog.set_title (title)
			if action /= Void then
				Shared_dialogs.error_dialog.set_error_action (action)
			end
			Shared_dialogs.error_dialog.show_relative_to_window (window)
		end

feature {NONE} -- Implementation

	action: PROCEDURE [ANY, TUPLE [EV_LIST_ITEM]]
			-- Internal action

	window: EV_WINDOW is
			-- Window
		once
			Result := Application_window
		end		

	no_error_string: STRING is "No errors found"

invariant
	has_title: title /= Void
	has_message_list: messages /= Void

end -- class ERROR_REPORT
