-- Hole for system tool

class SYSTEM_HOLE 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	HOLE
		redefine
			work, symbol, stone_type, command_name,
			full_symbol
		end

creation

	make

feature 

	symbol: PIXMAP is
			-- Icon for the system tool
		once
			Result := bm_System
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_System_dot
		end;

feature {NONE}

	work (argument: ANY) is
			-- With button select: popup the ACE.
			-- With transport button, do nothing.
		local
			void_text: TEXT_WINDOW;
			system_stone: SYSTEM_STONE;
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			temp: STRING
		do
			if tool = system_tool then
				tool.synchronize
			elseif project_tool.initialized then
				if lace.file_name = void then
					if argument = void then
						system_tool.display;
						load_default_ace;
					elseif argument = last_warner then
						name_chooser.set_window (project_tool.text_window);
						name_chooser.call (Current);
					elseif argument = name_chooser then
						fn := clone (name_chooser.selected_file);
						!! f.make (fn);
						if 
							f.exists and then f.is_readable and then f.is_plain
						then
							Lace.set_file_name (name_chooser.selected_file);
							work (Current);
						else
							!!temp.make (0);
							temp.append ("File: ");
							temp.append (fn);
							temp.append ("%Ncannot be read. Try again?");
							warner (project_tool.text_window).custom_call 
								(Current, temp, " OK ", Void, "Cancel");
						end;
					else
						warner (project_tool.text_window).custom_call 
							(Current, l_Specify_ace, " OK ", 
							"Template", "Cancel");
					end;	
				else
					!!system_stone.make (System);
					system_tool.display;
					system_tool.receive (system_stone);
				end;
			end
		end;

	
feature 

	stone_type: INTEGER is do Result := System_type end;

	
feature {NONE}

	command_name: STRING is do Result := l_System end;

	load_default_ace is
		local
			file_name: STRING;
		do
				!!file_name.make (50);	
				file_name.append (Default_ace_name);
				system_tool.text_window.show_file_content (file_name);
				system_tool.text_window.set_changed (True)
		end;

end
