indexing
	description: "Command to open a file, and display warnings in case of errors"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_OPENER

inherit
	EV_COMMAND

	NEW_EB_CONSTANTS

creation
	make_default

feature {NONE} -- Initialization

	make_default (par: EV_CONTAINER; a_caller: EB_FILE_OPENER_CALLBACK; fn: STRING) is
			-- Initialize
		local
			aok: BOOLEAN
			wd: EV_WARNING_DIALOG
		do
			caller := a_caller
			if not fn.empty then
				create file.make (fn)
				aok := True
				if file.exists and then not file.is_plain then
					aok := False
					create wd.make_default (par, Interface_names.t_Warning,
						Warning_messages.w_Not_a_plain_file (fn))
				elseif file.exists and then file.is_writable then
					aok := False
					create wd.make_with_text (par, Interface_names.t_Warning,
						Warning_messages.w_File_exists (fn))
					wd.show_ok_cancel_buttons
					wd.add_ok_command (Current, Void)
					wd.show
				elseif file.exists and then not file.is_writable then
					aok := False
					create wd.make_default (par, Interface_names.t_Warning,
						Warning_messages.w_Not_writable (fn))
				elseif not file.is_creatable then
					aok := False
					create wd.make_default (par, Interface_names.t_Warning,
						Warning_messages.w_Not_creatable (fn))
				end
			else
				aok := False
				create wd.make_default (par, Interface_names.t_Warning,
					Warning_messages.w_Not_a_plain_file (fn))
			end
			if aok then caller.save_file (file) end
		end

feature {NONE} -- Execution

	execute	(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			caller.save_file (file)
		end

feature {NONE} -- Implementation

	file: RAW_FILE
		-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N

	caller: EB_FILE_OPENER_CALLBACK

end -- class EB_FILE_OPENER
