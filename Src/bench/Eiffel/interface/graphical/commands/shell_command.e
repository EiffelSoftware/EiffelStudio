indexing

	description:	
		"Command to open a shell with vi as editor.";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_COMMAND 

inherit

	PIXMAP_COMMAND;
	SHARED_BENCH_RESOURCES

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize the command, create a callback for a click action
			-- on button three, and create the shell window.
		do
			init (a_text_window);
		end;

feature -- Properties

	shell_window: SHELL_W;
			-- The shell window.

	command_shell_name: STRING is
			-- Name of the command to execute in the shell window.
		once
				-- use default command (vi editor)
			Result := resources.get_string (r_Shell_command, "xterm -geometry 80x40 -e vi +$line $target")
		end;

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Shell 
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- If left mouse button was pressed -> execute command.
			-- If right mouse button was pressed -> bring up shell window. 
		local
			req: EXTERNAL_COMMAND_EXECUTOR;
			cmd_string, text_value: STRING;
			fs: FILED_STONE;
			routine_tool: ROUTINE_W;
			class_tool: CLASS_W;
			feature_stone: FEATURE_STONE;
			position, line_nb, i, text_count: INTEGER
		do
			if argument = button_three_action then
					-- 3rd button pressed
				if shell_window = Void then
					!!shell_window.make (popup_parent, Current);
				end;
				shell_window.call 
			elseif tool.stone /= Void then
				fs ?= tool.stone;
				routine_tool ?= text_window.tool;
				class_tool ?= text_window.tool;
				cmd_string := clone (command_shell_name);
				if routine_tool /= Void then
					-- routine text window
					feature_stone ?= fs; -- Cannot fail
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$line", feature_stone.line_number.out)
					end
				elseif class_tool /= Void and then (
					tool.last_format = class_tool.showtext_frmt_holder or
					tool.last_format = class_tool.showclick_frmt_holder)
				then
					line_nb := text_window.current_line;
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$line", line_nb.out)
					end
				else
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$line", "1")
					end
				end;
				if not cmd_string.empty then
					cmd_string.replace_substring_all ("$target", fs.file_name);
				end
				!! req;
				req.execute (cmd_string);
			elseif tool.file_name /= Void then
				cmd_string := clone (command_shell_name);
				if not cmd_string.empty then
					cmd_string.replace_substring_all ("$line", "1");
					cmd_string.replace_substring_all ("$target", tool.file_name);
				end
				!! req;
				req.execute (cmd_string);
			end;
		end;
 
	
feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := l_Shell
		end;

end -- SHELL_COMMAND
