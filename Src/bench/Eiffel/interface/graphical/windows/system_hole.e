indexing

	description:
		"Command to display the ace file.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_HOLE

inherit
	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	DEFAULT_HOLE_COMMAND
		redefine
			work, symbol, full_symbol, name, stone_type
		end
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
		local
			chooser: NAME_CHOOSER_W
		do
			chooser := name_chooser (popup_parent);
			chooser.call (Current);
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the system tool.
		once
			Result := bm_System
		end;

	full_symbol: PIXMAP is
			-- Icon for the system tool
		once
			Result := bm_System_dot
		end;

	name: STRING is
		do
			Result := l_System
		end;

    stone_type: INTEGER is
        do
            Result := System_type
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
			if tool = System_tool then
				tool.synchronize
			elseif Project_tool.initialized then
				if Eiffel_ace.file_name = void then
					if argument /= Void and then argument = last_name_chooser then
						fn := clone (last_name_chooser.selected_file);
						if not fn.empty then
							!! f.make (fn);
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_ace.set_file_name (fn);
								work (Current);
							elseif f.exists and then not f.is_plain then
								warner (project_tool.popup_parent).custom_call 
									(Current, w_Not_a_file_retry (fn), 
									l_Ok, Void, l_Cancel)
							else
								warner (project_tool.popup_parent).custom_call 
									(Current, w_Cannot_read_file_retry (fn), 
									l_Ok, Void, l_Cancel)
							end
						else
							warner (project_tool.popup_parent).custom_call 
								(Current, w_Not_a_file_retry (fn), 
								l_Ok, Void, l_Cancel)
						end
					else
						warner (project_tool.popup_parent).custom_call 
							(Current, l_Specify_ace, l_Browse, 
							l_Build, l_Cancel);
					end;	
				else
					!! system_stone;
					system_tool.display;
					system_tool.process_system (system_stone);
				end;
			end
		end;
	
feature {NONE} -- Implementation

	load_default_ace is
		local
			create_ace: CREATE_ACE;
			wizard: WIZARD
		do
			!! wiz_dlg.make ("Builder", Project_tool);
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
			Eiffel_ace.set_file_name (file_name);
			wiz_dlg.popdown;
			system_tool.display;
			system_tool.show_file_content (file_name);
		end;

feature {NONE} -- Properties

	wiz_dlg: WIZARD_DIALOG;
			-- Dialog for the wizard.

end -- class SYSTEM_HOLE
