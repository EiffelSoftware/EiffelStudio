-- Hole for system tool

class SYSTEM_HOLE 

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	HOLE
		redefine
			work, symbol, stone_type, command_name
		end

creation

	make

feature 

	symbol: PIXMAP is
			-- Icon for the system tool
		once
			Result := bm_System
		end;

	
feature {NONE}

	work (argument: ANY) is
			-- With button select: popup the ACE.
			-- With transport button, do nothing.
		local
			void_text: TEXT_WINDOW;
			system_stone: SYSTEM_STONE;
			fn: STRING;
			f: UNIX_FILE;
			temp: STRING
		do
			if project_tool.initialized then
				if lace.file_name = void then
					if argument = void then
						load_default_ace;
						system_tool.display;
					elseif argument = warner then
						name_chooser.call (Current);
					elseif argument = name_chooser then
						fn := name_chooser.selected_file.duplicate;
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
							warner.custom_call (Current, temp, " Ok ", Void, "Cancel");
						end;
					else
						warner.custom_call (Current, l_Specify_ace,
							" Ok ", "Template", "Cancel");
					end;	
				else
					!!system_stone.make (System);
					system_tool.receive (system_stone);
					system_tool.display;
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
				file_name.append (Eiffel3_dir_name);
				file_name.append ("/bench/help/defaults/Ace.default");
				system_tool.text_window.show_file_content (file_name);
		end;

end
