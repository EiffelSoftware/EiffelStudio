indexing

	description:	
		"Command to open a shell with vi as editor.";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_COMMAND 

inherit

	SHARED_EIFFEL_PROJECT;
	HOLE_COMMAND
		redefine 
			compatible, process_feature, process_class,
			process_class_syntax
		end;

	SYSTEM_CONSTANTS

creation

	make

feature -- Properties

	shell_window: SHELL_W;
			-- The shell window.

	command_shell_name: STRING is
			-- Name of the command to execute in the shell window.
		do
			Result := General_resources.shell_command.value
		end;

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Shell 
		end;

feature -- Access

	stone_type: INTEGER is do end;
 
	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := dropped.stone_type = Class_type or else
					dropped.stone_type = Routine_type
		end;

feature -- Update

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			req: COMMAND_EXECUTOR;
			cmd_string: STRING
		do
				-- routine text window
			cmd_string := clone (command_shell_name);
			if not cmd_string.is_empty then

				replace_target(cmd_string, fs.file_name)
				cmd_string.replace_substring_all ("$line", fs.line_number.out)
				!! req;
				req.execute (cmd_string);
			end
		end;

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			req: COMMAND_EXECUTOR;
			cmd_string: STRING
		do
			cmd_string := clone (command_shell_name);
			if not cmd_string.is_empty then
				replace_target(cmd_string, cs.file_name)
				cmd_string.replace_substring_all ("$line", "1")
				!! req;
				req.execute (cmd_string);
			end
		end

	process_class_syntax (syn: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
			-- (from HOLE)
		local
			req: COMMAND_EXECUTOR;
			cmd_string: STRING
		do
			cmd_string := clone (command_shell_name)
			if not cmd_string.is_empty then
				replace_target(cmd_string, syn.file_name)
				cmd_string.replace_substring_all ("$line", "1")
				!! req;
				req.execute (cmd_string);
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
		do
			cwd := current_working_directory
				--| Move to the "EIFGEN" directory and try to open
				--| the file `fn', if it does not succeed, it means
				--| that it was a relativ pathname and we need to make
				--| it absolute
			change_working_directory (Eiffelgen)
			!! file.make(fn)
			if file.exists then 
				change_working_directory (cwd)
				target_string := fn
			else
				change_working_directory (cwd)
				target_string := clone (fn)
				target_string.prepend_character (Operating_environment.Directory_separator)
				target_string.prepend (current_working_directory)
			end
			cmd.replace_substring_all ("$target", target_string);
		end


feature {NONE} -- Implementation

	work (argument: ANY) is
			-- If left mouse button was pressed -> execute command.
			-- If right mouse button was pressed -> bring up shell window. 
		local
			req: COMMAND_EXECUTOR;
			cmd_string: STRING;
			routine_tool: ROUTINE_W;
			class_tool: CLASS_W;
			feature_stone: FEATURE_STONE;
			fs: FILED_STONE;
			line_nb: INTEGER
		do
			if argument = button_three_action then
					-- 3rd button pressed
				if shell_window = Void then
					!!shell_window.make (popup_parent, Current);
				end;
				shell_window.call 
			else
				routine_tool ?= tool;
				cmd_string := clone (command_shell_name);
				if routine_tool /= Void then
					feature_stone ?= tool.stone; 
					if feature_stone /= Void then
						process_feature (feature_stone)
					end
				elseif tool.file_name /= Void and then tool.stone /= Void then
					class_tool ?= tool;
					if class_tool /= Void and then (
						tool.last_format = class_tool.showtext_frmt_holder or
						tool.last_format = class_tool.showclick_frmt_holder)
					then
						line_nb := text_window.current_line;
					end;
					if not cmd_string.is_empty then
						fs ?= tool.stone;
						replace_target(cmd_string, fs.file_name)
						cmd_string.replace_substring_all ("$line", line_nb.out)
						!! req;
						req.execute (cmd_string);
					end
				end;
			end;
		end;
 
feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Shell
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Shell
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

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
		end;

end -- SHELL_COMMAND
