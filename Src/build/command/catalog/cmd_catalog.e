
class CMD_CATALOG 

inherit

	CATALOG [CMD]
		rename
			make as catalog_make
		export
			{ANY} all
		redefine
			realize, hide, show, 
			shown, current_page
		end;
	WINDOWS;
	CLOSEABLE

creation

	make
	
feature 

	close is
		do
			hide;
			main_panel.cmd_cat_t.set_toggle_off	
		end;

	clear is
			-- Clear commands from all pages;
		local
			uc: USER_CMD;
		do
			from 
				pages.start
			until
				pages.after
			loop
				pages.item.wipe_out;
				pages.forth
			end;
			!!uc.make;
			uc.reset_name;
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
				from cl.start
				until cl.after
				loop
					p := pages.item;
					p.extend (cl.item);
					cl.forth
				end;
				l.forth;
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

feature {NONE}

	shell: TOP_SHELL;

	
feature 

	hide is do shell.hide end;
	show is do shell.show end;
	shown: BOOLEAN is do Result := shell.shown end;

	
feature {NONE}

	user_defined_commands1: USER_DEF_CMDS;
	user_defined_commands2: USER_DEF_CMDS;
	user_defined_commands3: USER_DEF_CMDS;

feature 

	make (a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW;
		do
			!! shell.make (Widget_names.command_catalog, a_screen);
			!! del_com.make (Current);
			shell.set_delete_command (del_com);
			catalog_make (Widget_names.form, shell);
		end;

	create_interface is 
			-- Create command_catalog interface.
		local
			type_button: CMD_CAT_ED_H;
			create_inst_b: CMD_CAT_CREATE_INST_H;
			close_b: CLOSE_WINDOW_BUTTON
		do
			!!button_rc.make (Widget_names.row_column, Current);
			button_rc.set_preferred_count (1);
			button_rc.set_row_layout;
			!!focus_label.make (Current);
			!!page_sw.make (Widget_names.scroll, Current);
			!!type_button.make (Current); 
			!!create_inst_b.make (Current);
			!!close_b.make (Current, Current, focus_label);
			attach_left (type_button, 0);
			attach_left_widget (type_button, create_inst_b, 0);
			attach_left_widget (create_inst_b, focus_label, 0);
			attach_right_widget (close_b, focus_label, 0);
			attach_right (close_b, 0);
			attach_top (type_button, 0);
			attach_top (create_inst_b, 0);
			attach_top (close_b, 0);
			attach_top (focus_label, 5);
			attach_top_widget (focus_label, page_sw, 0);
			attach_top_widget (create_inst_b, page_sw, 2);
			attach_top_widget (type_button, page_sw, 2);
			attach_top_widget (close_b, page_sw, 2);
			attach_left (page_sw, 2);
			attach_right (page_sw, 2);
			attach_bottom_widget (button_rc, page_sw, 2);
			attach_bottom (button_rc, 2);
			attach_left (button_rc, 2);
			!!pages.make;
			define_command_pages;
			update_interface;
		end;

feature {NONE}

	define_command_pages is
			-- Define pages for the catalog.
		local
			file_commands: FILE_CMDS;
			window_commands: WINDOW_CMDS;
			command_templates: TEMPL_CMDS
		do
			!!user_defined_commands1.make (1);
			!!user_defined_commands2.make (2);
			!!user_defined_commands3.make (3);
			!!command_templates.make;
			!!window_commands.make;
			!!file_commands.make;
			add_page (user_defined_commands1);
			add_page (user_defined_commands2);
			add_page (user_defined_commands3);
			add_page (file_commands);
			add_page (window_commands);
			add_page (command_templates);
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
				cmd_eds.item.update_title
			end		
		end;

    initialize_pages is
        do
            from
                pages.start
            until
                pages.after
            loop
                if pages.item.empty then
                    pages.item.reset_commands;
                end;
                pages.forth
            end;
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
