class MAIN_PANEL 

inherit

	WINDOWS
	LICENCE_COMMAND;
	COMMAND_ARGS;
	SHARED_CONTEXT;
	CONSTANTS;
	CLOSEABLE
	QUEST_POPUPER	
		redefine
			continue_after_popdown
		end

creation
	make
	
feature 

	base: TRANSPORTER

	project_initialized: BOOLEAN
			-- Is ebuild editing a project?

	set_title (s: STRING) is 
			-- Set the title of the main panel.
		do 
			base.set_title (s) 
		end

	set_project_initialized is 
			-- Set project_initialized to True.
		do 		
			project_initialized := True 
		end

	unset_project_initialized is 
			-- Set project_initialized to False.
		do 		
			project_initialized := False 
		end
	
feature {NONE}

	check_box1, check_box2: CHECK_BOX;
	form, form1, form2, form3: FORM
	
feature 

	quit_b: CLOSE_WINDOW_BUTTON
	create_proj_b: CREATE_PROJ_BUTTON
	cut_b: CUT_HOLE
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

	make (a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
		do
			-- widget to attach forms to act as transporter
			!! base.make (Widget_names.main_panel, a_screen)
			base.forbid_resize
			!! form.make (Widget_names.form, base)
			form.set_fraction_base (100)
			set_title (Widget_names.main_panel)
			!! vseparator.make (Widget_names.separator, form)
			vseparator.set_horizontal (False)

			-- icon form
			!! form1.make (Widget_names.form1, form)
			!! focus_label.make (form1)
			!! quit_b.make (Current, form1, focus_label)
			!! con_b.make (form1, focus_label)
			!! cmd_b.make (form1, focus_label)
			!! cmdi_b.make (form1, focus_label)
			!! state_b.make (form1, focus_label)
			!! cut_b.make (form1, focus_label)
			!! help_b.make (Void, form1, focus_label)
			!! separator.make (Widget_names.separator, form1)
			!! save_b.make (form1)
			!! save_as_b.make (form1)	
			!! load_proj_b.make (form1)
			!! create_proj_b.make (form1)
			separator.set_horizontal (True)
			form1.attach_top (state_b, 0)
			form1.attach_top (quit_b, 0)
			form1.attach_top (focus_label, 0)
			form1.attach_top (con_b, 0)
			form1.attach_top (cmd_b, 0)
			form1.attach_top (cmdi_b, 0)
			form1.attach_top (cut_b, 0)
			form1.attach_top (help_b, 0)
			form1.attach_top (create_proj_b, 0)
			form1.attach_top (load_proj_b, 0)
			form1.attach_top (save_b, 0)
			form1.attach_top (save_as_b, 0)
			form1.attach_left (con_b, 0)
			form1.attach_left_widget (con_b, cmd_b, 0)
			form1.attach_left_widget (cmd_b, cmdi_b, 0)
			form1.attach_left_widget (cmdi_b, state_b, 0)
			form1.attach_left_widget (state_b, cut_b, 0)
			form1.attach_left_widget (cut_b, help_b, 0)
			form1.attach_left_widget (help_b, focus_label, 0)
			form1.attach_right_widget (create_proj_b, focus_label, 0)
			form1.attach_right_widget (load_proj_b, create_proj_b, 0)
			form1.attach_right_widget (save_b, load_proj_b, 0)
			form1.attach_right_widget (save_as_b, save_b, 0)
			form1.attach_right_widget (quit_b, save_as_b, 0)
			form1.attach_right (quit_b, 0)
			form1.attach_bottom_widget (separator, focus_label, 0)
			form1.attach_bottom_widget (separator, quit_b, 0)
			form1.attach_bottom_widget (separator, state_b, 0)
			form1.attach_bottom_widget (separator, con_b, 0)
			form1.attach_bottom_widget (separator, cmd_b, 0)
			form1.attach_bottom_widget (separator, cmdi_b, 0)
			form1.attach_bottom_widget (separator, cut_b, 0)
			form1.attach_bottom_widget (separator, help_b, 0)
			form1.attach_bottom_widget (separator, create_proj_b, 0)
			form1.attach_bottom_widget (separator, load_proj_b, 0)
			form1.attach_bottom_widget (separator, save_b, 0)
			form1.attach_bottom_widget (separator, save_as_b, 0)
			form1.attach_bottom (separator, 0)
			form1.attach_left (separator, 0)
			form1.attach_right (separator, 0)

			!!form2.make (Widget_names.form2, form)
			!!generate_b.make (form2)
			!!import_b.make (form2)
			form2.attach_top (generate_b, 10)
			form2.attach_right (generate_b, 0)
			form2.attach_right (import_b, 0)
			form2.attach_left (generate_b, 0)
			form2.attach_left (import_b, 0)
			form2.attach_top_widget (generate_b, import_b, 0)

			-- visibility form
			!!form3.make (Widget_names.form3, form)
			!!check_box1.make (Widget_names.check_box, form3);
			!!check_box2.make (Widget_names.check_box, form3);
			!!visibility_label.make (Widget_names.visibility_label, form3)
			!!cont_cat_t.make (Widget_names.context_catalog, check_box1)
			!!cont_tree_t.make (Widget_names.context_tree, check_box1)
			!!history_t.make (Widget_names.history_window, check_box1)
			!!editor_t.make (Widget_names.editors_toggle, check_box1)
			!!cmd_cat_t.make (Widget_names.command_catalog, check_box2)
			!!app_edit_t.make (Widget_names.application_editor, check_box2)
			!!interface_t.make (Widget_names.interface_toggle, check_box2)
			!!interface_only_t.make (Widget_names.interface_only_toggle, check_box2)
			form3.set_fraction_base (2);
			form3.attach_left (visibility_label, 0);
			form3.attach_right (visibility_label, 0);
			form3.attach_top_widget (visibility_label, check_box1, 0);
			form3.attach_top_widget (visibility_label, check_box2, 0);
			form3.attach_right_position (check_box1, 1);
			form3.attach_left_position (check_box2, 1);
			form3.attach_left (check_box1, 0);
			form3.attach_right (check_box2, 0);
			form3.attach_bottom (check_box1, 0);
			form3.attach_bottom (check_box2, 0);
			-- interform attachment
			form.attach_top_widget (form1, vseparator, 0)
			form.attach_bottom (vseparator, 0)
			form.attach_top_widget (form1, form2, 2)
			form.attach_right (form2, 2)
			form.attach_bottom (form2, 2)
			form.attach_left (form1, 0)
			form.attach_top (form1, 0)
			form.attach_right (form1, 0)
			form.attach_top_widget (form1, form3, 2)
			form.attach_left (form3, 2)
			form.attach_right_widget (vseparator, form3, 2)
			form.attach_right_widget (form2, vseparator, 2)
			form.attach_bottom (form3, 2)

				-- default state for buttons
			cont_cat_t.arm -- context catalog
			cont_tree_t.arm -- context tree
			editor_t.set_toggle_on -- Editor active
			!! del_com.make (Current);
			base.set_delete_command (del_com)
		end

	realize is
		do 
			base.realize
		end
	
feature {TRANSPORTER, TRANSPORTER_I}

	work (arg: ANY) is
		do
		end
	
feature {INTERFACE_B}

	hide_interface is
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				Shared_window_list.item.hide
				Shared_window_list.forth
			end
		end

	show_interface is
		do
			from
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				Shared_window_list.item.show
				Shared_window_list.forth
			end
		end;

feature -- Closing Current

	save_question: BOOLEAN

	close is 
		do
			if history_window.saved_application then
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				question_box.popup (Current, Messages.save_project_qu, Void);
				save_question := True;
			end;
		end;

	continue_after_popdown (box: QUESTION_BOX; yes: BOOLEAN) is
		local
			save_proj: SAVE_PROJECT;
			quit_app_com: QUIT_NOW_COM
		do
			if save_question then
				if yes then
					!!save_proj;
					save_proj.execute (Void);
				end;
				save_question := False;
				question_box.popup (Current, Messages.exit_qu, Void)
			else
				if yes then
					discard_licence;
					!! quit_app_com;
					quit_app_com.execute (Void)
				end;
			end
		end;

end
