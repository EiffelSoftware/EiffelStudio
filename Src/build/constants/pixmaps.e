
class PIXMAPS

inherit

	UNIX_ENV
		export
			{NONE} all
		end
	
feature {NONE}

	Default_background_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("default_bg_pixmap.symb")
		end;

	Font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("font.symb")
		end;

	Parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("parent.symb")
		end;

	Client_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("client.symb")
		end;

	Open_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("open.symb")
		end;

	Namer_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("namer.symb")
		end;

	Save_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("save.symb")
		end;

	Help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("help.symb")
		end;

	Quit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("quit.symb")
		end;

	Generate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("generate.symb")
		end;

	Import_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("import.symb")
		end;

	Exit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("exit.symb")
		end;

	Self_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("self_label.symb")
		end;

	Initial_state_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("initial_state.symb")
		end;

	App_interior_stipple: PIXMAP is
		once
			Result := symbol_file_content ("circle.stip")
		end;

	Text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text.symb")
		end;

	Txt_key_press_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("txt_key_press.symb")
		end;

	Txt_modify_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("txt_modify.symb")
		end;

	Return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("return.symb")
		end;

	Wastebasket_open_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastebasket_open.symb")
		end;

	Wastebasket_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastebasket.symb")
		end;

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

	Predefined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows.symb")
		end;

	User_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_defined.symb")
		end;

	General_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("general.symb")
		end;

	Bricks_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bricks.symb")
		end;

	Button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button.symb")
		end;

	Default_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("default.symb")
		end;

	State_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("state_small.symb")
		end;

	State_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.symb")
		end;

	Command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command.symb")
		end;

	Command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command_instance.symb")
		end;

	Create_command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("create_instance.symb")
		end;

	Context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("context.symb")
		end;

	Event_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("event.symb")
		end;

	Type_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("type.symb")
		end;

	Behavior_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("behavior_small.symb")
		end;

	Behavior_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("behavior.symb")
		end;

	Graph_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("graph.symb")
		end;

	Mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse.symb");
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

	Merge_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("merge.symb");
		end;

	Empty_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("empty.symb");
		end;

	Cut_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cut.symb");
		end;

	Windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows.symb")
		end;

	Primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("primitives.symb")
		end;

	Menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menus.symb")
		end;

	Containers_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("containers.symb");
		end;

	Push_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("push_b.symb");
		end;

	Top_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("top_shell.symb");
		end;

	Instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("instance.symb");
		end;

	File_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("file.symb");
		end;

	Label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("label.symb");
		end;

	Ev_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ev_label.symb");
		end;

	-- *******************
	-- * Context symbols *
	-- *******************

	Dialog_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("dialog_shell.symb")
		end;

	Bulletin_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bulletin.symb")
		end;

	Form_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("form.symb")
		end;

	Row_column_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("row_column.symb")
		end;

	Frame_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("frame.symb")
		end;

	Radio_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("radio_box.symb")
		end;

	Check_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("check_box.symb")
		end;

	Paned_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("paned_w.symb")
		end;

	Scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrolled_w.symb")
		end;

	Text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text_field.symb")
		end;

	Pict_color_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pict_color_b.symb")
		end;

	Scrolled_t_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrolled_t.symb")
		end;

	Toggle_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("toggle_b.symb")
		end;

	Separator_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("separator.symb")
		end;

	Arrow_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("arrow_b.symb")
		end;

	Draw_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("draw_b.symb")
		end;

	Drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("drawing_area.symb")
		end;

	Scroll_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scroll_list.symb")
		end;

	Bar_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bar.symb")
		end;

	Opt_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("opt_pull.symb")
		end;

	Menu_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_pull.symb")
		end;

	Menu_entry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_entry.symb")
		end;

	Scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scale.symb")
		end;
 
 	Group_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.symb")
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
 
 	Groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.symb")
 		end;
 
 	Bg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_color_st.symb")
		end;

 	Fg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("fg_color_st.symb")
		end;

 	Color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color_st.symb")
		end;

 	Sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sets.symb")
		end;

 	Save_as_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("save_as.symb")
		end;

 	Edit_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("edit_stone.symb")
		end;

 	Bg_bitmap_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_bitmap.symb")
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

 	Ear_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ear.symb")
		end;

	symbol_file_content (fn: STRING): PIXMAP is
		local
			full_path: STRING;
		do
			full_path := Bitmaps_directory;
			full_path.append ("/");	
			full_path.append (fn);	
			!!Result.make;
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Warning: can not read pixmap file ");
				io.error.putstring (fn);
				io.error.new_line;
			end
		end

end
