class SHELL_COMMAND 

inherit

	ICONED_COMMAND;
	SHARED_RESOURCES

creation

	make
	
feature 

	shell_window: SHELL_W;

	command_shell_name: STRING is
		local
			edit_command: STRING
		once
			edit_command := Execution_environment.get ("EIF_COMMAND");
			!!Result.make (0);
			if (edit_command = Void) or else (edit_command.empty) then
					-- EIF_COMMAND was not set then use 
					-- use default command (vi editor)
				Result := resources.get_string (r_Shell_command, "xterm -geometry 80x40 -e vi +$line $target")
			else
				Result.append (edit_command);
			end;
		end;

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			!!shell_window.make (c, Current);
			init (c, a_text_window);
			add_button_click_action (3, Current, Void);
		end;

feature {NONE}

	work (argument: ANY) is
			-- If left mouse button was pressed -> execute command.
			-- If right mouse button was pressed -> bring up shell window. 
		local
			req: ASYNC_SHELL;
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
				!!cmd_string.make (0);
				cmd_string.append ("line=");
				if routine_text /= Void then
					-- routine text window
					feature_stone ?= fs; -- Cannot fail
					cmd_string.append_integer (feature_stone.line_number);
				elseif
					class_text /= Void and then (
					class_text.last_format = class_text.tool.showtext_command or
					class_text.last_format = class_text.tool.showclick_command)
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
					cmd_string.append_integer (line_nb)
				else
					cmd_string.append_integer (1);	
				end;
				cmd_string.append (";");
				!!req;
				cmd_string.append ("target=");
				cmd_string.append (fs.file_name);
				cmd_string.append ("; export target line;");
				cmd_string.append (command_shell_name);
				req.set_command_name (cmd_string);
				req.send;		-- execute the command
			end;
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Shell 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Shell end;

end
