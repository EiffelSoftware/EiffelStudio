
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
	WINDOWS
		select
			init_toolkit
		end
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

	command_with_class_name (cn: STRING): USER_CMD is
			-- Find user command with class name `cn'
		require
			valid_cn_name: cn /= Void
		local
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]]
			cmd_list: LINKED_LIST [USER_CMD];
			class_name: STRING
		do
			class_name := clone (cn);
			class_name.to_upper;
			user_cmds := user_commands;
			from
				user_cmds.start
			until
				user_cmds.after or else Result /= Void
			loop
				cmd_list := user_cmds.item;
				from
					cmd_list.start
				until
					cmd_list.after or else Result /= Void
				loop
					if class_name.is_equal (cmd_list.item.eiffel_type_to_upper) then
						Result := cmd_list.item
					end
					cmd_list.forth
				end
				user_cmds.forth
			end
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

	shell: EB_TOP_SHELL;

feature 

	hide is 
		do 
			shell.hide 
		end;

	show is 
		do 
			shell.show 
		end;

	shown: BOOLEAN is 
		do 
			Result := shell.shown 
		end;
	
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
			shell.set_x_y (Resources.cmd_cat_x,
					Resources.cmd_cat_y);
			shell.set_size (Resources.cmd_cat_width,
					Resources.cmd_cat_height);
			shell.initialize_window_attributes
		end;

	create_interface is 
			-- Create command_catalog interface.
		local
			type_button: CMD_CAT_ED_H;
			inst_button: CMD_I_ED_HOLE;
			create_inst_b: CMD_CAT_CREATE_INST_H;
			close_b: CLOSE_WINDOW_BUTTON;
			trash_hole: CUT_HOLE;
			top_form: FORM
		do
			!!top_form.make (Widget_names.form1, Current);
			!!button_rc.make (Widget_names.row_column, Current);
			button_rc.set_preferred_count (1);
			button_rc.set_row_layout;
--samik			!!focus_label.initialize (top_form);
			!!trash_hole.make (top_form);
			!!type_button.make (top_form); 
			!!inst_button.make (top_form);
			!!create_inst_b.make (top_form);
			!!close_b.make (Current, top_form);
			!!page_sw.make (Widget_names.scroll, Current);
			top_form.attach_left (type_button, 0);
			top_form.attach_left_widget (type_button, inst_button, 0);
			top_form.attach_left_widget (inst_button, create_inst_b, 0);
			top_form.attach_left_widget (create_inst_b, trash_hole, 0);
--samik			top_form.attach_left_widget (trash_hole, focus_label, 0);
--samik			top_form.attach_right_widget (close_b, focus_label, 0);
			top_form.attach_right (close_b, 0);
			top_form.attach_top (type_button, 0);
			top_form.attach_top (inst_button, 0);
			top_form.attach_top (trash_hole, 0);
			top_form.attach_top (create_inst_b, 0);
			top_form.attach_top (close_b, 0);
--samik			top_form.attach_top (focus_label, 0);
--samik			top_form.attach_bottom (focus_label, 0);
			top_form.attach_bottom (create_inst_b, 0);
			top_form.attach_bottom (type_button, 0);
			top_form.attach_bottom (inst_button, 0);
			top_form.attach_bottom (close_b, 0);
			top_form.attach_bottom (trash_hole, 0);
			attach_left (top_form, 0);
			attach_right (top_form, 0);
			attach_top_widget (top_form, page_sw, 2);
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
