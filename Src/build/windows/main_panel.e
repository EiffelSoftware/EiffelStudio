class MAIN_PANEL 

inherit
	PIXMAPS
		export
			{NONE} all
		end
	WIDGET_NAMES
		export
			{NONE} all
		end
	WINDOWS
	LICENCE_COMMAND
		export
			{NONE} all
		redefine
			cancel_request
		end
	COMMAND_ARGS
		export
			{NONE} all
		end
	UNIX_ENV
		export
			{NONE} all
		end
	CONTEXT_SHARED
		export
			{NONE} all
		end

creation
	make
	
feature 

	base: TRANSPORTER

	-- Is ebuild editing a project?
	project_initialized: BOOLEAN

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

	form, form1, form3, form4: FORM
	
feature 

	quit_b: QUIT_BUTTON
	open_b: OPEN_BUTTON
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
	retrieve_b: RETRIEVE_BUTTON
	t1: CONTEXT_CAT_B
	t2: CONTEXT_TREE_B
	t3: HISTORY_B
	t4: EDITOR_B
	t5: COMMAND_CAT_B
	t6: APP_EDITOR_B
	t7: INTERFACE_B
	t8: INTERFACE_ONLY_B

	-- Separators:
	separator, vseparator: SEPARATOR

	-- labels
	visibility_label, focus_label: LABEL
	
feature 

	make (a_name: STRING a_screen: SCREEN) is
		local
			Void_hw: HELP_WINDOW
		do
			-- widget to attach forms to act as transporter
			!!base.make (a_name, a_screen)
			base.forbid_resize
			!!form.make (F_orm, base)
			form.set_fraction_base (100)
			set_title ("EiffelBuild")
			!!vseparator.make ("vseparator", form)
			vseparator.set_horizontal (False)

			-- icon form
			!!form1.make (F_orm1, form)
			!!quit_b.make (P_Cbutton1, form1)
			!!focus_label.make ("focus", form1)
			!!con_b.make (P_Cbutton4, form1)
			!!cmd_b.make (P_Cbutton5, form1)
			!!cmdi_b.make (P_Cbutton6, form1)
			!!state_b.make (P_Cbutton11, form1)
			!!cut_b.make (P_Cbutton10, form1)
			!!help_b.make (Void_hw, form1)
			!!separator.make (S_eparator, form1)
			focus_label.set_center_alignment	
			focus_label.forbid_recompute_size
			focus_label.set_text ("")
			separator.set_horizontal (True)
			form1.attach_top (quit_b, 0)
			form1.attach_top (focus_label, 0)
			form1.attach_top (con_b, 0)
			form1.attach_top (cmd_b, 0)
			form1.attach_top (cmdi_b, 0)
			form1.attach_top (cut_b, 0)
			form1.attach_top (help_b, 0)
			form1.attach_left (con_b, 0)
			form1.attach_left_widget (con_b, cmd_b, 5)
			form1.attach_left_widget (cmd_b, cmdi_b, 5)
			form1.attach_left_widget (cmdi_b, state_b, 5)
			form1.attach_left_widget (state_b, cut_b, 20)
			form1.attach_left_widget (cut_b, help_b, 5)
			form1.attach_left_widget (help_b, focus_label, 0)
			form1.attach_right_widget (quit_b, focus_label, 0)
			form1.attach_right (quit_b, 0)
			form1.attach_bottom_widget (separator, quit_b, 2)
			form1.attach_bottom_widget (separator, focus_label, 0)
			form1.attach_bottom_widget (separator, con_b, 2)
			form1.attach_bottom_widget (separator, cmd_b, 2)
			form1.attach_bottom_widget (separator, cmdi_b, 2)
			form1.attach_bottom_widget (separator, cut_b, 2)
			form1.attach_bottom_widget (separator, help_b, 2)
			form1.attach_bottom (separator, 0)
			form1.attach_left (separator, 0)
			form1.attach_right (separator, 0)

			-- project form
			!!form3.make ("form3", form)
			!!save_b.make ("save", form3)
			!!save_as_b.make ("save_as", form3)	
			!!retrieve_b.make ("retrieve", form3)
			!!open_b.make ("open", form3)
			!!generate_b.make ("generate", form3)
			!!import_b.make ("import", form3)
			form3.attach_top (open_b, 10)
			form3.attach_right (open_b, 10)
			form3.attach_right (retrieve_b, 10)
			form3.attach_right (save_b, 10)
			form3.attach_right (save_as_b, 10)
			form3.attach_right (generate_b, 10)
			form3.attach_right (import_b, 10)
			form3.attach_left (open_b, 10)
			form3.attach_left (retrieve_b, 10)
			form3.attach_left (save_b, 10)
			form3.attach_left (save_as_b, 10)
			form3.attach_left (generate_b, 10)
			form3.attach_left (import_b, 10)
			form3.attach_top_widget (open_b, retrieve_b, 0)
			form3.attach_top_widget (retrieve_b, save_b, 0)
			form3.attach_top_widget (save_b, save_as_b, 0)
			form3.attach_top_widget (save_as_b, generate_b, 0)
			form3.attach_top_widget (generate_b, import_b, 0)

			-- visibility form
			!!form4.make ("form4", form)
			!!visibility_label.make ("visibility", form4)
			!!t1.make (T_oggle, form4)
			!!t2.make (T_oggle1, form4)
			!!t3.make (T_oggle2, form4)
			!!t4.make (T_oggle3, form4)
			!!t5.make (T_oggle4, form4)
			!!t6.make (T_oggle5, form4)
			!!t7.make (T_oggle6, form4)
			!!t8.make (T_oggle7, form4)
			visibility_label.set_text ("Visibility")
			form4.set_fraction_base(100)
			form4.attach_top (visibility_label, 10)
			form4.attach_left (visibility_label, 10)
			form4.attach_right (visibility_label, 10)
			form4.attach_top_position (t1, 20)
			form4.attach_left (t1, 10)
			form4.attach_right_position (t1, 49)
			form4.attach_top_position (t2, 40)
			form4.attach_left (t2, 10)
			form4.attach_right_position (t2, 49)
			form4.attach_top_position (t3, 60)
			form4.attach_left (t3, 10)
			form4.attach_right_position (t3, 49)
			form4.attach_top_position (t4, 80)
			form4.attach_left (t4, 10)
			form4.attach_right_position (t4, 49)
			form4.attach_top_position (t5, 20)
			form4.attach_right (t5, 10)
			form4.attach_left_position (t5, 51)
			form4.attach_top_position (t6, 40)
			form4.attach_right (t6, 10)
			form4.attach_left_position (t6, 51)
			form4.attach_top_position (t7, 60)
			form4.attach_right (t7, 10)
			form4.attach_left_position (t7, 51)
			form4.attach_top_position (t8, 80)
			form4.attach_right (t8, 10)
			form4.attach_left_position (t8, 51)

			-- interform attachment
			form.attach_top_widget (form1, vseparator, 0)
			form.attach_bottom (vseparator, 0)
			form.attach_top_widget (form1, form3, 10)
			form.attach_right (form3, 10)
			form.attach_bottom (form3, 10)
			form.attach_left (form1, 0)
			form.attach_top (form1, 0)
			form.attach_right (form1, 0)
			form.attach_top_widget (form1, form4, 10)
			form.attach_left (form4, 10)
			form.attach_right_widget (vseparator, form4, 10)
			form.attach_right_widget (form3, vseparator, 10)
			form.attach_bottom (form4, 10)

			-- default state for buttons
			t1.arm -- context catalog
			t2.arm -- context tree
		end

	realize is
		do 
			base.realize
		end
	
feature {TRANSPORTER, TRANSPORTER_I}

	work (arg: ANY) is
		do
		end
	
feature

	cancel_request (arg: ANY) is
		local
			t: TOGGLE_B
		do
			t ?= arg
			if t /= Void then
				t.remove_value_changed_action(current, t)
				if t.state then t.disarm else t.arm end
				t.add_value_changed_action(current, t)
			end
		end

	continue_after_popdown (box: MESSAGE_D ok: BOOLEAN) is
		do
		end

feature {INTERFACE_B}
	hide_interface is
		do
			from
				window_list.start
			until
				window_list.after
			loop
				window_list.item.hide
				window_list.forth
			end
		end

	show_interface is
		do
			from
				window_list.start
			until
				window_list.after
			loop
				window_list.item.show
				window_list.forth
			end
		end
end
