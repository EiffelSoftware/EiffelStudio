indexing
	description: "Command to filter the text in some way."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILTER_CMD

inherit
	EIFFEL_ENV

	EB_TEXT_TOOL_CMD
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
			-- been pressed in the warner dialog
			-- for text modification.
		do
			tool.last_format.filter (filter_name)
		end

feature -- Properties

	filter_dialog: EB_FILTER_DIALOG
			-- Associated popup dialog

	filter_name: STRING is
			-- Name of the filter to be applied
		local
			filter_dir: DIRECTORY
			file_name, dir_entry: STRING
			found: BOOLEAN
		once
			Result := general_filter_name
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

	execute is
			-- If left mouse button was pressed -> execute filter.
			-- If right mouse button was pressed -> bring up filter dialog. 
		local
--			mp: MOUSE_PTR
		do
				-- Popup filter dialog
--			create mp.set_watch_cursor
			create filter_dialog.make (Current)
--			mp.restore
			filter_dialog.call (Current)
		end

	display_filter is
			-- Display the filter output in `text_area'
		local
			ed: EB_EDIT_TOOL
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			ed ?= tool
			if ed /= Void and then ed.text_area.changed then
				create csd.make_and_launch (ed, Current)
			else
				process
			end
		end

	execute_filter_callback is
		local
			cmd_string: STRING
			filterable_format: EB_FILTERABLE
			shell_request: EXTERNAL_COMMAND_EXECUTOR
			filename, new_text: STRING
--			mp: MOUSE_PTR
			wd: EV_WARNING_DIALOG
		do
			if tool.stone /= Void then
					-- Execute the shell command
				filterable_format ?= tool.last_format
				if filterable_format = Void then
					create wd.make_with_text (Warning_messages.w_Not_a_filterable_format)
					wd.show_modal
				else
--					create mp.set_watch_cursor
					if 
						filterable_format.filtered and
						equal (filterable_format.filter_name, filter_name) 
					then
							-- The filtered text is in `text_area'
						filename := filterable_format.temp_filtered_file_name
										(tool.stone, filter_name)
						save_to_file (tool.text_area.text, filename)
						tool.text_area.set_changed (false)
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
					cmd_string := clone (general_filter_command)
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
					create wd.make_with_text (Warning_messages.w_Not_a_plain_file (new_file.name))
					wd.show_modal
				elseif new_file.exists and then not new_file.is_writable then
					create wd.make_with_text (Warning_messages.w_Not_writable (new_file.name))
					wd.show_modal
				elseif not new_file.exists and then not new_file.is_creatable then
					create wd.make_with_text (Warning_messages.w_Not_creatable (new_file.name))
					wd.show_modal
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

	tool: EB_MULTIFORMAT_TOOL

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
