indexing

	description:	
		"Command to open a shell with vi as editor.";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_COMMAND 

inherit

	ICONED_COMMAND;
	SHARED_BENCH_RESOURCES

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command, create a callback for a click action
			-- on button three, and create the shell window.
		do
			!!shell_window.make (c, Current);
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
			routine_text: ROUTINE_TEXT;
			class_text: CLASS_TEXT;
			feature_stone: FEATURE_STONE;
			position, line_nb, i, text_count: INTEGER
		do
			if argument = Void then
					-- 3rd button pressed
				shell_window.call 
			elseif text_window.root_stone /= Void then
				fs ?= text_window.root_stone;
				routine_text ?= text_window;
				class_text ?= text_window;
				cmd_string := clone (command_shell_name);
				if routine_text /= Void then
					-- routine text window
					feature_stone ?= fs; -- Cannot fail
					if not cmd_string.empty then
						cmd_string.replace_substring_all ("$line", feature_stone.line_number.out)
					end
				elseif
					class_text /= Void and then (
					class_text.last_format_2 = class_text.tool.showtext_frmt_holder or
					class_text.last_format_2 = class_text.tool.showclick_frmt_holder)
				then
					from
						text_value := class_text.text;
						position := class_text.cursor_position;
						text_count := text_value.count;
						line_nb := 1;
						i := 1
					until
						i >= position or i > text_count
					loop
						if text_value.item (i) = '%N' then
							line_nb := line_nb + 1
						end;
						i := i + 1
					end;
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
			elseif text_window.file_name /= Void then
				cmd_string := clone (command_shell_name);
				if not cmd_string.empty then
					cmd_string.replace_substring_all ("$line", "1");
					cmd_string.replace_substring_all ("$target", text_window.file_name);
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
