indexing
	description: "Command to open a new ace file."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_SYSTEM_CMD

inherit
	SHARED_EIFFEL_PROJECT
	EB_EDITOR_COMMAND
		redefine
			tool
		end
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
			-- Open a file.
		local
			fn: STRING
			f: PLAIN_TEXT_FILE
			temp: STRING
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
			if argument = Void then
					-- First click on open
				if tool.text_window.changed then
--					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
--						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				else
					create fod.make (tool.parent)
					fod.set_filter (<<"System File (*.ace)">>, <<"*.ace">>)
					create arg.make (fod)
					fod.add_ok_command (Current, arg)
					fod.show
				end
			else
				fn := argument.first.file
				if not fn.empty then
					create f.make (fn)
					if
						f.exists and then f.is_readable and then f.is_plain
					then
						tool.show_file (f)
						Eiffel_ace.set_file_name (fn)
					elseif f.exists and then not f.is_plain then
--						warner (popup_parent).custom_call (Current,
--							Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					else
--						warner (popup_parent).custom_call (Current, 
--						Warning_messages.w_Cannot_read_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					end
				else
--					warner (popup_parent).custom_call (Current,
--						Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				end
			end
		end

feature {NONE} -- Attributes

	tool: EB_SYSTEM_TOOL

end -- class EB_OPEN_SYSTEM_CMD
