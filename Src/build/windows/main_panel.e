class MAIN_PANEL 

inherit

	WINDOWS
	COMMAND_ARGS;
	CONSTANTS;
	CLOSEABLE
	QUEST_POPUPER;
	SHARED_CONTEXT;
	LICENCE_COMMAND

creation

	make
	
feature 

	base: TRANSPORTER

	project_initialized: BOOLEAN
			-- Is ebuild editing a project?

	set_title (s: STRING) is 
			-- Set the title of the main panel.
		do 
			base.set_title (s);
			base.set_icon_name (s);
		end

	set_project_initialized is 
			-- Set project_initialized to True.
		do 		
			project_initialized := True 
		end

	unset_project_initialized is 
			-- Set project_initialized to False.
		do 		
			project_initialized := False ;
			set_title (Widget_names.main_panel)
		end;

	set_saved_symbol is
		do
			save_b.set_saved_symbol
		end;

	set_unsaved_symbol is
		do
			save_b.set_unsaved_symbol
		end;

	set_interface_toggle is
		do
			interface_t.set_toggle_on;
		end;
	
feature {NONE}

	row_column1, row_column2: ROW_COLUMN;
	form, top_form, commands_form, visibility_form: FORM
	
feature 

	quit_b: CLOSE_WINDOW_BUTTON
	create_proj_b: CREATE_PROJ_BUTTON
	cut_b: CUT_HOLE
	namer_b: NAMER_HOLE
	help_b: HELP_HOLE
	con_b: CON_ED_HOLE
	cmd_b: CMD_ED_HOLE
	cmdi_b: CMD_I_ED_HOLE
	state_b: STATE_ED_HOLE
	generate_b: GENERATE_BUTTON
	import_b: IMPORT_BUTTON
	save_b: SAVE_BUTTON
	save_as_b: SAVE_AS_BUTTON
	load_proj_b: LOAD_PROJ_BUTTON

	-- Separators:
	separator, vseparator: SEPARATOR

	-- labels
	visibility_label: LABEL;
	focus_label: FOCUS_LABEL

feature

	cont_cat_t: CONTEXT_CAT_B
	cont_tree_t: CONTEXT_TREE_B
	history_t: HISTORY_B
	editor_t: EDITOR_B
	cmd_cat_t: COMMAND_CAT_B
	app_edit_t: APP_EDITOR_B
	interface_t: INTERFACE_B
	interface_only_t: INTERFACE_ONLY_B
feature 

	hide_show_windows: HIDE_SHOW_WINDOWS
			-- Hide/show windows for Main panel iconization

	make (a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
		do
			-- widget to attach forms to act as transporter
			!! base.make (Widget_names.main_panel, a_screen);
			resources.check_fonts (base);
			base.forbid_resize
			if Pixmaps.eiffelbuild_pixmap.is_valid then
				base.set_icon_pixmap (Pixmaps.eiffelbuild_pixmap)
			end;
			!! form.make (Widget_names.form, base)
			form.set_fraction_base (100)
			set_title (Widget_names.main_panel)
			!! vseparator.make (Widget_names.separator, form)
			vseparator.set_horizontal (False)

			!! hide_show_windows;

			-- icon form
			!! top_form.make (Widget_names.form1, form)
			!! focus_label.initialize (top_form)
			!! quit_b.make (Current, top_form)
			!! con_b.make (top_form)
			!! cmd_b.make (top_form)
			!! cmdi_b.make (top_form)
			!! state_b.make (top_form)
			!! cut_b.make (top_form)
			!! namer_b.make (top_form)
			!! help_b.make (top_form)
			!! separator.make (Widget_names.separator, top_form)
			!! save_b.make (top_form)
			!! save_as_b.make (top_form)	
			!! load_proj_b.make (top_form)
			!! create_proj_b.make (top_form)
			Resources.check_fonts (base)
			separator.set_horizontal (True)
			top_form.attach_top (state_b, 0)
			top_form.attach_top (quit_b, 0)
			top_form.attach_top (con_b, 0)
			top_form.attach_top (cmd_b, 0)
			top_form.attach_top (cmdi_b, 0)
			top_form.attach_top (cut_b, 0)
			top_form.attach_top (namer_b, 0)
			top_form.attach_top (help_b, 0)
			top_form.attach_top (create_proj_b, 0)
			top_form.attach_top (load_proj_b, 0)
			top_form.attach_top (save_b, 0)
			top_form.attach_top (save_as_b, 0)
			top_form.attach_left (con_b, 0)
			top_form.attach_left_widget (con_b, cmd_b, 0)
			top_form.attach_left_widget (cmd_b, cmdi_b, 0)
			top_form.attach_left_widget (cmdi_b, state_b, 0)
			top_form.attach_left_widget (state_b, help_b, 0)
			top_form.attach_left_widget (help_b, namer_b, 0)
			top_form.attach_left_widget (namer_b, cut_b, 0)
			top_form.attach_left_widget (cut_b, create_proj_b, 0)
		--samik	top_form.attach_right_widget (create_proj_b, focus_label, 0)
			top_form.attach_right_widget (load_proj_b, create_proj_b, 0)
			top_form.attach_right_widget (save_b, load_proj_b, 0)
			top_form.attach_right_widget (save_as_b, save_b, 0)
			top_form.attach_right_widget (quit_b, save_as_b, 0)
			top_form.attach_right (quit_b, 0)
	--samik		top_form.attach_bottom_widget (separator, focus_label, 0)
			top_form.attach_bottom_widget (separator, quit_b, 0)
			top_form.attach_bottom_widget (separator, state_b, 0)
			top_form.attach_bottom_widget (separator, con_b, 0)
			top_form.attach_bottom_widget (separator, cmd_b, 0)
			top_form.attach_bottom_widget (separator, cmdi_b, 0)
			top_form.attach_bottom_widget (separator, cut_b, 0)
			top_form.attach_bottom_widget (separator, namer_b, 0)
			top_form.attach_bottom_widget (separator, help_b, 0)
			top_form.attach_bottom_widget (separator, create_proj_b, 0)
			top_form.attach_bottom_widget (separator, load_proj_b, 0)
			top_form.attach_bottom_widget (separator, save_b, 0)
			top_form.attach_bottom_widget (separator, save_as_b, 0)
			top_form.attach_bottom (separator, 0)
			top_form.attach_left (separator, 0)
			top_form.attach_right (separator, 0)

			!!commands_form.make (Widget_names.form2, form)
			!!generate_b.make (commands_form)
			!!import_b.make (commands_form)
			commands_form.attach_top (generate_b, 10)
			commands_form.attach_right (generate_b, 0)
			commands_form.attach_right (import_b, 0)
			commands_form.attach_left (generate_b, 0)
			commands_form.attach_left (import_b, 0)
			commands_form.attach_top_widget (generate_b, import_b, 0)

			-- visibility form
			!!visibility_form.make (Widget_names.form3, form)
			!!row_column1.make (Widget_names.row_column, visibility_form);
			!!row_column2.make (Widget_names.row_column1, visibility_form);
			!!visibility_label.make (Widget_names.visibility_label, visibility_form)
			!!cont_cat_t.make (Widget_names.context_catalog, row_column1)
			!!cont_tree_t.make (Widget_names.context_tree, row_column1)
			!!history_t.make (Widget_names.history_window, row_column1)
			!!editor_t.make (Widget_names.editors_toggle, row_column1)
			!!cmd_cat_t.make (Widget_names.command_catalog, row_column2)
			!!app_edit_t.make (Widget_names.application_editor, row_column2)
			!!interface_t.make (Widget_names.interface_label, row_column2)
			!!interface_only_t.make (Widget_names.interface_only_label, row_column2)

			visibility_form.set_fraction_base (2);
			visibility_form.attach_left (visibility_label, 0);
			visibility_form.attach_right (visibility_label, 0);
			visibility_form.attach_top_widget (visibility_label, row_column1, 0);
			visibility_form.attach_top_widget (visibility_label, row_column2, 0);
			visibility_form.attach_right_position (row_column1, 1);
			visibility_form.attach_left_position (row_column2, 1);
			visibility_form.attach_left (row_column1, 0);
			visibility_form.attach_right (row_column2, 0);
			visibility_form.attach_bottom (row_column1, 0);
			visibility_form.attach_bottom (row_column2, 0);
			-- interform attachment
			form.attach_top_widget (top_form, vseparator, 0)
			form.attach_bottom (vseparator, 0)
			form.attach_top_widget (top_form, commands_form, 2)
			form.attach_right (commands_form, 2)
			form.attach_bottom (commands_form, 2)
			form.attach_left (top_form, 0)
			form.attach_top (top_form, 0)
			form.attach_right (top_form, 0)
			form.attach_top_widget (top_form, visibility_form, 2)
			form.attach_left (visibility_form, 2)
			form.attach_right_widget (vseparator, visibility_form, 2)
			form.attach_right_widget (commands_form, vseparator, 2)
			form.attach_bottom (visibility_form, 2)

				-- default state for buttons
			cont_cat_t.set_toggle_on; 
			cont_tree_t.set_toggle_on; 
			editor_t.set_toggle_on; 
			interface_t.set_toggle_on;
			base.initialize_window_attributes;
			!! del_com.make (Current);
			base.set_delete_command (del_com);
		end

	realize is
		do 
			base.realize
		end
	
feature -- Closing Current

	work (arg: ANY) is do end;

	save_question: BOOLEAN

	close is 
		do
			if history_window.saved_application then
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				save_question := True;
				question_box.popup (Current, Messages.save_project_qu, Void);
			end;
		end;

	question_ok_action is
		local
			save_proj: SAVE_PROJECT;
			quit_app_com: QUIT_NOW_COM
		do
			if save_question then
				!!save_proj;
				save_proj.execute (Void);
				save_question := False;
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				discard_license;
				!! quit_app_com;
				quit_app_com.execute (Void)
			end
		end;

	question_cancel_action is
		do
			if save_question then
				save_question := False;
				question_box.popup (Current, Messages.exit_qu, Void)
			end;
		end;

	popuper_parent: COMPOSITE is
		do
			Result := base
		end

feature -- Popup and popdown actions

	was_popped_down: BOOLEAN

	popup is
		do
			hide_show_windows.show
		end;

	popdown is
		do
			hide_show_windows.hide
		end;

feature -- Interface

	hide_interface is
		local
			window_c: WINDOW_C
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item;
				window_c.hide;
				Shared_window_list.forth
			end
		end

	show_interface is
		local
			window_c: WINDOW_C;
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item;
				window_c.show;
				Shared_window_list.forth
			end;
		end;

end
