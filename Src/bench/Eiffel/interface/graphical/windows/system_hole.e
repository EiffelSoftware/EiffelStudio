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
			system_stone: SYSTEM_STONE
		do
			if project_tool.initialized then
				!!system_stone.make (System);
				system_tool.receive (system_stone);
				system_tool.show
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
				warner.call (Current, l_Initialize)
			end
		end;

	
feature 

	stone_type: INTEGER is do Result := System_type end;

	
feature {NONE}

	command_name: STRING is do Result := l_System end

end
