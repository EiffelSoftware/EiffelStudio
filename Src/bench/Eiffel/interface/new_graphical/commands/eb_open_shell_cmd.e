indexing
	description: "Command to open a shell with an editor."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_SHELL_CMD

inherit
	SHARED_EIFFEL_PROJECT
--	HOLE_COMMAND
--		redefine 
--			compatible, process_feature, process_class,
--			process_class_syntax
--		end
	EB_TOOL_COMMAND

	SYSTEM_CONSTANTS

	EB_GENERAL_DATA
	NEW_EB_CONSTANTS

creation
	make

feature -- Properties

--	command_line_d: EB_COMMAND_LINE_DIALOG
			-- The command line dialog.

	command_shell_name: STRING is
			-- Name of the command to execute in the shell window.
		do
			Result := general_shell_command
		end

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Shell 
--		end

feature -- Access

--	stone_type: INTEGER is do end
 
--	compatible (dropped: STONE): BOOLEAN is
--			-- Can `Current' accept `dropped' ?
--		do
--			Result := dropped.stone_type = Class_type or else
--					dropped.stone_type = feature_type
--		end

feature -- Update

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			req: EXTERNAL_COMMAND_EXECUTOR
			cmd_string: STRING
		do
				-- feature text window
			cmd_string := clone (command_shell_name)
			if not cmd_string.empty then
				replace_target (cmd_string, fs.file_name)
				cmd_string.replace_substring_all ("$line", fs.line_number.out)
				create req
				req.execute (cmd_string)
			end
		end

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			req: EXTERNAL_COMMAND_EXECUTOR
			cmd_string: STRING
		do
			cmd_string := clone (command_shell_name)
			if not cmd_string.empty then
				replace_target(cmd_string, cs.file_name)
				cmd_string.replace_substring_all ("$line", "1")
				create req
				req.execute (cmd_string)
			end
		end

	process_class_syntax (syn: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
			-- (from HOLE)
		local
			req: EXTERNAL_COMMAND_EXECUTOR
			cmd_string: STRING
		do
			cmd_string := clone (command_shell_name)
			if not cmd_string.empty then
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
			cwd:STRING
			file:PLAIN_TEXT_FILE
			code:INTEGER
		do
			if fn = Void then
				target_string := ""
			else
				cwd := current_working_directory
					--| Move to the "EIFGEN" directory and try to open
					--| the file `fn', if it does not succeed, it means
					--| that it was a relativ pathname and we need to make
					--| it absolute
				change_working_directory (Eiffelgen)
				create file.make(fn)
				if file.exists then 
					change_working_directory (cwd)
					target_string := fn
				else
					change_working_directory (cwd)
					target_string := clone (fn)
					target_string.prepend_character (Directory_separator)
					target_string.prepend (current_working_directory)
				end
			end
			cmd.replace_substring_all ("$target", target_string)
		end


feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If left mouse button was pressed -> execute command.
			-- If right mouse button was pressed -> bring up shell window. 
		local
			req: EXTERNAL_COMMAND_EXECUTOR
			cmd_string: STRING
			feature_tool: EB_FEATURE_TOOL
			class_tool: EB_CLASS_TOOL
			feature_stone: FEATURE_STONE
			fs: FILED_STONE
			line_nb: INTEGER
		do
			feature_tool ?= tool
			cmd_string := clone (command_shell_name)
			if feature_tool /= Void then
				feature_stone ?= feature_tool.stone 
				if feature_stone /= Void then
					process_feature (feature_stone)
				end
			else --if tool.file_name /= Void and then tool.stone /= Void then
				class_tool ?= tool
				if class_tool /= Void and then
					(class_tool.last_format = class_tool.format_list.text_format)
				then
					line_nb := class_tool.text_window.current_line
				end
				if not cmd_string.empty then
					replace_target (cmd_string, tool_file_name)
					cmd_string.replace_substring_all ("$line", line_nb.out)
					create req
					req.execute (cmd_string)
				end
			end
		end

	tool_file_name: STRING is
			-- Provides `tool''s file name, if possible.
			-- (tool.fs.file_name seems to be different from tool.file_name)
		local
			ed: EB_EDITOR
			fs: FILED_STONE
		do
			ed ?= tool
			if ed /= Void then
				fs ?= ed.stone
				if fs /= void then
					Result := fs.file_name
				end
			end
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Shell
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Shell
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Externals

	change_working_directory (path: STRING) is
			-- Set the current directory to `path'
		local
			return_code:INTEGER
		do
			return_code := eif_chdir (path.to_c)
		end

	current_working_directory: STRING is
			-- Directory of current execution
		external
			"C | %"eif_dir.h%""
		alias
			"dir_current"
		end

	eif_chdir (s: ANY): INTEGER is
			-- Set the current directory to `path'
		external
			"C | %"eif_dir.h%""
		end

end -- class EB_OPEN_SHELL_CMD
