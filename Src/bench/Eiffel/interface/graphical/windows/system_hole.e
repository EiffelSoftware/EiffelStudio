indexing

	description:	
		"Hole for system tool.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_HOLE 

inherit

	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	EB_BUTTON_HOLE
		redefine
			work, symbol, stone_type, name,
			full_symbol
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_help as load_default,
			execute_warner_ok as load_chosen
		end;
	CREATE_ACE_CALLER

creation

	make

feature -- Callbacks

	load_default is
			-- Load default ace file.
		do
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

	name: STRING is
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
							(Current, l_Specify_ace, "Browse", 
							"Build", "Cancel");
					end;	
				else
					!! system_stone;
					tool.display;
					tool.process_system (system_stone);
				end;
			end
		end;
	
feature {NONE} -- Implementation

	load_default_ace is
		local
			wiz_dlg: WIZARD_DIALOG;
			create_ace: CREATE_ACE;
			wizard: WIZARD
		do
			!! wiz_dlg.make ("dialog", Project_tool);
			!! create_ace.make (Current);
			!! wizard.make (Project_tool, wiz_dlg, create_ace);
			wizard.execute_action;
		end;

	perform_post_creation is
		local
			file_name: STRING
		do
			!! file_name.make (0);
			file_name.append ("Ace.ace");
			system_tool.display;
			system_tool.text_window.show_file_content (file_name);
			system_tool.text_window.set_changed (True)
		end;

end -- class SYSTEM_HOLE
