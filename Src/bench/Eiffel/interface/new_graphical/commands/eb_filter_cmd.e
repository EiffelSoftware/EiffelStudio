indexing
	description: "Command to filter the text in some way."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILTER_CMD

inherit
	EIFFEL_ENV

	EB_EDITOR_COMMAND
		redefine
			tool
		end

	EB_GENERAL_DATA
	EB_SHARED_FORMAT_TABLES
	EB_CONFIRM_SAVE_CALLBACK

creation
	make

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
			-- If it comes here this means ok has
			-- been pressed in the warner window
			-- for text modification.
		do
			tool.last_format.filter (filter_name)
		end

feature -- Properties

	filter_window: EB_FILTER_DIALOG
			-- Associated popup window

	filter_it: EV_ARGUMENT1 [ANY] is
			-- Argument for the command.
		once
			create Result.make (Void)
		end

	filter_name: STRING is
			-- Name of the filter to be applied
		local
			filter_dir: DIRECTORY
			file_name, dir_entry: STRING
			found: BOOLEAN
		once
			Result := General_resources.filter_name.value
				-- Check whether that filter exists or not.
			create filter_dir.make (filter_path)
			if filter_dir.exists and then filter_dir.is_readable then
				from
					file_name := clone (Result)
					file_name.to_lower
					file_name.append (".fil")
					filter_dir.open_read
					filter_dir.start
					filter_dir.readentry
					dir_entry := filter_dir.lastentry
				until
					found or dir_entry = Void
				loop
					dir_entry.to_lower
					found := dir_entry.is_equal (file_name)
					filter_dir.readentry
					dir_entry := filter_dir.lastentry
				end
			end
			if not found then
				Result := ""
			end
		end

feature {EB_FILTER_DIALOG} -- Implementation

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- If left mouse button was pressed -> execute filter.
			-- If right mouse button was pressed -> bring up filter window. 
		local
			cmd_string: STRING
			filterable_format: EB_FILTERABLE
			shell_request: EXTERNAL_COMMAND_EXECUTOR
			filename, new_text: STRING
--			mp: MOUSE_PTR
			wd: EV_WARNING_DIALOG
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if argument = Void then
					-- Popup filter window
--				create mp.set_watch_cursor
				create filter_window.make_with_command (Current)
--				mp.restore
				filter_window.call (Current)
			elseif argument = filter_it then
					-- Display the filter output in `text_window'
				if tool.text_window.changed then
					create csd.make_and_launch (tool, Current)
				else
					process
				end
			elseif tool.stone /= Void then
					-- Execute the shell command
				filterable_format ?= tool.last_format
				if filterable_format = Void then
					create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Not_a_filterable_format)
				else
--					create mp.set_watch_cursor
					if 
						filterable_format.filtered and
						equal (filterable_format.filter_name, filter_name) 
					then
							-- The filtered text is in `text_window'
						filename := filterable_format.temp_filtered_file_name
										(tool.stone, filter_name)
						save_to_file (tool.text_window.text, filename)
						tool.text_window.set_changed (false)
					else
						new_text := filterable_format.filtered_text 
										(tool.stone, filter_name) 
							-- `filtered_text' of FILTERABLE has a side effect
							-- (i.e. set the suffix to be used to build the
							-- targetted file name) and as a consequence we
							-- cannot put the next line outside of the
							-- if-instruction.
						filename := filterable_format.temp_filtered_file_name
										(tool.stone, filter_name)
						if new_text /= Void then
							save_to_file (new_text, filename)
						end
					end
					cmd_string := clone (General_resources.filter_command.value)
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$target", filename)
					end
					create shell_request
					shell_request.execute (cmd_string)
--					mp.restore
				end
			end
		end
	
feature {NONE} -- Implementation

	save_to_file (a_text: STRING a_filename: STRING) is
			-- Save `a_text' in `a_filename'.
		require
			a_text_not_void: a_text /= Void
			a_filename_not_void: a_filename /= Void
		local
			char: CHARACTER
			new_file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
		do
			if not a_filename.empty then
				create new_file.make (a_filename)
				if new_file.exists and then not new_file.is_plain then
					create wd.make_default (tool.parent, Interface_names.t_Warning, 
						Warning_messages.w_Not_a_plain_file (new_file.name))
				elseif new_file.exists and then not new_file.is_writable then
					create wd.make_default (tool.parent, Interface_names.t_Warning, 
						Warning_messages.w_Not_writable (new_file.name))
				elseif not new_file.exists and then not new_file.is_creatable then
					create wd.make_default (tool.parent, Interface_names.t_Warning, 
						Warning_messages.w_Not_creatable (new_file.name))
				else
					new_file.open_write
					if not a_text.empty then
						new_file.putstring (a_text)
						char := a_text.item (a_text.count)
						if Platform_constants.is_unix and then char /= '%N' and then char /= '%R' then
								-- Add a carriage return like vi 
								-- if there's none at the end
							new_file.new_line
						end
					end
					new_file.close
				end
			end
		end

feature -- Access

	tool: EB_MULTIFORMAT_EDIT_TOOL

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Filter
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Filter
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

invariant

	filter_name_not_void: filter_name /= Void

end -- class EB_FILTER_CMD
