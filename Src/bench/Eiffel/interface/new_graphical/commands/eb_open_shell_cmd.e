indexing
	description	: "Command to open a shell with an editor."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_OPEN_SHELL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item
		end

	SHARED_EIFFEL_PROJECT

	SYSTEM_CONSTANTS

	EB_GENERAL_DATA

	EB_CONSTANTS

	EXECUTION_ENVIRONMENT

creation
	make

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
--			Result.drop_actions.extend (~drop (?))
--			Result.drop_actions.set_veto_pebble_function (~is_storable)
			Result.drop_actions.extend (~process_class (?))
			Result.drop_actions.extend (~process_feature (?))
		end

feature {NONE} -- Update

	drop (s: STONE) is
		local
			cs: CLASSI_STONE
			fs: FEATURE_STONE
			cl_syntax_s: CL_SYNTAX_STONE
		do
			fs ?= s
			if fs /= Void then
				process_feature (fs)
			else
				cs ?= s
				if cs /= Void then
					process_class (cs)
				else
					cl_syntax_s ?= s
					if cl_syntax_s /= Void then
						process_class_syntax (cl_syntax_s)
					end
				end
			end
		end

feature {NONE} -- Implementation

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
		do
				-- feature text area
			cmd_string := clone (command_shell_name)
			if not cmd_string.is_empty then
				replace_target (cmd_string, fs.file_name)
				cmd_string.replace_substring_all ("$line", fs.line_number.out)
				create req
				req.execute (cmd_string)
			end
		end

	process_class (cs: CLASSI_STONE) is
			-- Process class stone.
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
			conv_f: FEATURE_STONE
		do
			conv_f ?= cs
			if conv_f = Void then
				cmd_string := clone (command_shell_name)
				if not cmd_string.is_empty then
					replace_target(cmd_string, cs.file_name)
					cmd_string.replace_substring_all ("$line", "1")
					create req
					req.execute (cmd_string)
				end
			end
		end

	process_class_syntax (syn: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
			-- (from HOLE)
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
		do
			cmd_string := clone (command_shell_name)
			if not cmd_string.is_empty then
				replace_target(cmd_string, syn.file_name)
				cmd_string.replace_substring_all ("$line", "1")
				create req
				req.execute (cmd_string)
			end
		end

	replace_target (cmd: STRING; fn:STRING) is
			-- Find out if `fn' is a relativ path or not and if it is
			-- one, complete it to make it absolute, so that the shell
			-- editor will be able to load the file
		local
			target_string: STRING
		do
			if fn = Void then
				target_string := ""
			else
				target_string := clone (fn)
			end
			cmd.replace_substring_all ("$target", target_string)
		end

	execute is
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
			line_nb: INTEGER
			development_window: EB_DEVELOPMENT_WINDOW
		do
			development_window := target
			cmd_string := clone (command_shell_name)
			line_nb := development_window.editor_tool.text_area.first_line_displayed
			if not cmd_string.is_empty then
				replace_target (cmd_string, window_file_name)
				cmd_string.replace_substring_all ("$line", line_nb.out)
				create req
				req.execute (cmd_string)
			end
		end

	window_file_name: STRING is
			-- Provides the filename of the current edited element, if possible.
		local
			fs: FILED_STONE
		do
			fs ?= target.stone
			if fs /= Void then
				Result := fs.file_name
			end
		end

feature {NONE} -- Implementation properties

	command_shell_name: STRING is
			-- Name of the command to execute in the shell dialog.
		do
			Result := general_shell_command
		end

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_External_editor
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_shell
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_Shell
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.e_Shell
		end

	name: STRING is "Open_shell"
			-- Name of the command. Used to store the command in the
			-- preferences.

	is_storable (st: ANY): BOOLEAN is
			-- Can `st' be dropped?
		local
			conv_st: STONE
		do
			conv_st ?= st
			Result := conv_st /= Void and then conv_st.is_storable
		end

end -- class EB_OPEN_SHELL_CMD
