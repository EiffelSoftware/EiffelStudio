
class PIXMAPS

inherit

	CONSTANTS
	
feature -- General Pixmaps

	App_interior_stipple: PIXMAP is
		once
			Result := symbol_file_content ("circle.stip")
		end;

	Behavior_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("behavior_small.symb")
		end;

	Behavior_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("behavior.symb")
		end;

 	Bg_bitmap_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_bitmap.symb")
		end;

 	Bg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_color_st.symb")
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
 			Result := symbol_file_content ("cat_menu_entry.symb")
 		end;
 
 	Cat_menu_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_menu_pull.symb")
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

 	Color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color_st.symb")
		end;

	Command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command_instance.symb")
		end;

	Command_o_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command.icon")
		end;

	Command_i_icon_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command_instance.icon")
		end;

	Command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command.symb")
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

	Exit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("exit.symb")
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

	Graph_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("graph.symb")
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

	Instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("instance.symb");
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

	Open_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("open.symb")
		end;

	Parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("parent.symb")
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

	Save_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("save.symb")
		end;

 	Save_as_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("save_as.symb")
		end;

 	Sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sets.symb")
		end;

	Self_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("self_label.symb")
		end;

	State_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("state_small.symb")
		end;

	State_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.symb")
		end;

	State_d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.icon")
		end;

	Return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("return.symb")
		end;

	Type_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("type.symb")
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
			Result := symbol_file_content ("scrolled_w.symb")
		end;

	Scrolled_t_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrolled_t.symb")
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
			Result := symbol_file_content ("button_arm.symb")
		end;

	Button_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button_release.symb")
		end;

	Button_activate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button_activate.symb")
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
			Result := symbol_file_content ("mouse_mot1.symb");
		end;

	Mouse_motion2_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse_mot2.symb");
		end;

	Mouse_motion3_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse_mot3.symb");
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
			Result := symbol_file_content ("scr_t_modify.symb");
		end;

	Scr_t_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_t_motion.symb");
		end;

	Selection_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("single.symb");
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
			full_name: STRING;
		do
			full_name := clone (Environment.bitmaps_directory);
			full_name.extend (Environment.directory_separator);	
			full_name.append (fn);	
			!! Result.make;
			Result.read_from_file (full_name);
			if not Result.is_valid then
				io.error.putstring ("Warning: can not read pixmap file ");
				io.error.putstring (full_name);
				io.error.new_line;
			end
		end

end
