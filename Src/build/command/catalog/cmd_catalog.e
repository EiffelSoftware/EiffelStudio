
class CMD_CATALOG 

inherit

	CATALOG [CMD]
		rename
			make as catalog_make
		export
			{ANY} all
		undefine
			init_toolkit
		redefine
			realize, add_first_button, add_other_buttons,
			hide, show, shown, current_page
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end

creation

	make
	
feature 

	clear is
			-- Clear commands from all pages;
		do
			from 
				pages.start
			until
				pages.after
			loop
				pages.item.wipe_out;
				pages.forth
			end;
		end;

	user_commands: LINKED_LIST [LINKED_LIST [USER_CMD]] is
		local
			nl: LINKED_LIST [USER_CMD];
			p: like current_page;
			uc: USER_CMD
		do
			from
				pages.start;
				!!Result.make;
			until
				pages.after
			loop
				!!nl.make;
				Result.extend (nl);
				from
					p := pages.item;
					p.start
				until
					p.after
				loop
					uc ?= p.item;
					if not (uc = Void) then
						if uc.edited then
							uc.save_text
						end;
						nl.extend (uc);
					end;
					p.forth
				end;	
				pages.forth
			end;
		end;

	merge (l: LINKED_LIST [LINKED_LIST [USER_CMD]]) is
		local
			cl: LINKED_LIST [USER_CMD];
			p: like current_page
		do
			from
				l.start;
				pages.start
			until
				l.after
			loop
				cl := l.item;
				from
					cl.start
				until
					cl.after
				loop
					p := pages.item;
					p.extend (cl.item);
					cl.forth
				end;
				l.forth;
				pages.forth
			end;	
		end;

	initial_pages is
		do
			from
				pages.start
			until
				pages.after
			loop
				if pages.item.empty then
					pages.item.initial_cmd;
				end;
				pages.forth
			end;	
		end;

	current_page: COMMAND_PAGE;

	
feature {NONE}

	page_used: COMMAND_PAGE is
		do
			Result := current_page
		end;

	
feature 

	add (c: USER_CMD) is
		local
			add_command: CAT_ADD_COMMAND
		do
			add_to_page (c, current_page);
		end;

	add_to_page (c: USER_CMD; p: like current_page) is
		local
			add_command: CAT_ADD_COMMAND
		do
			p.extend (c);
			!!add_command;
			add_command.execute (p);
		end;

-- ********************
-- EiffelVision Section 
-- ********************

	
feature {NONE}

	shell: TOP_SHELL;

	
feature 

	hide is do shell.hide end;
	show is do shell.show end;
	shown: BOOLEAN is do Result := shell.shown end;

	
feature {NONE}

	user_defined_commands1: COMMAND_PAGE;
	user_defined_commands2: COMMAND_PAGE;
	user_defined_commands3: COMMAND_PAGE;

	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
		local
			continue_command: ITER_COMMAND;
		do
			!!shell.make (a_name, a_screen);
			!!continue_command;
			shell.set_delete_command (continue_command);
			catalog_make ("Command Catalog", shell);
		end;

	create_interface is 
			-- Create command_catalog interface.
		local
			type_button: CMD_CAT_ED_H;
			create_inst_b: CMD_CAT_CREATE_INST_H;
			--inst_button: CMD_INST_CAT_ED_H;
			separator, separator1: SEPARATOR;
		do
			!!button_form.make (F_orm1, Current);
			!!separator.make (S_eparator, Current);
			!!separator1.make (S_eparator1, Current);
			!!type_label.make (L_abel, Current);
			!!focus_label.make (L_abel1, Current);
			!!page_sw.make (S_croll, Current);
			!!page_form.make (F_orm2, page_sw);
			!!type_button.make ("Create/edit type"); 	
			!!create_inst_b.make ("Create instance");
			--!!inst_button.make ("Edit instance");
			type_button.make_visible (button_form);
			create_inst_b.make_visible (button_form);
			--inst_button.make_visible (button_form);
			button_form.attach_left (type_button, 5);
			button_form.attach_left_widget (type_button, create_inst_b, 0);
			--button_form.attach_right_widget (create_inst_b, inst_button, 0);
			button_form.detach_right (create_inst_b);
			attach_left (button_form, 10);
			attach_right (button_form, 10);
			attach_top (button_form, 10);
			attach_left (separator, 10);
			attach_right (separator, 10);
			attach_top_widget (button_form, separator, 10);
			attach_left (type_label, 10);
			attach_right (focus_label, 10);
			attach_top_widget (separator, focus_label, 10);
			attach_top_widget (separator, type_label, 10);
			attach_left (separator1, 10);
			attach_right (separator1, 10);
			attach_top_widget (focus_label, separator1, 10);
			attach_top_widget (type_label, separator1, 10);
			attach_left (page_sw, 10);
			attach_right (page_sw, 10);
			attach_top_widget (separator1, page_sw, 10);
			attach_bottom (page_sw, 10);
			focus_label.set_text ("");
			!!pages.make;
			define_command_pages;
			update_interface;
		end;

	add_first_button (b: ICON; i: INTEGER) is 
		do
			button_form.attach_right (b, i);
		end;

	add_other_buttons (pb, b: ICON; i: INTEGER) is
		do
			button_form.attach_right_widget (pb, b, i);
		end;


	
feature {NONE}

	define_command_pages is
			-- Define pages for the catalog.
		local
			file_commands: FILE_CMDS;
			window_commands: WINDOW_CMDS;
			command_templates: TEMPL_CMDS
		do
			!!user_defined_commands1.make ("User1", User_defined_pixmap, Current);
			!!user_defined_commands2.make ("User2", User_defined_pixmap, Current);
			!!user_defined_commands3.make ("User3", User_defined_pixmap, Current);
			!!command_templates.make ("Templates", Command_o_pixmap, Current);
			!!window_commands.make ("Window", Windows_pixmap, Current);
			!!file_commands.make ("File", File_pixmap, Current);
			add_page (command_templates);
			add_page (window_commands);
			add_page (file_commands);
			add_page (user_defined_commands3);
			add_page (user_defined_commands2);
			add_page (user_defined_commands1);
			set_initial_page (user_defined_commands1);
		end; --create_command_pages

	
feature 

	realize is
		do
			shell.realize;
		end;
	
feature 

	update_name_in_editors (cmd: USER_CMD) is
			-- Update the command edit stones of `cmd' is
			-- currently being edited (in either the type or
			-- instance editors)
		local
			cmd_eds: LINKED_LIST [CMD_EDITOR]
		do
			update_icon_stone (cmd);
			cmd_eds := window_mgr.cmd_editors;
			from
				cmd_eds.start
			until
				cmd_eds.after or else 
				cmd_eds.item.current_command.equivalent (cmd)
				--! There is only one type editor per command
			loop
				cmd_eds.forth
			end;		
			if not cmd_eds.after then
				cmd_eds.item.update_name
			end		
		end;

feature {NONE}

	update_icon_stone (c: CMD) is
		local		
			p: like current_page;
			finished: BOOLEAN
		do
			from 
				pages.start
			until
				pages.after or finished
			loop
				p := pages.item;
				p.start;
				p.search (c);
				if not p.after then		
					p.redisplay_current;
					finished := True
				else
					pages.forth
				end
			end
		end;

end -- class CMD_CATALOG
