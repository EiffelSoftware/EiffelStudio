class PIXMAPS

inherit
	CONSTANTS
	SHARED_PLATFORM_CONSTANTS
	
feature -- General Pixmaps

	Alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("align")
		end;

	App_interior_stipple: PIXMAP is
		once
			Result := symbol_file_content ("int_stip")
		end;

	Attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("attrib")
		end;

	Behavior_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("behavior")
		end;

	Behavior_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_dot")
		end;

	Behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_frmt")
		end;

 	Bg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_clrst")
		end;

 	Bg_pixmap_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_pxmap")
		end;

 	Cat_temp_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_tmpw")
 		end;
 
 	Cat_perm_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_prmw")
 		end;
 
 	Cat_bulletin_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bltn")
 		end;
 
 	Cat_menu_entry_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_ment")
 		end;
 
 	Cat_menu_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_mpul")
 		end;
 
 	Cat_opt_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_opul")
 		end;
 
 	Cat_bar_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bar")
 		end;
 
 	Color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color")
		end;

 	Color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color_st")
		end;

	Command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("instance")
		end;

	Command_instance_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("inst_dot")
		end;

	Command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_page")
		end;

	Command_i_icon_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_inst")
		end;

	Command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command")
		end;

	Command_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_dot")
		end;

	Create_command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("crt_inst")
		end;

	Create_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("crt_proj")
		end;

 	Ear_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ear")
		end;

	EiffelBuild_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ebuild");
		end;

	Ev_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ev_label");
		end;

	Event_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("event")
		end;

	Event_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("evnt_dot")
		end;

	Exit_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("exit_lbl")
		end;

	Expand_parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expand")
		end;

	File_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("file");
		end;

 	Fg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("fg_clrst")
		end;

	Font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("font")
		end;

	Full_help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("fullhelp")
		end;

	General_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("general")
		end;

	Generate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("generate")
		end;

	generated_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("generated")
		end

	Geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("geometry")
		end;

 	Grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid")
		end;

 	Grid5_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid5")
		end;

 	Grid10_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid10")
		end;

 	Grid15_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid15")
		end;

 	Grid20_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid20")
		end;

	Help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("help")
		end;

	Import_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("import")
		end;

	Initial_state_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("initl_st")
		end;

	Load_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("open")
		end;

	Menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menus")
		end;

	Merge_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("merge");
		end;

	Namer_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("namer")
		end;

	Ok_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ok_tick")
		end

	Parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("parent")
		end;

	Parent_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("par_dot")
		end;

	Popup_filename_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_fn")
		end;

	Popup_instances_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_inst")
		end;

	Popup_context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_cntx")
		end;

	Predef_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pred_cmd")
		end;

	Primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("primitvs")
		end;

	Presentation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("present")
		end

	Quit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("quit")
		end;

	Raise_widget_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("raise_wd")
		end;
	
	Reset_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("reset")
		end

	Save_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("save")
		end;

	Selected_alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("salign")
		end;

	Selected_attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sattrib")
		end;

	Selected_behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sbh_frmt")
		end;

	Selected_button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sbutton")
		end;

 	Selected_color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("scolor")
		end;

	Selected_command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scmd_pge")
		end;

	Selected_drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sdrwn_ar")
		end;

	Selected_file_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sfile");
		end;

	Selected_font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sfont")
		end;

	Selected_general_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sgeneral")
		end;

	Selected_generated_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sgenerated")
		end

	Selected_geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sgeomtry")
		end;

 	Selected_grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sgrid")
		end;

	Selected_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscrll_l")
		end;

	Selected_scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscrll_w")
		end;

	Selected_resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sresize");
		end;

	Selected_reset_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sreset")
		end

	Selected_windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("swindows")
		end;

	Selected_primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sprimtvs")
		end;

	Selected_menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("smenus")
		end;

	Selected_mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("smouse")
		end;

	Selected_scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscale")
		end;
 
 	Selected_groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sgroups")
 		end;
 
 	Selected_sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ssets")
		end;

	Selected_submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ssubmenu");
		end;

	Selected_text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("stext");
		end;

	Selected_text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("stxt_fld")
		end;

	Selected_translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("strnsltn")
		end;

	Selected_user_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("susr_def")
		end;

 	Sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sets")
		end;

	Self_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("self_lbl")
		end;

	Show_window_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("shw_wndw")
		end;

	State_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("state_sm")
		end;

	State_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state")
		end;

	State_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state_dt")
		end;

	Return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("return")
		end;

	Transition_line_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("transitn");
		end;

	Type_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("type")
		end;

	Unsave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("modified")
		end;

	User_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_cmd")
		end;

	User_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_def")
		end;

	Wastebasket_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastbskt")
		end;

	Windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows")
		end;

feature -- Context Pixmaps

	Arrow_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("arrow_b")
		end;

	Bar_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bar")
		end;

	Bulletin_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bulletin")
		end;

	Check_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("check_bx")
		end;

	Context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("context")
		end;

	Context_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cont_dot")
		end;

	Dialog_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("dialg_sh")
		end;

	Drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("drwng_ar")
		end;

 	Group_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups")
 		end;
 
 	Groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups")
 		end;
 
	Label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("label");
		end;

	List_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end;

	Menu_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_pll")
		end;

	Menu_entry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_ent")
		end;

	Opt_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("opt_pull")
		end;

	Pict_color_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pictclrb")
		end;

	Push_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("push_b");
		end;

	Top_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("top_shll");
		end;

	Radio_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("radio_bx")
		end;

	Scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_w")
		end;

	Scrolled_t_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_t")
		end;

	Separator_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("separatr")
		end;

	Scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scale")
		end;
 
	Scroll_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end;

	Scrollable_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end;

	Text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text");
		end;

	Text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text_fld")
		end;

	Toggle_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("toggle_b")
		end;

feature -- Event pixmaps

	Button_arm_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_arm")
		end;

	Button_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_rels")
		end;

	Button_activate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_actv")
		end;

	Button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button")
		end;

	Expose_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expose");
		end;

	Input_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("input");
		end;

	Key_return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_rtrn");
		end;

	Key_press_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_prss");
		end;

	Key_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_rels");
		end;

	Mouse1u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1u");
		end;

	Mouse2u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2u");
		end;

	Mouse3u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3u");
		end;

	Mouse1d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1d");
		end;

	Mouse2d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2d");
		end;

	Mouse3d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3d");
		end;

	Mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse")
		end;

	Mouse_motion1_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt1mouse");
		end;

	Mouse_motion2_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt2mouse");
		end;

	Mouse_motion3_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt3mouse");
		end;

	Mouse_enter_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mse_entr");
		end;

	Move_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("move");
		end;

	Mouse_leave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mse_leav");
		end;

	Pointer_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pntr_mot");
		end;

	Scr_t_modify_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_modf");
		end;

	Scr_t_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_motn");
		end;

	Selection_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("single");
		end;

	Submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("submenu");
		end;

	Translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("transltn")
		end;

	Resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("resize");
		end;

	Value_changed_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("changed");
		end;

	Widget_destroy_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wdgt_dst");
		end;

feature {NONE} -- Read from file
	
	pixmap_suffix: STRING is
			-- Suffix for pixmaps (bmp for windows - xpm for motif).
		once
			if Platform_constants.is_windows then
				Result := "bmp"
			else
				Result := "xpm"
			end
		end
	
	Pixmap_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Environment.bitmaps_directory);
			Result.extend (Pixmap_suffix)
		end;
	
	symbol_file_content (fn: STRING): PIXMAP is
		local
			full_name: FILE_NAME;
		do
			!! full_name.make_from_string (Pixmap_path);
			full_name.set_file_name (fn);	
			full_name.add_extension (Pixmap_suffix)
			!! Result.make;
			if full_name.is_valid then
				Result.read_from_file (full_name);
-- 				if not Result.is_valid then 
-- 					io.error.putstring ("%NWarning: cannot read pixmap file ");
-- 					io.error.putstring (full_name);
-- 					io.error.new_line;
-- 				end
			else
				Result := Void
-- 				io.error.putstring ("%NWarning: ");
-- 				io.error.putstring (full_name);
-- 				io.error.putstring (" is an invalid file name.");
-- 				io.error.new_line;
			end
		end

end
