indexing
	description: "Command to open a new ace file."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_SYSTEM_CMD

inherit
	EB_OPEN_FILE_CMD
		redefine
			tool, process,
			execute
		end

creation
	make

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		local
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
			create fod.make (tool.parent)
--			fod.set_filter (<<"System File (*.ace)">>, <<"*.ace">>)
			create arg.make (fod)
			fod.add_ok_command (Current, arg)
			fod.show
		end
	
feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
			-- Open a file.
		local
			fn: STRING
			f: PLAIN_TEXT_FILE
			temp: STRING
			wd: EV_WARNING_DIALOG
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if argument = Void then
					-- First click on open
				if tool.text_area.changed then
					create csd.make_and_launch (tool, Current)
				else
					process
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
						create wd.make_with_text (tool.parent, Interface_names.t_Warning,
							Warning_messages.w_Not_a_file_retry (fn))
						wd.show_ok_cancel_buttons
						wd.add_ok_command (Current, Void)
						wd.show
					else
						create wd.make_with_text (tool.parent, Interface_names.t_Warning,
							Warning_messages.w_Cannot_read_file_retry (fn))
						wd.show_ok_cancel_buttons
						wd.add_ok_command (Current, Void)
						wd.show
					end
				else
					create wd.make_with_text (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Not_a_file_retry (fn))
					wd.show_ok_cancel_buttons
					wd.add_ok_command (Current, Void)
					wd.show
				end
			end
		end

feature {NONE} -- Attributes

	tool: EB_SYSTEM_TOOL

end -- class EB_OPEN_SYSTEM_CMD
