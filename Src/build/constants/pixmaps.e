class PIXMAPS

inherit
	CONSTANTS
	
feature -- General Pixmaps

	Alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("align.bm")
		end;

	App_interior_stipple: PIXMAP is
		once
			Result := symbol_file_content ("int_stip.bm")
		end;

	Attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("attrib.bm")
		end;

	Behavior_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("behavior.bm")
		end;

	Behavior_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_dot.bm")
		end;

	Behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("beh_frmt.bm")
		end;

 	Bg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_clrst.bm")
		end;

 	Bg_pixmap_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("bg_pxmap.bm")
		end;

 	Cat_temp_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_tmpw.bm")
 		end;
 
 	Cat_perm_wind_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_prmw.bm")
 		end;
 
 	Cat_bulletin_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bltn.bm")
 		end;
 
 	Cat_menu_entry_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_ment.bm")
 		end;
 
 	Cat_menu_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_mpul.bm")
 		end;
 
 	Cat_opt_pull_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_opul.bm")
 		end;
 
 	Cat_bar_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bar.bm")
 		end;
 
 	Color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color.bm")
		end;

 	Color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("color_st.bm")
		end;

	Command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("instance.bm")
		end;

	Command_instance_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("inst_dot.bm")
		end;

	Command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_page.bm")
		end;

	Command_i_icon_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_inst.bm")
		end;

	Command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("command.bm")
		end;

	Command_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cmd_dot.bm")
		end;

	Create_command_instance_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("crt_inst.bm")
		end;

	Create_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("crt_proj.bm")
		end;

 	Ear_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ear.bm")
		end;

	EiffelBuild_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ebuild.bm");
		end;

	Ev_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ev_label.bm");
		end;

	Event_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("event.bm")
		end;

	Event_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("evnt_dot.bm")
		end;

	Exit_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("exit_lbl.bm")
		end;

	Expand_parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expand.bm")
		end;

	File_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("file.bm");
		end;

 	Fg_color_stone_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("fg_clrst.bm")
		end;

	Font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("font.bm")
		end;

	Full_help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("fullhelp.bm")
		end;

	General_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("general.bm")
		end;

	Generate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("generate.bm")
		end;

	Geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("geometry.bm")
		end;

 	Grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid.bm")
		end;

 	Grid5_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid5.bm")
		end;

 	Grid10_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid10.bm")
		end;

 	Grid15_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid15.bm")
		end;

 	Grid20_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("grid20.bm")
		end;

	Help_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("help.bm")
		end;

	Import_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("import.bm")
		end;

	Initial_state_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("initl_st.bm")
		end;

	Load_project_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("open.xpm")
		end;

	Menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menus.bm")
		end;

	Merge_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("merge.bm");
		end;

	Namer_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("namer.bm")
		end;

	Ok_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ok_tick.bm")
		end

	Parent_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("parent.bm")
		end;

	Parent_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("par_dot.bm")
		end;

	Popup_filename_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_fn.bm")
		end;

	Popup_instances_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_inst.bm")
		end;

	Popup_context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pop_cntx.bm")
		end;

	Predef_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pred_cmd.bm")
		end;

	Primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("primitvs.bm")
		end;

	Quit_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("quit.xpm")
		end;

	Raise_widget_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("raise_wd.bm")
		end;

	Save_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("save.xpm")
		end;

 	Save_as_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("save_as.xpm")
		end;

	Selected_alignment_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("salign.bm")
		end;

	Selected_attribute_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sattrib.bm")
		end;

	Selected_behavior_format_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sbh_frmt.bm")
		end;

	Selected_button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sbutton.bm")
		end;

 	Selected_color_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("scolor.bm")
		end;

	Selected_command_page_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scmd_pge.bm")
		end;

	Selected_drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sdrwn_ar.bm")
		end;

	Selected_file_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sfile.bm");
		end;

	Selected_font_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sfont.bm")
		end;

	Selected_general_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sgeneral.bm")
		end;

	Selected_geometry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sgeomtry.bm")
		end;

 	Selected_grid_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sgrid.bm")
		end;

	Selected_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscrll_l.bm")
		end;

	Selected_scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscrll_w.bm")
		end;

	Selected_resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sresize.bm");
		end;

	Selected_windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("swindows.bm")
		end;

	Selected_primitives_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sprimtvs.bm")
		end;

	Selected_menus_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("smenus.bm")
		end;

	Selected_mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("smouse.bm")
		end;

	Selected_scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("sscale.bm")
		end;
 
 	Selected_groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sgroups.bm")
 		end;
 
 	Selected_sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("ssets.bm")
		end;

	Selected_submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("ssubmenu.bm");
		end;

	Selected_text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("stext.bm");
		end;

	Selected_text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("stxt_fld.bm")
		end;

	Selected_translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("strnsltn.bm")
		end;

	Selected_user_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("susr_def.bm")
		end;

 	Sets_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("sets.bm")
		end;

	Self_label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("self_lbl.bm")
		end;

	Show_window_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("shw_wndw.bm")
		end;

	State_pixmap_small: PIXMAP is
		once
			Result := symbol_file_content ("state_sm.bm")
		end;

	State_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state.bm")
		end;

	State_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("state_dt.bm")
		end;

	Return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("return.bm")
		end;

	Transition_line_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("transitn.bm");
		end;

	Type_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("type.bm")
		end;

	Unsave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("unsave.bm")
		end;

	User_command_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_cmd.bm")
		end;

	User_defined_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("user_def.bm")
		end;

	Wastebasket_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wastbskt.bm")
		end;

	Windows_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("windows.bm")
		end;

feature -- Context Pixmaps

	Arrow_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("arrow_b.bm")
		end;

	Bar_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bar.bm")
		end;

	Bulletin_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("bulletin.bm")
		end;

	Check_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("check_bx.bm")
		end;

	Context_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("context.bm")
		end;

	Context_dot_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("cont_dot.bm")
		end;

	Dialog_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("dialg_sh.bm")
		end;

	Drawing_area_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("drwng_ar.bm")
		end;

 	Group_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.bm")
 		end;
 
 	Groups_pixmap: PIXMAP is
 		once
 			Result := symbol_file_content ("groups.bm")
 		end;
 
	Label_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("label.bm");
		end;

	List_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrll_l.bm")
		end;

	Menu_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_pll.bm")
		end;

	Menu_entry_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("menu_ent.bm")
		end;

	Opt_pull_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("opt_pull.bm")
		end;

	Pict_color_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pictclrb.bm")
		end;

	Push_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("push_b.bm");
		end;

	Top_shell_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("top_shll.bm");
		end;

	Radio_box_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("radio_bx.bm")
		end;

	Scrolled_w_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_w.bm")
		end;

	Scrolled_t_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_t.bm")
		end;

	Separator_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("separatr.bm")
		end;

	Scale_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scale.bm")
		end;
 
	Scroll_list_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scrll_l.bm")
		end;

	Text_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text.bm");
		end;

	Text_field_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("text_fld.bm")
		end;

	Toggle_b_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("toggle_b.bm")
		end;

feature -- Event pixmaps

	Button_arm_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_arm.bm")
		end;

	Button_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_rels.bm")
		end;

	Button_activate_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("but_actv.bm")
		end;

	Button_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("button.bm")
		end;

	Expose_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("expose.bm");
		end;

	Input_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("input.bm");
		end;

	Key_return_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_rtrn.bm");
		end;

	Key_press_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_prss.bm");
		end;

	Key_release_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("key_rels.bm");
		end;

	Mouse1u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1u.bm");
		end;

	Mouse2u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2u.bm");
		end;

	Mouse3u_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3u.bm");
		end;

	Mouse1d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse1d.bm");
		end;

	Mouse2d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse2d.bm");
		end;

	Mouse3d_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse3d.bm");
		end;

	Mouse_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mouse.bm")
		end;

	Mouse_motion1_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt1mouse.bm");
		end;

	Mouse_motion2_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt2mouse.bm");
		end;

	Mouse_motion3_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mt3mouse.bm");
		end;

	Mouse_enter_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mse_entr.bm");
		end;

	Move_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("move.bm");
		end;

	Mouse_leave_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("mse_leav.bm");
		end;

	Pointer_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("pntr_mot.bm");
		end;

	Scr_t_modify_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_modf.bm");
		end;

	Scr_t_motion_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("scr_motn.bm");
		end;

	Selection_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("single.bm");
		end;

	Submenu_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("submenu.bm");
		end;

	Translation_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("transltn.bm")
		end;

	Resize_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("resize.bm");
		end;

	Value_changed_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("changed.bm");
		end;

	Widget_destroy_pixmap: PIXMAP is
		once
			Result := symbol_file_content ("wdgt_dst.bm");
		end;

feature {NONE} -- Read from file

	symbol_file_content (fn: STRING): PIXMAP is
		local
			full_name: FILE_NAME;
		do
			!! full_name.make_from_string (Environment.bitmaps_directory);
			full_name.set_file_name (fn);	
			!! Result.make;
			if full_name.is_valid then
				Result.read_from_file (full_name);
				if not Result.is_valid then 
					io.error.putstring ("Warning: cannot read pixmap file ");
					io.error.putstring (full_name);
					io.error.new_line;
				end
			else
				io.error.putstring ("Warning: ");
				io.error.putstring (full_name);
				io.error.putstring (" is an invalid file name.");
				io.error.new_line;
			end
		end

end
