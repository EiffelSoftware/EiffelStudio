indexing

	description:	
		"Hole for system tool.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_HOLE 

inherit

	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	HOLE
		redefine
			work, symbol, stone_type, command_name,
			full_symbol
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_help as load_default,
			execute_warner_ok as load_chosen
		end

creation

	make

feature -- Callbacks

	load_default is
			-- Load default ace file.
		do
			system_tool.display;
			load_default_ace;
		end;

	load_chosen (argument: ANY) is
		do
			name_chooser.set_window (project_tool.text_window);
			name_chooser.call (Current);
		end;

feature -- Properties

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

	stone_type: INTEGER is
		do
			Result := System_type
		end;

	command_name: STRING is
		do
			Result := l_System
		end;

feature {NONE} -- Execution

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
				if Eiffel_project.lace_file_name = void then
					if argument = name_chooser then
						fn := clone (name_chooser.selected_file);
						if not fn.empty then
							!! f.make (fn);
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_project.set_lace_file_name (fn);
								work (Current);
							elseif f.exists and then not f.is_plain then
								warner (project_tool.text_window).custom_call 
									(Current, w_Not_a_file_retry (fn), 
									" OK ", Void, "Cancel")
							else
								warner (project_tool.text_window).custom_call 
									(Current, w_Cannot_read_file_retry (fn), 
									" OK ", Void, "Cancel")
							end
						else
							warner (project_tool.text_window).custom_call 
								(Current, w_Not_a_file_retry (fn), 
								" OK ", Void, "Cancel")
						end
					else
						warner (project_tool.text_window).custom_call 
							(Current, l_Specify_ace, " OK ", 
							"Template", "Cancel");
					end;	
				else
					!!system_stone.make;
					system_tool.display;
					system_tool.receive (system_stone);
				end;
			end
		end;
	
feature {NONE} -- Implementation

	load_default_ace is
		local
			file_name: STRING;
		do
				!!file_name.make (50);	
				file_name.append (Default_ace_name);
				system_tool.text_window.show_file_content (file_name);
				system_tool.text_window.set_changed (True)
		end;

end -- class SYSTEM_HOLE
