
class MAIN_PANEL 

inherit

	PIXMAPS
		export
			{NONE} all
		end;
	WIDGET_NAMES
		export
			{NONE} all
		end;
	WINDOWS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	COMMAND_ARGS
		export
			{NONE} all
		end;
	UNIX_ENV
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end

creation

	make
	
feature 

	base: TRANSPORTER;

	project_initialized: BOOLEAN;
			-- Is ebuild editing a project?

	set_title (s: STRING) is 
			-- Set the title of the main panel.
		do 
			base.set_title (s) 
		end;

	set_project_initialized is 
			-- Set project_initialized to True.
		do 		
			project_initialized := True 
		end;
	
feature {NONE}

	form, form1, form2, form3: FORM;
		-- Namer hole:
	
feature 

	namer_hole: NAMER_HOLE;
		-- Buttons:
	
feature 

	quit_b: QUIT_BUTTON;
	open_b: OPEN_BUTTON;

	edit_b: EDIT_BUTTON;
	cut_b: CUT_HOLE;
	help_b: HELP_HOLE;

	generate_b: GENERATE_BUTTON;
	import_b: IMPORT_BUTTON;
	save_b: SAVE_BUTTON;
	save_as_b: SAVE_AS_BUTTON;
		-- Visibility:
	check_box, check_box1: CHECK_BOX;
	visibility_label, focus_label: LABEL;
	t1, t2, t3, t4, t5, t6, t7, t8: TOGGLE_B;
		-- Separators:
	separator, separator1, separator2: SEPARATOR;

	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
		local
			Void_hw: HELP_WINDOW
		do
			!!base.make (a_name, a_screen);
			base.forbid_resize;
			!!form.make (F_orm, base);
			!!form1.make (F_orm1, form);
				!!open_b.make (P_Cbutton, form1);
				!!quit_b.make (P_Cbutton1, form1);
				!!focus_label.make (L_abel, form1);
				focus_label.set_center_alignment;	
				focus_label.forbid_recompute_size;	
				!!edit_b.make (P_Cbutton2, form1);
				!!cut_b.make (P_Cbutton10, form1);
				!!help_b.make (Void_hw, form1);
				form1.attach_top (open_b, 0);
				form1.attach_top (quit_b, 0);
				form1.attach_top (focus_label, 0);
				form1.attach_top (edit_b, 0);
				form1.attach_bottom (focus_label, 0);
				form1.attach_top (cut_b, 0);
				form1.attach_top (help_b, 0);

				form1.attach_left (open_b, 0);
				form1.attach_left_widget (open_b, quit_b, 5);
				form1.attach_left_widget (quit_b, focus_label, 0);
				form1.attach_right_widget (edit_b, focus_label, 0);

				form1.attach_right_widget (cut_b, edit_b, 5);
				form1.attach_right_widget (help_b, cut_b, 5);
				form1.attach_right (help_b, 15);

			!!form2.make (F_orm2, form);
				!!generate_b.make (P_Cbutton7, form2);
				!!save_b.make (P_Cbutton8, form2);
				!!import_b.make (P_Cbutton9, form2);
				!!save_as_b.make (P_Cbutton3, form2);	
				form2.attach_top (generate_b, 2);
				form2.attach_left (generate_b, 2);
				form2.attach_right (generate_b, 2);
				form2.attach_top_widget (generate_b, import_b, 2);
				form2.attach_left (import_b, 2);
				form2.attach_right (import_b, 2);
				form2.attach_top_widget (import_b, save_b, 5);
				form2.attach_left (save_b, 2);
				form2.attach_right (save_b, 2);
				form2.attach_top_widget (save_b, save_as_b, 2);
				form2.attach_left (save_as_b, 2);
				form2.attach_right (save_as_b, 2);
			!!form3.make (F_orm3, form);
				!!check_box.make (C_heck_box, form3);
				!!check_box1.make (C_heck_box1, form3);
				!!visibility_label.make (L_abel, form3);
				!!t1.make (T_oggle, check_box);
				!!t2.make (T_oggle1, check_box);
				!!t3.make (T_oggle2, check_box1);
				!!t4.make (T_oggle3, check_box1);
				!!t5.make (T_oggle4, check_box);
				!!t6.make (T_oggle5, check_box1);
				!!t7.make (T_oggle6, check_box);
				!!t8.make (T_oggle7, check_box1);
				form3.set_fraction_base (2);
				form3.attach_left (visibility_label, 0);
				form3.attach_right (visibility_label, 0);
				form3.attach_top_widget (visibility_label, check_box, 0);
				form3.attach_top_widget (visibility_label, check_box1, 0);
				form3.attach_right_position (check_box, 1);
				form3.attach_left_position (check_box1, 1);
				form3.attach_left (check_box, 0);
				form3.attach_right (check_box1, 0);
				form3.attach_bottom (check_box, 0);
				form3.attach_bottom (check_box1, 0);
			!!namer_hole.make (H_ole, form);
			!!separator.make (S_eparator, form);
			!!separator1.make (S_eparator1, form);
			!!separator2.make (S_eparator2, form);
			separator.set_horizontal (True);
			separator1.set_horizontal (True);
			separator2.set_horizontal (False);

			form.attach_left (separator, 0);
			form.attach_left (separator1, 0);
			form.attach_right_widget (separator2, separator, 0);
			form.attach_right_widget (separator2, separator1, 0);
			form.attach_top (separator2, 0);
			form.attach_bottom (separator2, 0);
			form.attach_top_widget (form1, separator, 0);
			form.attach_bottom_widget (namer_hole.form, separator1, 0);
			form.attach_right_widget (form2, separator2, 0);

			form.attach_left (form1, 0);
			form.attach_top (form1, 0);
			form.attach_right_widget (separator2, form1, 0);
			form.attach_left (form3, 0);
			form.attach_top_widget (separator, form3, 0);
			form.attach_right_widget (separator2, form3, 0);
			form.attach_bottom_widget (separator1, form3, 0);
			form.attach_top (form2, 0);
			form.attach_right (form2, 0);
			form.attach_bottom (form2, 0);
			form.attach_bottom (namer_hole.form, 0);
			form.attach_left (namer_hole.form, 0);
			form.attach_right_widget (separator2, namer_hole.form, 0);

			-- *** Set values ***

			t1.arm;
			t2.arm;
			t3.disarm;
			t4.disarm;
			t5.disarm;
			t6.arm;
			t7.arm;
			t8.disarm;
			t1.set_text ("Context catalog");
			t2.set_text ("Context tree");
			t3.set_text ("Command catalog");
			t4.set_text ("Application editor");
			t5.set_text ("History");
			t6.set_text ("Interface");
			t7.set_text ("Editors");
			t8.set_text ("Interface only");
			separator.set_single_line;
			separator1.set_single_line;
			separator2.set_single_line;
			set_title ("EiffelBuild");
			focus_label.set_text ("");
			visibility_label.set_text ("Visibility");
				-- implement focus mechanism

			t1.add_value_changed_action (Current, t1);
			t2.add_value_changed_action (Current, t2);
			t3.add_value_changed_action (Current, t3);
			t4.add_value_changed_action (Current, t4);
			t5.add_value_changed_action (Current, t5);
			t6.add_value_changed_action (Current, t6);
			t7.add_value_changed_action (Current, t7);
			t8.add_value_changed_action (Current, t8);
		end;

	realize is do base.realize end;

	
feature {NONE}

	t1_state, t2_state, t3_state, t4_state: BOOLEAN;
	t5_state, t6_state, t7_state: BOOLEAN;

	execute (argument: ANY) is
		local
			t: TOGGLE_B
		do
			if 
				project_initialized 
			then
				if (argument = t1) then
					if t1.state then
						context_catalog.show;
						t1_state := True
					else
						context_catalog.hide;
						t1_state := False
					end;
				elseif (argument = t2) then
					if t2.state then
						tree.show;
						t2_state := True
					else
						tree.hide;
						t2_state := False
					end;
				elseif (argument = t3) then
					if t3.state then
						if command_catalog.realized then
							command_catalog.show;
						else
							command_catalog.realize;
						end;
						t3_state := True
					else
						command_catalog.hide;
						t3_state := False
					end;
				elseif (argument = t4) then
					if t4.state then
						if app_editor.realized then
							app_editor.show
						else
							app_editor.realize
						end;
						t4_state := True
					else
						app_editor.hide;
						t4_state := False
					end;
				elseif (argument = t5) then
					if t5.state then
						if history_window.realized then
							history_window.show
						else
							history_window.realize
						end;
						t5_state := True
					else
						history_window.hide;
						t5_state := False
					end;
				elseif (argument = t6) then
					if t6.state then
						show_interface;
						t6_state := True
					else
						hide_interface;
						t6_state := False
					end;
				elseif (argument = t7) then
					if t7.state then
						window_mgr.show_all_editors;
						t7_state := True
					else
						window_mgr.hide_all_editors;
						t7_state := False
					end
				elseif (argument = t8) then
					if t8.state then
						show_interface;
						if t1.state then
							context_catalog.hide;
							t1_state := True
						end;
						if t2.state then
							tree.hide;
							t2_state := True
						end;
						if t3.state then
							command_catalog.hide;
							t3_state := True
						end;
						if t4.state then
							app_editor.hide;
							t4_state := True
						end;
						if t5.state then
							history_window.hide;
							t5_state := True
						end;
						if t6.state then
							t6_state := True
						end;
						if t7.state then
							window_mgr.hide_all_editors;
							t7_state := True
						end;
					else
						if t1_state then
							context_catalog.show;
							t1_state := False
						end;
						if t2_state then
							tree.show;
							t2_state := False
						end;
						if t3_state then
							command_catalog.show;
							t3_state := False
						end;
						if t4_state then
							app_editor.show	;
							t4_state := False
						end;
						if t5_state then
							history_window.show	;
							t5_state := False
						end;
						if t6_state then
							show_interface;
							t6_state := False
						else
							hide_interface
						end;
						if t7_state then
							window_mgr.show_all_editors;
							t7_state := False
						end
					end
				end;
			else
				t ?= argument;
				if t.state then t.disarm else t.arm end;
			end
		end;

	hide_interface is
		do
			from
				window_list.start
			until
				window_list.after
			loop
				window_list.item.hide;
				window_list.forth
			end;
		end;

	show_interface is
		do
			from
				window_list.start
			until
				window_list.after
			loop
				window_list.item.show;
				window_list.forth
			end;
		end;
end
