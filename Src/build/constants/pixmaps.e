
class PIXMAPS

inherit

	CONSTANTS
	
feature -- General Pixmaps

	Alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("align.symb")
		end;

	App_interior_stipple: PIXMAP is
		once
			Result := symbol_file_content ("circle.stip")
		end;

	Attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("attrib.symb")
		end;

	Behavior_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("behavior.symb")
		end;

	Behavior_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_dot.symb")
		end;

	Behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_format.symb")
		end;

 	Bg_bitmap_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_bitmap.symb")
		end;

 	Bg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_color_st.symb")
		end;

 	Bg_pixmap_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_pixmap.symb")
		end;

	Bricks_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bricks.symb")
		end;

 	Cat_temp_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_temp_wind.symb")
 		end;
 
 	Cat_perm_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_perm_wind.symb")
 		end;
 
 	Cat_bulletin_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bulletin.symb")
 		end;
 
 	Cat_form_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_form.symb")
 		end;
 
 	Cat_menu_entry_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_m_entry.symb")
 		end;
 
 	Cat_menu_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_m_pull.symb")
 		end;
 
 	Cat_opt_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_opt_pull.symb")
 		end;
 
 	Cat_bar_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bar.symb")
 		end;
 
	Client_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("client.symb")
		end;

 	Color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color.symb")
		end;

 	Color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color_st.symb")
		end;

	Command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("instance.symb")
		end;

	Command_instance_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("inst_dot.symb")
		end;

	Command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_page.symb")
		end;

	Command_i_icon_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_instance.symb")
		end;

	Command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command.symb")
		end;

	Command_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_dot.symb")
		end;

	Containers_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("containers.symb");
		end;

	Create_command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("create_instance.symb")
		end;

	Create_command_instance_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("create_instance.icon")
		end;

	Create_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("create_proj.symb")
		end;

	Cut_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cut.symb");
		end;

	Default_background_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("default_bg_pixmap.symb")
		end;

	Default_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("default.symb")
		end;

 	Ear_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ear.symb")
		end;

 	Edit_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("edit_stone.symb")
		end;

	EiffelBuild_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ebuild.symb");
		end;

	Empty_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("empty.symb");
		end;

	Ev_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ev_label.symb");
		end;

	Event_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("event.symb")
		end;

	Event_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("event_dot.symb")
		end;

	Exit_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("exit_label.symb")
		end;

	Expand_parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expand.symb")
		end;

	File_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("file.symb");
		end;

 	Fg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("fg_color_st.symb")
		end;

	Font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("font.symb")
		end;

	General_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("general.symb")
		end;

	Generate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("generate.symb")
		end;

	Geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("geometry.symb")
		end;

	Graph_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("graph.symb")
		end;

 	Grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid.symb")
		end;

 	Grid5_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid5.symb")
		end;

 	Grid10_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid10.symb")
		end;

 	Grid15_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid15.symb")
		end;

 	Grid20_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid20.symb")
		end;

	Help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("help.symb")
		end;

	Import_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("import.symb")
		end;

	Initial_state_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("initial_state.symb")
		end;

	Load_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("load_proj.symb")
		end;

	Menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menus.symb")
		end;

	Merge_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("merge.symb");
		end;

	Namer_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("namer.symb")
		end;

	Ok_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ok_tick.symb")
		end

	Parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("parent.symb")
		end;

	Popup_filename_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_fn.symb")
		end;

	Popup_instances_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_insts.symb")
		end;

	Popup_context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_context.symb")
		end;

	Predef_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pred_cmd.symb")
		end;

	Predefined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows.symb")
		end;

	Primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("primitives.symb")
		end;

	Quit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("quit.symb")
		end;

	Raise_widget_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("raise_widget.symb")
		end;

	Save_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("save.symb")
		end;

 	Save_as_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("save_as.symb")
		end;

	Selected_alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_align.symb")
		end;

	Selected_attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_attrib.symb")
		end;

	Selected_behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_beh_format.symb")
		end;

	Selected_button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_button.symb")
		end;

 	Selected_color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sel_color.symb")
		end;

	Selected_command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_cmd_page.symb")
		end;

	Selected_drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_drawing_area.symb")
		end;

	Selected_file_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_file.symb");
		end;

	Selected_font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_font.symb")
		end;

	Selected_general_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_general.symb")
		end;

	Selected_geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_geometry.symb")
		end;

 	Selected_grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sel_grid.symb")
		end;

	Selected_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("s_scr_list.symb")
		end;

	Selected_scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("s_scr_w.symb")
		end;

	Selected_resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_resize.symb");
		end;

	Selected_windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_windows.symb")
		end;

	Selected_primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_primitives.symb")
		end;

	Selected_menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_menus.symb")
		end;

	Selected_mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_mouse.symb")
		end;

	Selected_scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_scale.symb")
		end;
 
 	Selected_groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sel_groups.symb")
 		end;
 
 	Selected_sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sel_sets.symb")
		end;

	Selected_submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_submenu.symb");
		end;

	Selected_text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_text.symb");
		end;

	Selected_text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_tf.symb")
		end;

	Selected_translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_translation.symb")
		end;

	Selected_user_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sel_user_defined.symb")
		end;

 	Sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sets.symb")
		end;

	Self_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("self_label.symb")
		end;

	Show_window_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("show_window.symb")
		end;

	State_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("state_small.symb")
		end;

	State_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.symb")
		end;

	State_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state_dot.symb")
		end;

	State_d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.icon")
		end;

	Return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("return.symb")
		end;

	Transition_line_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("transition.symb");
		end;

	Type_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("type.symb")
		end;

	Unsave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("unsave.symb")
		end;

	User_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_cmd.symb")
		end;

	User_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_defined.symb")
		end;

	Wastebasket_open_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastebasket_open.symb")
		end;

	Wastebasket_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastebasket.symb")
		end;

	Windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows.symb")
		end;

feature -- Context Pixmaps

	Arrow_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("arrow_b.symb")
		end;

	Bar_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bar.symb")
		end;

	Bulletin_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bulletin.symb")
		end;

	Check_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("check_box.symb")
		end;

	Context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("context.symb")
		end;

	Context_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cont_dot.symb")
		end;

	Dialog_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("dialog_shell.symb")
		end;

	Draw_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("draw_b.symb")
		end;

	Drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("drawing_area.symb")
		end;

	Form_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("form.symb")
		end;

	Frame_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("frame.symb")
		end;

 	Group_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.symb")
 		end;
 
 	Groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.symb")
 		end;
 
	Label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("label.symb");
		end;

	List_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scroll_list.symb")
		end;

	Menu_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_pull.symb")
		end;

	Menu_entry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_entry.symb")
		end;

	Opt_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("opt_pull.symb")
		end;

	Pict_color_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pict_color_b.symb")
		end;

	Push_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("push_b.symb");
		end;

	Top_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("top_shell.symb");
		end;

	Radio_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("radio_box.symb")
		end;

	Row_column_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("row_column.symb")
		end;

	Scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_w.symb")
		end;

	Scrolled_t_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_t.symb")
		end;

	Separator_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("separator.symb")
		end;

	Scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scale.symb")
		end;
 
	Scroll_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scroll_list.symb")
		end;

	Text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text.symb");
		end;

	Text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text_field.symb")
		end;

	Toggle_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("toggle_b.symb")
		end;

feature -- Event pixmaps

	Button_arm_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_arm.symb")
		end;

	Button_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_release.symb")
		end;

	Button_activate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_activate.symb")
		end;

	Button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button.symb")
		end;

	Changed_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("changed.symb");
		end;

	Entered_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("entered.symb");
		end;

	Expose_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expose.symb");
		end;

	Input_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("input.symb");
		end;

	Key_return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_return.symb");
		end;

	Key_press_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_press.symb");
		end;

	Key_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_release.symb");
		end;

	Mouse1u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1u.symb");
		end;

	Mouse2u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2u.symb");
		end;

	Mouse3u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3u.symb");
		end;

	Mouse1d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1d.symb");
		end;

	Mouse2d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2d.symb");
		end;

	Mouse3d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3d.symb");
		end;

	Mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse.symb")
		end;

	Mouse_motion1_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mot1_mouse.symb");
		end;

	Mouse_motion2_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mot2_mouse.symb");
		end;

	Mouse_motion3_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mot3_mouse.symb");
		end;

	Mouse_enter_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse_enter.symb");
		end;

	Move_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("move.symb");
		end;

	Mouse_leave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse_leave.symb");
		end;

	Pointer_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pointer_mot.symb");
		end;

	Scr_t_modify_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_modify.symb");
		end;

	Scr_t_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_motion.symb");
		end;

	Selection_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("single.symb");
		end;

	Submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("submenu.symb");
		end;

	Translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("translation.symb")
		end;

	Txt_key_press_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("txt_key_press.symb")
		end;

	Txt_modify_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("txt_modify.symb")
		end;

	Resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("resize.symb");
		end;

	Value_changed_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("changed.symb");
		end;

	Widget_destroy_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("widget_dest.symb");
		end;

feature {NONE} -- Read from file

	symbol_file_content (fn: STRING): PIXMAP is
		local
			full_name: FILE_NAME;
		do
			!! full_name.make_from_string (Environment.bitmaps_directory);
			full_name.set_file_name (fn);	
			!! Result.make;
			Result.read_from_file (full_name);
			if not Result.is_valid then
				io.error.putstring ("Warning: can not read pixmap file ");
				io.error.putstring (full_name);
				io.error.new_line;
			end
		end

end
