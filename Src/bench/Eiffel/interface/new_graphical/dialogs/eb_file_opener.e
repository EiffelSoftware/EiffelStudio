indexing
	description: "Command to open a file, and display warnings in case of errors"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_OPENER

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_with_parent

feature {NONE} -- Initialization

	make_with_parent (caller: EB_FILE_OPENER_CALLBACK; fn: STRING; parent_window: EV_WINDOW) is
			-- Initialize with parent window `a_parent'
		local
			aok: BOOLEAN
			wd: EV_WARNING_DIALOG
			qd: EV_QUESTION_DIALOG
			warning_message: STRING
			file: RAW_FILE -- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
		do
			if not fn.is_empty then
				create file.make (fn)
				aok := True
				if file.exists and then not file.is_plain then
					warning_message := Warning_messages.w_Not_a_plain_file (fn)
					
				elseif file.exists and then not file.is_writable then
					warning_message := Warning_messages.w_Not_writable (fn)
					
				elseif not file.is_creatable then
					warning_message := Warning_messages.w_Not_creatable (fn)
					
				elseif file.exists and then file.is_writable then
					create qd.make_with_text (Warning_messages.w_File_exists (fn))
					qd.show_modal_to_window (parent_window)
					aok := qd.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_yes)
				end
			else
				warning_message := Warning_messages.w_Not_a_plain_file (fn)
			end
			
			if warning_message /= Void then
				aok := False
				create wd.make_with_text (warning_message)
				wd.show_modal_to_window (parent_window)
			end
			
			if aok then 
				caller.save_file (file)
			end
		end

end -- class EB_FILE_OPENER
