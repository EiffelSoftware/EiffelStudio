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
			!!Result.make;
			Result.read_from_file (bm_System)
		end;

	
feature {NONE}

	work (argument: ANY) is
			-- With button select: popup the ACE.
			-- With transport button, do nothing.
		local
			void_text: TEXT_WINDOW;
			project_dir: PROJECT_DIR;
			system_stone: SYSTEM_STONE;
			show_plain_text: BOOLEAN;
		do
			if project_tool.initialized then
				if show_plain_text then
					system_tool.text_window.show_file_content (lace.file_name);
				elseif lace.file_name = void then
					if argument = void then
						load_default_ace;
						system_tool.show;
					elseif argument = warner then
						name_chooser.call (Current);
					elseif argument = name_chooser then
						Lace.set_file_name (name_chooser.selected_file);
						work (Current);
					else
						warner.custom_call (Current, l_Specify_ace,
							"OK", "Template", "Cancel");
					end;	
				else
					!!system_stone.make (System);
					system_tool.receive (system_stone);
					system_tool.show;
				end;
			elseif argument = name_chooser then
				!!project_dir.make (name_chooser.selected_file);
				if project_dir.valid then
					project_tool.open_command.make_project (project_dir);
					work (Current)
				else
					warner.call (Current, l_Invalid_directory)
				end
			elseif argument = warner then
				name_chooser.call (Current)
			else
				warner.call (Current, l_Initialize);
			end
		rescue
			if project_tool.initialized and not show_plain_text then
				show_plain_text := true;
				retry
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
				file_name.append ("/bin/Ace.default");
				system_tool.text_window.show_file_content (file_name);
		end;

end
